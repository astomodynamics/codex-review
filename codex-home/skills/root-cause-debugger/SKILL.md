---
name: root-cause-debugger
description: Use for bug hunts, flaky tests, regressions, runtime exceptions, or confusing behavior where the root cause is not yet known.
---

# Purpose

Use this skill to move from symptom to root cause as directly as possible, then connect that to the smallest fix and the right regression test.

# When to use

- An error or exception is visible but the cause is unclear
- You need to isolate a flaky test or environment-dependent bug
- The issue keeps coming back after an attempted fix
- The logs, stack trace, and relevant diff are scattered

# Do not use

- Simple fixes where the cause is already confirmed
- Requests for new feature design
- Large refactor planning

# Workflow

1. Pin the symptom down to a single sentence
2. Clarify reproduction conditions
3. Gather logs / stack trace / recent diff / failing tests, and build a self-contained log bundle when helpful
4. Capture relevant env / runtime / dependency information only when it matters
5. Use `code_mapper` when execution-path tracing is needed
6. Narrow the problem to 2 or 3 hypotheses
7. Eliminate them starting from the cheapest check
8. Once the root cause is confirmed, hand the smallest fix to `surgical_fixer`
9. Use `test_designer` to define the minimal regression test

# Evidence bundle

Collect these when possible:

- failing command / script
- expected vs actual behavior
- stderr / traceback / assertion
- relevant env vars
- `git status -sb` plus the recent diff
- Failing test name or explicit reproduction steps

# Output template

## Symptom
- ...

## Reproduction
- ...

## Evidence
- ...

## Hypotheses
1. ...
2. ...
3. ...

## Root cause
- ...

## Fix shape
- ...

## Regression test
- ...

# Quality bar

- Distinguish the immediate cause from the deeper root cause
- Narrow the issue using evidence instead of guesswork
- Keep the fix shape minimal
- Return the bundle path too when a reproducible log/evidence bundle exists
