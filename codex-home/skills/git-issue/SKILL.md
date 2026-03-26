---
name: git-issue
description: Use for reading an issue, summarizing the problem, mapping likely impact, and producing an implementation or investigation plan.
---

# Purpose

Use this skill to understand an issue before jumping into implementation: what the problem is, where it likely matters, and how work should begin.

# When to use

- You want to build a starting plan from an issue number or URL
- You want to clarify the issue requirements and done-when
- The issue looks broad enough that investigation should come first

# Do not use

- Simple fixes where the root cause and target files are already known
- Cases where the goal is issue creation itself
- Empty issues with no usable information and no extra context

# Workflow

1. Lock down the issue source
2. Use `gh issue view` when possible to read the body, acceptance criteria, and related context
3. Summarize the issue as Goal / constraints / done-when
4. Use `code_mapper` when needed to inspect entry points and likely impact
5. Use `docs_researcher` when needed to check contracts, README, or ADR consistency
6. Produce either an implementation plan or an investigation plan
7. Show the unknowns, blockers, and the safest first place to start

# Output template

## Issue summary
- Goal:
- Constraints:
- Done when:

## Likely impact
- Entry points:
- Relevant files / modules:
- Risks / unknowns:

## Suggested next steps
1. ...
2. ...
3. ...

## Validation outline
- ...

# Guardrails

- Do not overstate anything when the issue body is incomplete
- Do not jump straight to implementation; turn the issue into an actionable plan first
- If `gh` is unavailable, use pasted issue text as the source of truth
- This skill is for triage, so do not close or mutate issues on your own
