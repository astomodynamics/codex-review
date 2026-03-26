# Codex Home Backup

This repository is the cloud-backed home for my reusable Codex setup.

The primary content now lives in `codex-home/`, which stores only the reusable
custom surface:

- `codex-home/agents`
- `codex-home/skills`

## Purpose

Use this repository to:

- back up custom Codex agents and skills
- version custom agents and skills
- keep a portable Codex customization layer that can be copied to another machine

Excluded on purpose:

- `AGENTS.md`
- `config.toml`
- `auth.json`
- `history.jsonl`
- logs, sqlite databases, caches, and session state
- other machine-local runtime artifacts

## Repository Layout

- `codex-home/`
  - current Codex-designated agents and skills only
- `legacy/claude-plugin/`
  - archived older Claude Code / mixed plugin-era assets kept only for reference

## Notes

- This repository is now Codex-designated, not Claude-plugin-first.
- The legacy Claude-oriented material remains archived so older ideas and prompts are not lost, but it is no longer the main surface.
