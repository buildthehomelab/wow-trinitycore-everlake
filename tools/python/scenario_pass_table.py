#!/usr/bin/env python3
"""One table for a night of scenario runs: per scenario the runs, the passes, how each failure ended and what killed the raid.

Reads Scenario.log (the "[scenario] result=" blocks the scenario runner writes) and, when given, the Playerbot.log of the same night
(its "[raid_encounter] ... pull end:" lines give the boss's health at a wipe). Any number of files, in any order; lines from other
systems are skipped. Output is a Markdown table on stdout, or into --out.

  python scenario_pass_table.py Scenario.log [Playerbot.log ...] [--filter naxx_] [--out pass-table.md]
"""

import argparse
import collections
import re
import sys

RESULT = re.compile(r"\[scenario\] result=(\w+) name=(\S+) .*?run_s=(\d+)")
FAIL = re.compile(r"\[scenario\] fail kind=(\S+) bot=\S+ at_s=(\d+) ?(.*)")
DEATH = re.compile(r"\[scenario\] warn kind=death bot=(\S+) at_s=(\d+) killed by (.+?), (.+?) -?\d+, at ")
PULL_END = re.compile(r"\[raid_encounter\] .*?pull end: result=(\w+) dur=(\d+)s .*?\| boss ([^|]+?) \|.*?left: (.*)$")
START = re.compile(r"\[scenario\] start name=(\S+)")


def spell_name(raw):
    # "28741 Poison Shock" -> "Poison Shock"; "melee" stays.
    parts = raw.split(" ", 1)
    return parts[1] if len(parts) == 2 and parts[0].isdigit() else raw


def read_runs(paths, name_filter):
    runs = []                       # dicts in file order
    boss_left = collections.defaultdict(list)   # scenario name -> boss health lines at a pull end, in order
    current_start = None
    for path in paths:
        with open(path, encoding="utf-8", errors="replace") as f:
            cur = None
            for line in f:
                m = START.search(line)
                if m:
                    current_start = m.group(1)
                    continue
                m = RESULT.search(line)
                if m:
                    cur = {"result": m.group(1), "name": m.group(2), "run_s": int(m.group(3)), "fail": "", "deaths": [], "left": ""}
                    if not name_filter or name_filter in cur["name"]:
                        runs.append(cur)
                    else:
                        cur = None
                    continue
                m = PULL_END.search(line)
                if m and current_start:
                    left = m.group(4).strip()
                    boss = m.group(3).strip().split(",")[0].strip()
                    hp = re.search(re.escape(boss) + r" (\d+)%", left)
                    boss_left[current_start].append(f"{boss} {hp.group(1)}%" if hp else f"{boss} dead")
                    continue
                if cur is None:
                    continue
                m = FAIL.search(line)
                if m and not cur["fail"]:
                    cur["fail"] = f"{m.group(1)} at {m.group(2)} s"
                    continue
                m = DEATH.search(line)
                if m:
                    cur["deaths"].append((int(m.group(2)), m.group(3), spell_name(m.group(4))))
    # Boss health per run, matched in order within each scenario name.
    seen = collections.Counter()
    for r in runs:
        lst = boss_left.get(r["name"], [])
        i = seen[r["name"]]
        if i < len(lst):
            r["left"] = lst[i]
        seen[r["name"]] += 1
    return runs


def table(runs):
    by_name = collections.OrderedDict()
    for r in runs:
        by_name.setdefault(r["name"], []).append(r)
    out = ["| Scenario | Runs | Passed | Each run | Deaths (last run) | Top killers (all runs) |",
           "|---|---|---|---|---|---|"]
    total_runs = total_pass = 0
    for name, rs in by_name.items():
        passed = sum(1 for r in rs if r["result"] == "PASS")
        total_runs += len(rs)
        total_pass += passed
        each = []
        for r in rs:
            if r["result"] == "PASS":
                each.append(f"PASS {r['run_s']} s")
            else:
                bit = r["fail"] or "fail"
                if r["left"]:
                    bit += f", {r['left']} left"
                each.append(bit)
        killers = collections.Counter()
        for r in rs:
            for _, killer, spell in r["deaths"]:
                killers[f"{killer.split(' (')[0]}: {spell}"] += 1
        top = ", ".join(f"{k} x{n}" for k, n in killers.most_common(3)) or "-"
        first = min((d[0] for d in rs[-1]["deaths"]), default=None)
        deaths = f"{len(rs[-1]['deaths'])}" + (f", first at {first} s" if first is not None else "")
        out.append(f"| {name} | {len(rs)} | {passed} | {'; '.join(each)} | {deaths} | {top} |")
    out.append("")
    out.append(f"{total_pass} of {total_runs} runs passed, {sum(1 for rs in by_name.values() if any(r['result'] == 'PASS' for r in rs))} "
               f"of {len(by_name)} scenarios passed at least once.")
    return "\n".join(out) + "\n"


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("logs", nargs="+", help="Scenario.log, optionally Playerbot.log of the same runs")
    ap.add_argument("--filter", default="", help="only scenarios whose name contains this (e.g. naxx_)")
    ap.add_argument("--out", default="", help="write the table here instead of stdout")
    a = ap.parse_args()
    runs = read_runs(a.logs, a.filter)
    if not runs:
        print("no [scenario] result= lines found", file=sys.stderr)
        return 1
    text = table(runs)
    if a.out:
        with open(a.out, "w", encoding="utf-8") as f:
            f.write(text)
    else:
        sys.stdout.write(text)
    return 0


if __name__ == "__main__":
    sys.exit(main())
