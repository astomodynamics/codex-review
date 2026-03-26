---
name: create-commit
description: Create and run git commits from current repository changes with a content-aware message. Use when asked to perform a commit workflow, generate a commit message from diffs, handle optional `-m` overrides, or guide staging before commit.
---

# Create Commit

Follow the source workflow in `references/commit-command.md`.

## Workflow

1. Inspect staged changes first.

```bash
git diff --staged --stat
```

2. If nothing is staged, inspect unstaged changes.

```bash
git diff --stat
```

- If unstaged changes exist, ask whether to:
1. Stage all changes and commit.
2. Stage specific files and commit.
3. Stop for manual staging.
- For option 1, run `git add -A`.
- For option 2, run `git add <paths>`.

3. Analyze actual staged content before writing the message.

```bash
git diff --staged --name-only
git diff --staged <file>
```

4. Match repository commit style.

```bash
git log -5 --oneline
```

5. Draft a concise but informative message from the actual change intent.
- Prefer Conventional Commit style when the repo uses it.
- Keep header under 72 characters (target 50-72).
- Make the header specific: what changed and why/impact in one line.
- Use imperative mood.
- If context is non-trivial, add a short body (1-3 lines) with key details.

6. If user provides `-m "<message>"`, use it exactly.

7. Execute commit.

```bash
# Subject only (default)
git commit -m "<generated-subject>"

# Add body only when needed
git commit -m "<generated-subject>" -m "<short body>"
```

8. Report results with commit hash, subject, changed files, and `git status --short`.

## Guardrails

- Do not use `--amend` unless the user explicitly asks.
- Do not add Co-Authored-By footer unless the user explicitly asks.
- Base the message on diffs, not filenames alone.
- Avoid filler text; include only details that improve scanability.
