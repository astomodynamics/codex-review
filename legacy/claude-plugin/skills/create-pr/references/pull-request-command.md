# Source

Derived from a slash-command pull request workflow.
Refresh this reference when your team's PR workflow changes.

# Pull Request Command Reference

## Objective

Analyze current code changes and create a pull request with GitHub CLI.

## Required Behavior

- Read repository diffs to understand what changed.
- Draft a concise PR title and detailed body using the PR template.
- Write the draft markdown to `.pr_description.md` at repository root.
- Execute `gh pr create --title "<title>" --body-file .pr_description.md` as part of the skill workflow.
- Report the `gh pr create` output (PR URL or failure details).

## Core Steps

1. Analyze changes with `git diff` or staged diff.
2. Draft title and description from actual behavior changes.
3. Write `.pr_description.md`.
4. Execute `gh pr create` with `--title` and `--body-file`.
5. Return command output and final PR link when successful.

## Template Sections

- `Summary`
- `Changes`
- `Test Plan`
- `Related Issues`
- `How to Test`
- `Screenshots/Videos`
- `Additional Notes`
