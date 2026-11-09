# Karrz releases as git history

[Karrz1/Karrz-playerbots-wow-forever](https://github.com/Karrz1/Karrz-playerbots-wow-forever) publishes WoW Forever
Bots near-daily, but its git `main` stopped on 2026-10-21. The real source of each release is only in the release
asset `wow-forever-source-<version>.zip`. To read and port that work like any other upstream, every release is
imported as one commit on branch **`karrz-releases`** of this fork.

## The branch

- Root: advocaite `forever` `f63ffc12b3` (2026-10-09), the commit every release names in its `UPSTREAM_PIN`.
  All 34 releases (v0.1.12 to v0.1.33) keep that pin, so the branch is one straight line.
- One commit per release, oldest first, author Karrz1, dated when the release was published. The commit message
  holds the release notes as Karrz1 published them and the zip's sha256 (checked against the release's
  `SHA256SUMS.txt`). A release whose source did not change (only binaries did) is an empty commit, to keep its notes.
- Tag per release: `karrz-v<version>`.
- The zips do not contain `sql/old/` (and some `.github/` files); the import keeps the base copies, so a commit shows
  only real changes. Everything else in the zip is committed, including the `sql/custom/` data that TrinityCore's
  `.gitignore` would skip.
- Line endings: Karrz's zips are CRLF. `.gitattributes` (`* text=auto`) stores them as LF, except 10 files that
  upstream already stores with CRLF, which keep their upstream bytes.

Useful reads:

```bash
git log --reverse karrz-releases                                  # release notes, release by release
git diff karrz-v0.1.32.1 karrz-v0.1.33 -- src/modules/PlayerbotV2 # what one release changed in the bots
git diff f63ffc12b3 karrz-v0.1.33 -- sql/custom/world             # all of Karrz's world data
```

`karrz-releases` is never merged into `everlake` as a whole: it is a hard fork on a 2026-10-09 core. Changes come
into `everlake` in reviewed batches by area (bots, core, scripts, world data, hotfixes), each logged like the
upstream pull requests in `docs/upstream-prs.md`.

## Importing a new release

```bash
# zips go in their own folder, outside any checkout; nothing in them is run
v=0.1.34
gh release download v$v -R Karrz1/Karrz-playerbots-wow-forever -D <zips>/$v \
  -p "wow-forever-source-$v.zip" -p SHA256SUMS.txt
git -C <karrz-releases worktree> switch karrz-releases
bash contrib/karrz-import/import.sh <zips> <scratch> <karrz-releases worktree> $v
bash contrib/karrz-import/verify.sh <zips> <scratch> <karrz-releases worktree> $v   # expect "OK"
git -C <karrz-releases worktree> push origin karrz-releases karrz-v$v
```

`import.sh` stops on a checksum mismatch. If a new release moves `UPSTREAM_PIN`, the commit message shows the new
pin; record the move here before porting from that release.

## Imported

2026-11-08/09: v0.1.12 to v0.1.33 (34 releases), each checked against its zip with `verify.sh`.
