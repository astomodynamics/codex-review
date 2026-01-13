---
description: "Review code quality using Codex (GPT 5.2)"
argument-hint: "[file paths or leave empty for recent changes]"
allowed-tools: ["Read", "Glob", "Grep", "Bash", "mcp__codex__codex", "AskUserQuestion", "Task"]
---

# Code Review with Codex

Delegate code review to Codex GPT expert. This command sends code to Codex for quality, patterns, and maintainability review.

## Instructions

1. **Gather context**:
   - If file paths provided, read those files
   - If no paths, get recent changes: `git diff HEAD~3` or staged changes: `git diff --cached`
   - Read the relevant code to include in delegation

2. **Ask execution mode**:
   Use AskUserQuestion to ask:
   - "How should Codex run?"
   - Options: "Wait for results" (blocking) or "Run in background" (continue working)

3. **Build the delegation prompt**:

```
TASK: Review [files/component] for code quality, patterns, and maintainability.

EXPECTED OUTCOME: Issues list with verdict (APPROVE/REQUEST CHANGES/REJECT).

CONTEXT:
- Current state: [describe what the code does]
- Relevant code:
  [include code snippets]
- Recent changes: [what was modified and why]

CONSTRAINTS:
- [Language/framework]
- [Project conventions]
- [Performance requirements if any]

MUST DO:
- Check correctness
- Identify performance issues
- Evaluate maintainability
- Verify pattern consistency

MUST NOT DO:
- Nitpick formatting/style
- Flag theoretical concerns
- Suggest unnecessary abstractions

OUTPUT FORMAT:
ISSUES:
- [Issue with location and recommendation]

VERDICT: [APPROVE / REQUEST CHANGES / REJECT]
SUMMARY: [1-2 sentence assessment]
```

4. **Call Codex** (based on user's execution mode choice):

**If "Wait for results" (blocking):**
```typescript
mcp__codex__codex({
  prompt: "[your delegation prompt]",
  "developer-instructions": "You are a code review expert focused on quality, patterns, and maintainability. Priorities: 1) Correctness 2) Performance 3) Maintainability 4) Patterns. Do NOT nitpick style. Give verdict: APPROVE/REQUEST CHANGES/REJECT.",
  sandbox: "read-only",
  cwd: "[current working directory]"
})
```

**If "Run in background":**
Use the Task tool with `run_in_background: true`:
```typescript
Task({
  subagent_type: "general-purpose",
  description: "Run Codex code review",
  prompt: "Call mcp__codex__codex with this prompt: [delegation prompt]. Developer instructions: [code reviewer instructions]. Sandbox: read-only. Synthesize the results with verdict.",
  run_in_background: true
})
```
Tell the user: "Codex is reviewing in the background. I'll notify you when the verdict is ready. You can continue working."

5. **Synthesize results**:
   - Lead with the verdict
   - Present issues grouped by importance
   - Add your assessment
   - Offer to help address the issues

## Example Usage

User: `/codex-review`

Response flow:
1. Get recent git changes
2. Ask: "Wait for results or run in background?"
3. Read modified files
4. Build delegation prompt
5. Call Codex (blocking or background)
6. Present: "Codex verdict: REQUEST CHANGES. Key issues: ..."
