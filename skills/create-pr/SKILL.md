---
name: create-pr
description: Create pull request titles and bodies from branch diffs using the repository PR template (prefer `.github/pull_request_template.md`, fallback to `references/pull_request_template.md`). Use when Codex is asked to draft or open a PR, summarize branch changes for reviewers, or provide reproducible test instructions.
---

# Create PR

## Objective

Produce a reviewer-ready pull request description that matches the repository template exactly and includes concrete validation evidence.

## Required Reference

Load `.github/pull_request_template.md` when present. If it is missing, load `references/pull_request_template.md`. Keep output headings and section order identical.

## Workflow

1. Collect branch context.

```bash
git rev-parse --abbrev-ref HEAD
git status --short
git log --oneline --decorate -n 30
```

2. Compare branch against target branch.

```bash
git diff --stat <base-branch>...HEAD
git diff <base-branch>...HEAD
git log --oneline <base-branch>..HEAD
```

- Use the user-specified base branch.
- If no base branch is provided, use the repository default branch.

3. Gather verification evidence.
- List commands already executed and outcomes.
- Mark checks not run with explicit reason.
- Prefer the smallest relevant lint/test/build checks for changed components.

4. Fill template sections with repository-specific details.
- `Summary`: exactly 2-3 bullets covering intent and high-level impact.
- `Changes`: group by component/package; avoid file dumps.
- `Test Plan`: checklist style with `[x]` or `[ ]` for each verification item.
- `Related Issues`: include `Closes #` / `Related to #` entries when available.
- `How to Test`: provide copy-paste commands that match actual project commands.
- `Screenshots/Videos`: attach or explicitly mark as not applicable.
- `Additional Notes`: note rollout risks, assumptions, and follow-up items.

5. Create PR artifact.
- Draft markdown in a file first for quick edits.
- If asked to open PR, run:

```bash
gh pr create --title "<title>" --body-file <pr-body-file> --base <base-branch>
```

- Keep title concise and behavior-focused.
- Avoid claims not backed by diff or test evidence.

## Output Checklist

- Preserve template headings/order.
- Replace all placeholder text from the template.
- Ensure every test claim maps to a real command or artifact.
- Ensure branch names and verification commands are accurate.
