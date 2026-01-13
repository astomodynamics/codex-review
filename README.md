# Codex Review Plugin

Integrate Codex CLI (GPT 5.2) for bug analysis, code review, and plan revision with proactive triggering.

## Features

### Execution Modes

Every Codex call lets you choose:
- **Wait for results** (blocking): Claude waits for Codex to finish, shows results immediately
- **Run in background** (parallel): Codex runs in background, Claude continues working, results appear later

### Commands

| Command | Description |
|---------|-------------|
| `/codex-bugs [paths]` | Analyze code for bugs using Codex |
| `/codex-review [paths]` | Review code quality using Codex |
| `/codex-plan` | Review current plan before execution |
| `/codex-security [paths]` | Analyze code for security vulnerabilities using Codex |
| `/codex-architect [topic]` | Architecture and design analysis using Codex |

### Proactive Agents

| Agent | Triggers When |
|-------|---------------|
| `bug-analyzer` | After debugging, code analysis, or implementation |
| `plan-reviewer` | Before presenting a plan for approval |

Both agents **ask permission first** and let you choose the execution mode before delegating to Codex.

## Requirements

- Codex MCP server configured (provides `mcp__codex__codex` tool)
- Claude Code with plugin support

## Installation

The plugin is installed at `~/.claude/plugins/codex-review`.

To use it, ensure Claude Code loads plugins from this directory:
```bash
claude --plugin-dir ~/.claude/plugins/codex-review
```

Or add to your Claude Code configuration.

## Usage

### Explicit Commands

```
# Analyze specific files for bugs
/codex-bugs src/auth/

# Review recent changes
/codex-review

# Review current plan before execution
/codex-plan
```

### Proactive Behavior

The agents trigger automatically:

1. **After debugging**: Claude will ask "Would you like Codex to analyze this code for bugs?"
2. **Before plan approval**: Claude will ask "Would you like Codex to review this plan first?"

You can always decline - agents always ask permission before delegating.

## How It Works

1. **Skill**: The `codex-delegation` skill provides patterns for building 7-section delegation prompts
2. **Commands**: Explicit slash commands for on-demand Codex analysis
3. **Agents**: Proactive triggers that ask permission, then delegate to Codex

All delegation uses `sandbox: "read-only"` by default - Codex analyzes but doesn't modify files.

## Security & Privacy

**Data Handling:**
- All analysis uses `sandbox: "read-only"` - Codex cannot modify your files
- Code snippets are sent to Codex (GPT 5.2) for analysis
- Agents always ask permission before delegating

**Best Practices:**
- Do NOT send code containing API keys, secrets, or credentials
- Avoid sending PII (personally identifiable information)
- Review what files are being analyzed before confirming

**MCP Configuration:**
- Uses stdio transport (no network exposure)
- Authentication handled by Codex CLI (`codex login`)

## Replacing Delegator Rules

This plugin replaces the previous `~/.claude/rules/delegator/` configuration with a cleaner plugin-based approach. You can remove the old delegator rules after testing this plugin.
