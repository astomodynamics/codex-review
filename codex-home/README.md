# codex-home

This directory is the repository-backed snapshot of the reusable Codex
customization surface only.

Included:

- `agents/`
- `skills/`

Excluded on purpose:

- `AGENTS.md`
- `config.toml`
- `auth.json`
- `history.jsonl`
- logs, caches, sqlite files
- session state and other machine-local runtime data
- machine-specific scripts or paths

Use this directory as cloud storage for custom agents and skills only.
