#!/usr/bin/env bash
# Everlake daily upstream check: lists what upstream has that `everlake` has not sorted yet. Read-only: it fetches,
# compares and prints Markdown on stdout; it never merges, pushes or changes a branch.
#
#   (a) advocaite/TrinityCore pull requests open on `forever` / `forever-bots` with no review log
#       (docs/upstream-prs/advocaite-<n>.md), and whether each still merges into `everlake` without conflicts;
#   (b) TrinityCore `master` commits since `everlake`'s branch point that are not in `everlake` (matched by
#       `git patch-id`, so a commit picked under another hash counts as in) and have no review log
#       (docs/upstream-prs/trinitycore-<first 10 characters>.md);
#   (c) commits on advocaite `forever` / `forever-bots` that are not in `everlake`: merged pull requests (with or
#       without a review log) and direct pushes (not matched by patch id).
#
# Usage: everlake-upstream-check.sh [everlake ref]   (default: the current HEAD)
# Needs: a clone with full history of `everlake`, network access to github.com, `gh` (logged in, or GH_TOKEN) for the
# pull request list, git 2.38 or later (merge-tree --write-tree).
set -euo pipefail

EVERLAKE=$(git rev-parse --verify "${1:-HEAD}^{commit}")
TC_URL=https://github.com/TrinityCore/TrinityCore.git
ADV_URL=https://github.com/advocaite/TrinityCore.git
ADV_REPO=advocaite/TrinityCore
LOGS=docs/upstream-prs
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

fetch() { git fetch --quiet --no-tags "$@"; }

fetch "$TC_URL" "+refs/heads/master:refs/upstream-check/tc-master"
fetch "$ADV_URL" "+refs/heads/forever:refs/upstream-check/forever" "+refs/heads/forever-bots:refs/upstream-check/forever-bots"
TC=refs/upstream-check/tc-master

# review logs present on everlake
git ls-tree --name-only "$EVERLAKE" "$LOGS/" | sed 's#.*/##' > "$WORK/logs"
has_log() { grep -qxF "$1" "$WORK/logs"; }

# patch ids of everything everlake has since it branched from TrinityCore master
BASE=$(git merge-base "$EVERLAKE" "$TC")
git log -p --no-merges "$BASE..$EVERLAKE" | git patch-id --stable | cut -d' ' -f1 | sort -u > "$WORK/everlake.pid"
in_everlake() { grep -qxF "$1" "$WORK/everlake.pid"; }
patch_id() { git show -p --no-merges "$1" | git patch-id --stable | cut -d' ' -f1; }

short() { git rev-parse --short=10 "$1"; }
subject() { git log -1 --format=%s "$1" | sed 's/|/\\|/g'; }

echo "# Upstream check"
echo
echo "\`everlake\` at $(short "$EVERLAKE"), $(date -u '+%Y-%m-%d %H:%M UTC'). Nothing here is merged automatically:"
echo "each item gets a review (docs/upstream-prs.md) and comes in by its own pull request."
echo

# (a) open pull requests without a review log
gh pr list -R "$ADV_REPO" --state open --limit 1000 \
    --json number,title,baseRefName,author,createdAt \
    --jq '.[] | select(.baseRefName == "forever" or .baseRefName == "forever-bots")
          | [.number, .baseRefName, .author.login, .createdAt[0:10], .title] | @tsv' \
    | sort -n > "$WORK/prs.tsv"
total_prs=$(wc -l < "$WORK/prs.tsv" | tr -d ' ')
: > "$WORK/prs_new.tsv"
while IFS=$'\t' read -r number base author created title; do
    has_log "advocaite-$number.md" || printf '%s\t%s\t%s\t%s\t%s\n' "$number" "$base" "$author" "$created" "$title" >> "$WORK/prs_new.tsv"
done < "$WORK/prs.tsv"
new_prs=$(wc -l < "$WORK/prs_new.tsv" | tr -d ' ')

