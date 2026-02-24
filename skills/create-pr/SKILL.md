---
name: create-pr
description: Generate pull request titles and bodies from branch diffs, then create PRs with GitHub CLI. Use when asked to draft PR descriptions, fill repository PR templates, create `.pr_description.md`, and run `gh pr create`.
---

# Create PR

Follow `references/pull-request-command.md` for behavior and `references/pull_request_template.md` for the body format.

## Workflow

1. Inspect branch and change context.

```bash
git rev-parse --abbrev-ref HEAD
git status --short
git diff --stat
git diff
```

2. Draft PR title and PR body from real diffs.
- Keep title concise and behavior-focused.
- Fill every section in the template from `references/pull_request_template.md`.
- Replace placeholders; avoid leaving empty scaffold content.

3. Write the draft body file at repository root.

```bash
cat > .pr_description.md
```

4. Create the PR with GitHub CLI.

```bash
gh pr create --title "<title>" --body-file .pr_description.md
```

5. Report output:
- Proposed title
- Path to body file
- `gh` command used
- `gh pr create` result (URL or error output)

## Output Checklist

- Preserve template heading order.
- Replace all placeholder text from the template.
- Ensure every test claim maps to a real command or explicit "not run" note.
- Keep examples and commands reproducible for reviewers.
