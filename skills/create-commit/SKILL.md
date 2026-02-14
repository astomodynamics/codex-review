---
name: create-commit
description: Create a git commit with a meaningful content-aware message based on changed files. Use when Codex is asked to run a commit workflow, generate a commit message from diffs, handle optional `-m` message overrides, or guide staging before commit.
---

# Create Commit

## Objective

Create one logical commit with a specific message derived from actual file changes. Do not append any Co-Authored-By footer.

## Required Reference

Load `references/commit-command.md` and treat it as the behavioral source of truth.

## Workflow

1. Check for staged changes first.

```bash
git diff --staged --stat
```

- If staged changes exist, continue to analysis.
- If no staged changes, continue to step 2.

2. If nothing is staged, inspect unstaged changes.

```bash
git diff --stat
```

- If unstaged changes exist, ask user how to proceed:
1. Stage all changes and commit
2. Select specific files to stage
3. Cancel and stage manually first
- For option 1, run `git add -A`.
- For option 2, ask for file paths/patterns and run `git add <paths>`.
- For option 3, stop.

3. Read changed content, not just filenames.

```bash
git diff --staged --name-only
```

- For each staged file (or most important files when many), inspect:
1. Current file content
2. `git diff --staged <file>`
- Base message on what actually changed in behavior.

4. Classify change intent.
- New files: `Add <feature/component>`
- Bug fixes: `Fix <issue>`
- Feature updates: `Update <component> to <behavior>`
- Refactoring: `Refactor <component>`
- Documentation: `Add/Update docs for <topic>`
- Tests: `Add tests for <component>`
- Configuration: `Configure <setting/tool>`

5. Match repository commit style.

```bash
git log -5 --oneline
```

- Detect whether repository uses prefixes like `feat:`/`fix:` and follow that pattern.
- Keep subject line <= 72 chars and use imperative mood.

6. Handle optional override message.
- If user provided `-m "<message>"`, use it directly.
- Still perform staging flow if needed.

7. Commit without Co-Authored-By footer.

```bash
git commit -m "<generated-or-override-message>"
```

- Do not use `--amend` unless explicitly requested.

8. Report result.
- Show commit hash and subject.
- Show `git status --short` to confirm state.
- Offer to push if remote exists.

## Output Format

```markdown
Commit: <hash> <subject>
Files:
- <path>
Status:
- <git status summary>
Next:
- Push now? (yes/no)
```
