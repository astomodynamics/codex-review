# Source

Derived from a slash-command commit workflow.
Refresh this reference when your team's commit workflow changes.

# Commit Command Reference

## Objective

Generate a Conventional Commit message and execute the commit command.

## Required Behavior

- Analyze staged diff content first, not only filenames.
- If nothing is staged, inspect unstaged changes and decide staging mode.
- Classify intent and draft `<type>(scope?): <summary>` when repository style supports it.
- Keep subject line under 72 characters.
- Respect optional `-m` override exactly when provided.
- Execute `git commit -m "<message>"`.
- Avoid `--amend` unless explicitly requested.
- Do not add Co-Authored-By footer unless explicitly requested.

## Core Steps

1. `git diff --staged --stat`
2. If empty: `git diff --stat`
3. `git diff --staged --name-only` then `git diff --staged <file>`
4. `git log -5 --oneline` for style matching
5. `git commit -m "<message>"`
