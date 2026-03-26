---
name: test-matrix
description: Use for deciding the minimal sufficient test set for a change, including happy path, edge cases, regressions, contracts, and anti-flake measures.
---

# Purpose

Use this skill to define what should be tested and how much testing is actually sufficient.

# When to use

- Test design for a new feature
- Regression test design after a bug fix
- Gap analysis for existing tests
- Stabilizing a flaky test

# Do not use

- Cases where the spec is still too unclear for test implementation
- Tasks driven only by a coverage number
- Situations where the test matrix would become extremely expensive to run

# Workflow

1. Summarize the responsibility of the change in one sentence
2. Break the test target down by layer
3. Lay out happy path / failure path / boundary / contract / regression cases
4. Split the minimum sufficient set from optional additions
5. Exclude cases that are likely to become brittle
6. Match the existing testing style in the repo

# Output template

## Minimal set
- ...

## Edge cases
- ...

## Regression cases
- ...

## Cases to avoid
- ...

# Quality bar

- The purpose of each test should be obvious
- The set should be sufficient for the change without being excessive
- Avoid over-coupling to implementation details
