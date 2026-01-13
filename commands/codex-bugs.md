---
description: "Analyze code for bugs using Codex (GPT 5.2)"
argument-hint: "[file paths or leave empty for recent changes]"
allowed-tools: ["Read", "Glob", "Grep", "Bash", "mcp__codex__codex", "AskUserQuestion", "Task"]
---

# Bug Analysis with Codex

Delegate bug analysis to Codex GPT expert. This command sends code to Codex for thorough bug detection.

## Instructions

1. **Gather context**:
   - If file paths provided, read those files
   - If no paths, identify recently modified files using `git diff --name-only HEAD~3`
   - Read relevant code to include in the delegation

2. **Ask execution mode**:
   Use AskUserQuestion to ask:
   - "How should Codex run?"
   - Options: "Wait for results" (blocking) or "Run in background" (continue working)

3. **Build the delegation prompt** using the 7-section format:

```
TASK: Analyze [files/component] for bugs, logic errors, and potential runtime issues.

EXPECTED OUTCOME: Prioritized list of bugs with severity, location, and fixes.

CONTEXT:
- Current state: [describe what the code does]
- Relevant code:
  [include code snippets or file contents]
- Background: [why analysis is needed - recent changes, reported issues, etc.]

CONSTRAINTS:
- [Language/framework versions]
- [Dependencies]
- [What cannot change]

MUST DO:
- Check error handling paths
- Verify boundary conditions
- Look for null/undefined handling
- Check type safety

MUST NOT DO:
- Suggest architectural changes
- Propose new dependencies
- Nitpick style

OUTPUT FORMAT:
For each bug:
- Location: [file:line]
- Severity: [Critical/High/Medium/Low]
- Issue: [description]
- Impact: [what could happen]
- Fix: [how to resolve]

SUMMARY: [counts by severity]
```

4. **Call Codex** (based on user's execution mode choice):

**If "Wait for results" (blocking):**
```typescript
mcp__codex__codex({
  prompt: "[your delegation prompt]",
  "developer-instructions": "You are a bug analysis expert. Find bugs, logic errors, edge cases, and runtime issues. Prioritize: 1) Correctness 2) Edge cases 3) Runtime errors 4) Concurrency. Output bugs by severity with location, issue, impact, and fix.",
  sandbox: "read-only",
  cwd: "[current working directory]"
})
```

**If "Run in background":**
Use the Task tool with `run_in_background: true`:
```typescript
Task({
  subagent_type: "general-purpose",
  description: "Run Codex bug analysis",
  prompt: "Call mcp__codex__codex with this prompt: [delegation prompt]. Developer instructions: [bug analyzer instructions]. Sandbox: read-only. Synthesize the results.",
  run_in_background: true
})
```
Tell the user: "Codex is analyzing in the background. I'll notify you when results are ready. You can continue working."

5. **Synthesize results**:
   - Present critical/high severity bugs first
   - Group by file or component
   - Add your assessment of which bugs are most important to fix
   - Offer to help fix the identified bugs

## Example Usage

User: `/codex-bugs src/auth/`

Response flow:
1. Read files in src/auth/
2. Ask: "Wait for results or run in background?"
3. Build delegation prompt with code context
4. Call Codex (blocking or background based on choice)
5. Present results (immediately if blocking, later if background)
