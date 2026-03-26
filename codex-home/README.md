# codex-home

This directory is the repository-backed snapshot of the reusable Codex
customization surface only.

Included:

- `agents/`
- `skills/`

Currently kept here because they are user-developed/customized:

- custom agents:
  - `code_mapper`
  - `docs_researcher`
  - `reviewer`
  - `surgical_fixer`
  - `test_designer`
- custom skills:
  - `codex-delegation`
  - `execution-plan`
  - `git-commit`
  - `git-issue`
  - `git-pr`
  - `pr-review`
  - `root-cause-debugger`
  - `safe-refactor`
  - `talk-it-through`
  - `test-matrix`

Excluded on purpose:

- global or machine-local Codex config files
- local auth, history, and runtime state files
- logs, caches, sqlite files, and session state
- machine-specific scripts or paths
- bundled or third-party skills not developed by me

Use this directory as cloud storage for custom agents and skills only.