echo "## (a) advocaite pull requests not reviewed yet: $new_prs of $total_prs open"
echo
if [ "$new_prs" -gt 0 ]; then
    refspecs=()
    while IFS=$'\t' read -r number _; do refspecs+=("+refs/pull/$number/head:refs/upstream-check/pr/$number"); done < "$WORK/prs_new.tsv"
    fetch "$ADV_URL" "${refspecs[@]}"
    echo "| PR | base | author | opened | merges into \`everlake\` | title |"
    echo "|---|---|---|---|---|---|"
    while IFS=$'\t' read -r number base author created title; do
        # exit 0: clean, 1: conflicts (not --quiet: with git 2.53 it exits 0 for a merge that conflicts)
        rc=0
        git merge-tree --write-tree --name-only "$EVERLAKE" "refs/upstream-check/pr/$number" > /dev/null 2>&1 || rc=$?
        case $rc in
            0) merges=clean ;;
            1) merges="**conflicts**" ;;
            *) merges="not checked (merge-tree error $rc)" ;;
        esac
        echo "| [#$number](https://github.com/$ADV_REPO/pull/$number) | $base | $author | $created | $merges | ${title//|/\\|} |"
    done < "$WORK/prs_new.tsv"
    echo
fi

# (b) TrinityCore master commits not in everlake and not logged
: > "$WORK/tc_new"
in_count=0; logged_count=0
while read -r commit; do
    if has_log "trinitycore-$(short "$commit").md"; then
        logged_count=$((logged_count + 1))
    elif in_everlake "$(patch_id "$commit")"; then
        in_count=$((in_count + 1))
    else
        echo "$commit" >> "$WORK/tc_new"
    fi
done < <(git rev-list --reverse --no-merges "$BASE..$TC")
tc_total=$((in_count + logged_count + $(wc -l < "$WORK/tc_new" | tr -d ' ')))

echo "## (b) TrinityCore \`master\` commits not sorted yet: $(wc -l < "$WORK/tc_new" | tr -d ' ') of $tc_total since $(short "$BASE")"
echo
echo "$logged_count have a review log, $in_count more are in \`everlake\` under another hash (same patch id) without one."
echo
if [ -s "$WORK/tc_new" ]; then
    echo "| commit | date | author | subject |"
    echo "|---|---|---|---|"
    while read -r commit; do
        echo "| [$(short "$commit")](https://github.com/TrinityCore/TrinityCore/commit/$commit) | $(git log -1 --format=%as "$commit") | $(git log -1 --format=%an "$commit") | $(subject "$commit") |"
    done < "$WORK/tc_new"
    echo
fi

# (c) advocaite branch commits not in everlake
echo "## (c) advocaite \`forever\` / \`forever-bots\` commits not in \`everlake\`"
echo
: > "$WORK/seen"
rows=0
for branch in forever forever-bots; do
    while read -r commit; do
        grep -qxF "$commit" "$WORK/seen" && continue
        echo "$commit" >> "$WORK/seen"
        parents=$(git rev-list --parents -n 1 "$commit" | wc -w)
        subj=$(subject "$commit")
        if [ "$parents" -gt 2 ]; then
            number=$(sed -n 's/^Merge pull request #\([0-9]*\) .*/\1/p' <<< "$subj")
            if [ -n "$number" ]; then
                has_log "advocaite-$number.md" && kind="merged PR #$number (reviewed)" || kind="merged PR #$number (**no review log**)"
            else
                kind="merge"
            fi
        else
            in_everlake "$(patch_id "$commit")" && continue
            kind="**direct push**"
        fi
        if [ "$rows" -eq 0 ]; then
            echo "| commit | branch | date | author | kind | subject |"
            echo "|---|---|---|---|---|---|"
        fi
        rows=$((rows + 1))
        echo "| [$(short "$commit")](https://github.com/$ADV_REPO/commit/$commit) | $branch | $(git log -1 --format=%as "$commit") | $(git log -1 --format=%an "$commit") | $kind | $subj |"
    done < <(git rev-list --reverse --first-parent "$EVERLAKE..refs/upstream-check/$branch")
done
[ "$rows" -eq 0 ] && echo "None: \`everlake\` has everything on both branches."
echo
