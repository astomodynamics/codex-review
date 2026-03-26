---
description: "Review current plan using Codex (GPT 5.2) before execution"
allowed-tools: Read, Glob, Grep, Bash, mcp__codex__codex, AskUserQuestion, Task
---

# Plan Review with Codex

Delegate plan review to Codex GPT expert. This command sends the current implementation plan to Codex for validation before execution.

## Instructions

1. **Identify the plan**:
   - Check if there's a plan file in the current context
   - Or use the plan from the current conversation context
   - Or ask the user to specify what plan to review

2. **Ask execution mode**:
   Use AskUserQuestion to ask:
   - "How should Codex run?"
   - Options: "Wait for results" (blocking) or "Run in background" (continue working)

3. **Build the delegation prompt**:

```
TASK: Review this implementation plan for completeness, clarity, and feasibility.

EXPECTED OUTCOME: APPROVE/REJECT verdict with specific feedback.

CONTEXT:
- Plan to review:
  [full plan content]
- Goals: [what the plan aims to achieve]
- Constraints: [technical limits, dependencies]

MUST DO:
- Evaluate clarity (are steps specific and unambiguous?)
- Check verifiability (can each step be confirmed complete?)
- Assess completeness (are all necessary steps included?)
- Test feasibility (is the approach realistic?)
- Simulate executing the plan mentally to find gaps

MUST NOT DO:
- Rubber-stamp without analysis
- Provide vague feedback
- Approve plans with critical gaps

OUTPUT FORMAT:
VERDICT: [APPROVE / REJECT]

ASSESSMENT:
- Clarity: [Good/Needs Work] - [explanation]
- Verifiability: [Good/Needs Work] - [explanation]
- Completeness: [Good/Needs Work] - [explanation]
- Feasibility: [Good/Needs Work] - [explanation]

[If REJECT:]
TOP IMPROVEMENTS NEEDED:
1. [Specific improvement]
2. [Specific improvement]
3. [Specific improvement]
```

4. **Call Codex** (based on user's execution mode choice):

**If "Wait for results" (blocking):**
```typescript
mcp__codex__codex({
  prompt: "[your delegation prompt]",
  "developer-instructions": "You are a plan review expert. Validate plans for completeness, clarity, and feasibility. Mentally simulate execution to find gaps. Be ruthlessly critical - find every issue before work begins. Output: APPROVE or REJECT with specific feedback.",
  sandbox: "read-only",
  cwd: "[current working directory]"
})
```

**If "Run in background":**
Use the Task tool with `run_in_background: true`:
```typescript
Task({
  subagent_type: "general-purpose",
  description: "Run Codex plan review",
  prompt: "Call mcp__codex__codex with this prompt: [delegation prompt]. Developer instructions: [plan reviewer instructions]. Sandbox: read-only. Synthesize the results with verdict.",
  run_in_background: true
})
```
Tell the user: "Codex is reviewing the plan in the background. I'll notify you when the verdict is ready. You can continue working."

5. **Synthesize results**:
   - Lead with verdict
   - If REJECT, present improvements needed clearly
   - If APPROVE, highlight any minor suggestions
   - Offer to revise the plan based on feedback

## Example Usage

User: `/codex-plan`

Response flow:
1. Identify current plan from context
2. Ask: "Wait for results or run in background?"
3. Build delegation prompt with full plan
4. Call Codex (blocking or background)
5. Present: "Codex verdict: REJECT. Top improvements needed: ..."
