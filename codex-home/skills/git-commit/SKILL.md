---
name: git-commit
description: Use for creating a commit from staged or unstaged changes, matching repository commit style and executing git commit safely.
---

# Purpose

Inspect the change, decide on the right staging mode, and create a safe commit with a message that matches the repository style.

# When to use

- You want to create a commit after implementation
- You want the commit message to be based on the actual diff
- You need help deciding whether the staged or unstaged state should be committed

# Do not use

- Cases that require `--amend`
- rebase / squash / history rewrite
- Large in-progress work where the user has not decided what should be committed yet

# Workflow

1. Check staged changes first
2. If staged is empty, check unstaged changes
3. If unstaged changes exist, explicitly choose stage all / stage specific files / stop for manual staging
4. Read the actual staged diff and inspect recent commit style in the repo
5. Draft a specific commit subject
6. Prefer `<type>(scope?): <summary>` when the repo uses Conventional Commits
7. Keep the header under about 72 characters and add a short body only when needed
8. Run `git commit` and report the result

# Required checks

- `git diff --staged --stat`
- `git diff --stat` when needed
- `git diff --staged --name-only`
- File-specific staged diff when needed
- `git log -5 --oneline`

# Staging decisions

- stage all: `git add -A`
- stage specific files: `git add <paths>`
- manual staging: stop before committing and report the current state plus the next required action

# Output template

## Commit plan
- Staging mode:
- Message:
- Why:

## Result
- Commit:
- Files:
- Remaining status:

# Guardrails

- Do not write the message without reading the diff
- Do not use `--amend` unless the user asks
- Do not add a co-author trailer unless the user asks
- Do not stage unrelated files on your own
- Base the message on the actual diff, not just filenames
- If the user provided `-m "<message>"`, use it exactly
