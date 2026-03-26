---
name: git-pr
description: Use for drafting a pull request from the current branch diff, writing a PR body file, and creating the PR with GitHub CLI.
---

# Purpose

Use the current branch diff to produce a reproducible PR title and body, then carry the flow through `gh pr create`.

# When to use

- You want to create a PR after implementation
- You want a reviewer-facing summary grounded in the branch diff
- You want `.pr_description.md` generated automatically

# Do not use

- Cases where the diff is still unstable and the PR scope is not settled
- Cases where you only want draft text and not actual PR creation
- Cases where `gh` authentication is missing and execution cannot safely continue

# Workflow

1. Inspect the branch, status, and diff
2. Draft a concise, behavior-focused PR title from the actual changes
3. Fill Summary, Changes, Test Plan, Related Issues, How to Test, Screenshots/Videos, and Additional Notes in order
4. Leave no placeholders and tie every test claim to a real command or an explicit not-run note
5. Write `.pr_description.md` at the repo root
6. Run `gh pr create --title ... --body-file .pr_description.md`
7. Return the PR URL or the failure reason

# Required checks

- `git rev-parse --abbrev-ref HEAD`
- `git status --short`
- `git diff --stat`
- `git diff` when needed

# Output template

## PR draft
- Title:
- Body file: `.pr_description.md`
- Main changes:

## Result
- Command:
- URL or error:

# Guardrails

- Do not claim anything not supported by the diff
- Make every test claim either a real command or a clear not-run note
- Do not leave placeholders behind
- Be explicit when `gh` auth issues block the workflow
- Report the `gh pr create` command path and result, not just the draft text
