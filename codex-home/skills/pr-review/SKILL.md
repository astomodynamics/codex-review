---
name: pr-review
description: Use for final review of a diff, commit, branch, or uncommitted changes, focusing on concrete findings with severity, evidence, and missing tests.
---

# Purpose

Use this skill to keep reviews focused on evidence-backed findings rather than preference-driven comments.

# When to use

- Self-review after implementation
- Final review before opening a PR
- Review of a specific commit / diff / branch
- Broad changes where you want the main risks surfaced quickly

# Do not use

- Early design brainstorming
- Situations where the implementation direction is not decided yet
- Cases where the goal is to gather lots of style-only feedback

# Workflow

1. Fix the exact review target
2. If reviewing a branch, define an explicit range
3. Use `code_mapper` when a short context pass would help
4. Read high-risk changed files first
5. Use `reviewer` to assess correctness / regressions / security / tests
6. Sort findings by severity
7. If there are no findings, still state what was checked and what testing gaps remain

# Output template

## Findings
- Severity:
- File:
- Evidence:
- Why it matters:
- Suggested fix:

## Missing tests
- ...

## Checked areas
- ...

# Quality bar

- Prioritize concrete findings
- Include reproduction conditions, failing paths, and specific files
- Avoid weakly supported generalities
- Do not conclude from a diff snippet alone when surrounding code matters
