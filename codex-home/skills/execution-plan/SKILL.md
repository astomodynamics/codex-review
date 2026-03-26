---
name: execution-plan
description: Use for multi-step features, migrations, cross-cutting refactors, or ambiguous tasks that benefit from planning before editing.
---

# Purpose

Use this skill for complex changes when you want to enforce the flow **investigate -> plan -> implement -> validate** instead of jumping straight into edits.

# When to use

- You expect to touch 3 or more files
- The change crosses multiple layers
- The spec is still ambiguous
- Migration, rollout, or phased delivery matters
- The root cause of a bug is not fully pinned down yet

# Do not use

- Simple typo fixes
- Obvious one-file edits
- Small changes where the implementation plan is already concrete

# Workflow

1. Restate the goal, constraints, and done-when
2. Use `code_mapper` when needed to inspect the impact surface and related files
3. Decide whether a thin vertical slice should come first
4. Break the work into phases
5. Assign validation to each phase
6. Make dependencies, parallelizable work, and migration / rollout / rollback considerations explicit
7. Include the point where `reviewer` should be used after implementation if appropriate

# Output template

## Goal
- ...

## Constraints
- ...

## Impacted areas
- ...

## Plan
1. ...
2. ...
3. ...

## Validation
- ...

## Risks
- ...

## Done when
- ...

# Quality bar

- The plan must be executable
- It should be concrete at the file / module / contract level, not just abstract
- If the work is large, show the smallest viable vertical slice first
- Split tasks into atomic, committable units when possible
