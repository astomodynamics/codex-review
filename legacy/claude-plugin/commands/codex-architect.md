---
description: "Architecture and design analysis using Codex (GPT 5.2)"
argument-hint: "[topic, component, or question to analyze]"
allowed-tools: Read, Glob, Grep, Bash, mcp__codex__codex, AskUserQuestion, Task
---

# Architecture Analysis with Codex

Delegate architecture and design analysis to Codex GPT expert. This command sends design questions, system components, or tradeoff analyses to Codex for expert architectural guidance.

## Instructions

1. **Gather context**:
   - If specific topic provided, identify related code and documentation
   - If analyzing a component, read its implementation and dependencies
   - If comparing options, gather details on each approach
   - Use Glob/Grep to find relevant patterns in the codebase
   - Read architecture docs if they exist (README, docs/, etc.)

2. **Ask execution mode**:
   Use AskUserQuestion to ask:
   - "How should Codex run?"
   - Options: "Wait for results" (blocking) or "Run in background" (continue working)

3. **Build the delegation prompt** using the 7-section format:

```
TASK: [Analyze/Design/Evaluate] [system/component/decision] for [specific goal or question].

EXPECTED OUTCOME: Clear recommendation with rationale, tradeoffs analyzed, and effort estimate.

CONTEXT:
- Current architecture: [describe existing system structure]
- Relevant code:
  [include code snippets, file paths, or design docs]
- Problem/Goal: [what needs to be solved or decided]
- Constraints: [scale requirements, existing integrations, team expertise]

CONSTRAINTS:
- [Technology stack]
- [Scale/performance requirements]
- [Existing systems that cannot change]
- [Timeline/resource limitations]

MUST DO:
- Analyze tradeoffs explicitly (pros/cons of each option)
- Consider operational complexity, not just development
- Evaluate scalability and maintainability
- Provide concrete recommendation, not "it depends"
- Include effort estimate (Quick: <1 day, Short: 1-3 days, Medium: 1-2 weeks, Large: >2 weeks)
- Justify recommendations with specific reasoning

MUST NOT DO:
- Over-engineer for hypothetical future needs
- Recommend trendy tech without clear benefit
- Ignore operational/maintenance burden
- Provide vague "consider all options" non-answers
- Suggest rewrites when iteration would work

OUTPUT FORMAT:
BOTTOM LINE: [Clear recommendation in 1-2 sentences]

ANALYSIS:
[Option A]:
- Pros: [specific advantages]
- Cons: [specific disadvantages]
- When to choose: [conditions]

[Option B]:
- Pros: [specific advantages]
- Cons: [specific disadvantages]
- When to choose: [conditions]

RECOMMENDATION: [Detailed explanation of why this choice]

IMPLEMENTATION APPROACH:
1. [Step 1]
2. [Step 2]
3. [Step 3]

EFFORT ESTIMATE: [Quick/Short/Medium/Large] - [justification]

RISKS AND MITIGATIONS:
- [Risk 1]: [Mitigation]
- [Risk 2]: [Mitigation]
```

4. **Call Codex** (based on user's execution mode choice):

**If "Wait for results" (blocking):**
```typescript
mcp__codex__codex({
  prompt: "[your delegation prompt]",
  "developer-instructions": "You are a pragmatic software architect. Philosophy: Simplest solution that works. Avoid over-engineering. Consider operational burden, not just development ease. Give concrete recommendations, not wishy-washy 'it depends' answers. Analyze tradeoffs explicitly. Include effort estimates. Your recommendation should be actionable immediately. If asked about tradeoffs, always pick a side and explain why.",
  sandbox: "read-only",
  cwd: "[current working directory]"
})
```

**If "Run in background":**
Use the Task tool with `run_in_background: true`:
```typescript
Task({
  subagent_type: "general-purpose",
  description: "Run Codex architecture analysis",
  prompt: "Call mcp__codex__codex with this prompt: [delegation prompt]. Developer instructions: You are a pragmatic software architect. Philosophy: Simplest solution that works. Avoid over-engineering. Give concrete recommendations with effort estimates. Sandbox: read-only. Synthesize the results with bottom-line recommendation and implementation approach.",
  run_in_background: true
})
```
Tell the user: "Codex is analyzing architecture in the background. I'll notify you when results are ready. You can continue working."

5. **Synthesize results**:
   - Lead with the bottom-line recommendation
   - Present tradeoff analysis concisely
   - Highlight implementation approach
   - Include effort estimate prominently
   - Add your assessment of the recommendation's fit for the specific context
   - Note any risks or considerations specific to this codebase
   - Offer to help implement the recommended approach

## Example Usage

User: `/codex-architect should we use Redis or in-memory caching`

Response flow:
1. Read relevant caching code and understand current state
2. Ask: "Wait for results or run in background?"
3. Build delegation prompt with scale requirements and existing infrastructure
4. Call Codex (blocking or background based on choice)
5. Present: "Codex recommendation: Use Redis. Bottom line: Your scale requirements and multi-instance deployment make Redis necessary. Effort: Short (1-3 days). Here's the implementation approach..."

User: `/codex-architect src/database/`

Response flow:
1. Read database schema and access patterns
2. Ask: "Wait for results or run in background?"
3. Build delegation prompt asking for schema review and optimization opportunities
4. Call Codex
5. Present architectural analysis with specific recommendations
