# Codex Review Plugin

Integrate Codex CLI (GPT 5.2) for bug analysis, code review, implementation planning, and plan revision with proactive triggering.

## Features

### Execution Modes

Every Codex call lets you choose:
- **Wait for results** (blocking): Claude waits for Codex to finish, shows results immediately
- **Run in background** (parallel): Codex runs in background, Claude continues working, results appear later

### Commands

| Command | Description |
|---------|-------------|
| `/commit [-m 'msg']` | Create git commit with meaningful message (no Claude footer) |
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

### Skills

| Skill | Description |
|-------|-------------|
| `codex-delegation` | Patterns for building 7-section delegation prompts |
| `codex-plan-mode` | Create comprehensive implementation plans using Codex |

**Codex Plan Mode** is a 5-phase workflow for creating detailed implementation plans:

1. **Requirements Gathering** - Clarify what to implement
2. **Codebase Exploration** - Find relevant files and patterns
3. **Context Building** - Synthesize findings
4. **Codex Delegation** - Generate detailed plan with file paths
5. **Synthesis & Validation** - Present and optionally validate the plan

Invoke with: "use codex plan mode to implement [feature]"

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
# Create a commit with content-aware message (no Claude footer)
/commit

# Commit with custom message
/commit -m "Fix authentication bug"

# Analyze specific files for bugs
/codex-bugs src/auth/

# Review recent changes
/codex-review

# Review current plan before execution
/codex-plan

# Create implementation plan with Codex
"use codex plan mode to implement user authentication"
```

### Commit Command

The `/commit` command creates git commits with meaningful messages based on actual file content:

- **Reads file content**: Analyzes what actually changed, not just file names
- **Matches repo style**: Checks recent commits to follow existing conventions
- **No Claude footer**: Omits the Co-Authored-By line (unlike built-in commit)
- **Smart staging**: Asks before staging unstaged files

### Proactive Behavior

The agents trigger automatically:

1. **After debugging**: Claude will ask "Would you like Codex to analyze this code for bugs?"
2. **Before plan approval**: Claude will ask "Would you like Codex to review this plan first?"

You can always decline - agents always ask permission before delegating.

## How It Works

1. **Skills**:
   - `codex-delegation` provides patterns for building 7-section delegation prompts
   - `codex-plan-mode` guides comprehensive implementation planning
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
