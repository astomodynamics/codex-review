---
name: safe-refactor
description: Use when behavior should stay the same but structure should improve, such as extracting functions, reducing duplication, clarifying names, or separating responsibilities.
---

# Purpose

Use this skill to improve readability, maintainability, and local structure without changing behavior.

# When to use

- Removing duplication
- Splitting functions
- Separating responsibilities
- Clarifying naming
- Simplifying very long conditionals or methods

# Do not use

- Spec changes
- Large rewrites that also pursue performance gains
- Changes that alter a public API, schema, or persistence contract

# Workflow

1. List the invariants that must stay true
2. Check what is already guarded by existing tests or types
3. Split the work into small steps
4. Make each step easy to validate with format / lint / test
5. Use `test_designer` if you need to fill testing gaps
6. Use `reviewer` at the end to confirm regression risk

# Output template

## Invariants
- ...

## Refactor steps
1. ...
2. ...
3. ...

## Validation
- ...

## Behavior unchanged because
- ...

# Quality bar

- Do not mix in new features
- Keep the diff easy to review
- If you change responsibility boundaries, explain why
