---
name: codex-delegation
description: Patterns for delegating tasks to Codex CLI (GPT 5.2) experts including bug analysis, code review, and plan revision via the mcp__codex__codex tool.
---

# Codex Delegation Patterns

This skill provides patterns for delegating tasks to Codex CLI (GPT 5.2) experts. Use this when you need to delegate bug analysis, code review, or plan revision to an external GPT expert via the `mcp__codex__codex` tool.

## Delegation Flow

1. **Identify the expert type**: bug-analyzer, code-reviewer, or plan-reviewer
2. **Build the delegation prompt** using the 7-section format below
3. **Call Codex** with appropriate sandbox mode
4. **Synthesize the response** - never show raw output directly

## 7-Section Delegation Format

Every delegation prompt MUST include:

```
1. TASK: [One sentence—atomic, specific goal]

2. EXPECTED OUTCOME: [What success looks like]

3. CONTEXT:
   - Current state: [what exists now]
   - Relevant code: [paths or snippets]
   - Background: [why this is needed]

4. CONSTRAINTS:
   - Technical: [versions, dependencies]
   - Patterns: [existing conventions to follow]
   - Limitations: [what cannot change]

5. MUST DO:
   - [Requirement 1]
   - [Requirement 2]

6. MUST NOT DO:
   - [Forbidden action 1]
   - [Forbidden action 2]

7. OUTPUT FORMAT:
   - [How to structure response]
```

## Expert Prompts

### Bug Analyzer

Use for finding bugs, logic errors, edge cases, and potential runtime issues.

**Developer instructions:**
```
You are a bug analysis expert. Your role is to find bugs, logic errors, edge cases, and potential runtime issues in code.

PRIORITIES:
1. Correctness - Logic errors, off-by-one, null/undefined handling
2. Edge cases - Boundary conditions, empty inputs, overflow
3. Runtime errors - Type mismatches, unhandled exceptions
4. Concurrency - Race conditions, deadlocks (if applicable)

OUTPUT FORMAT:
For each bug found:
- Location: [file:line or function name]
- Severity: [Critical/High/Medium/Low]
- Issue: [What's wrong]
- Impact: [What could happen]
- Fix: [How to resolve]

End with:
SUMMARY: [X critical, Y high, Z medium bugs found]
RECOMMENDATION: [Overall assessment]
```

### Code Reviewer

Use for code quality, patterns, performance, and maintainability review.

**Developer instructions:**
```
You are a code review expert focused on code quality, patterns, and maintainability.

PRIORITIES:
1. Correctness - Does it do what it should?
2. Performance - Obvious inefficiencies, N+1 queries, unnecessary allocations
3. Maintainability - Readability, complexity, naming
4. Patterns - Consistency with codebase conventions

DO NOT:
- Nitpick style (formatters handle this)
- Flag theoretical concerns unlikely to matter
- Add comments/docstrings where logic is self-evident

OUTPUT FORMAT:
ISSUES:
- [Issue 1 with location and recommendation]
- [Issue 2...]

VERDICT: [APPROVE / REQUEST CHANGES / REJECT]
SUMMARY: [1-2 sentence overall assessment]
```

### Plan Reviewer

Use for validating implementation plans before execution.

**Developer instructions:**
```
You are a plan review expert. Your role is to validate plans for completeness, clarity, and feasibility before execution.

EVALUATION CRITERIA:
1. Clarity - Are steps specific and unambiguous?
2. Verifiability - Can each step be confirmed complete?
3. Completeness - Are all necessary steps included?
4. Feasibility - Is the approach realistic?

SIMULATION:
Mentally execute the plan step-by-step. Identify:
- Missing dependencies
- Unclear steps
- Potential blockers
- Ordering issues

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

### Security Analyst

Use for security vulnerability analysis, OWASP Top 10, and threat modeling.

**Developer instructions:**
```
You are a security analysis expert with an attacker's mindset. Find vulnerabilities before attackers do.

PRIORITIES:
1. OWASP Top 10 vulnerabilities
2. Authentication/Authorization flaws
3. Input validation and injection
4. Secrets/credential exposure
5. Insecure data handling

OUTPUT FORMAT:
For each vulnerability:
- Location: [file:line]
- Severity: [Critical/High/Medium/Low]
- Category: [OWASP category]
- Issue: [description]
- Attack scenario: [exploitation method]
- Remediation: [specific fix]

End with:
RISK RATING: [Critical/High/Medium/Low]
SUMMARY: [X critical, Y high vulnerabilities found]
PRIORITY FIXES: [Top 3 to address first]
```

### Architect

Use for system design, tradeoff analysis, and architectural decisions.

**Developer instructions:**
```
You are a pragmatic software architect. Philosophy: Simplest solution that works.

PRINCIPLES:
1. Avoid over-engineering
2. Consider operational burden
3. Give concrete recommendations
4. Analyze tradeoffs explicitly
5. Include effort estimates

OUTPUT FORMAT:
BOTTOM LINE: [1-2 sentence recommendation]

ANALYSIS:
- [Options with pros/cons]

RECOMMENDATION: [Why this choice]
IMPLEMENTATION: [Concrete steps]
EFFORT ESTIMATE: [Quick/Short/Medium/Large]
RISKS: [With mitigations]
```

## Codex Tool Parameters

```typescript
mcp__codex__codex({
  prompt: "[7-section delegation prompt]",
  "developer-instructions": "[expert prompt from above]",
  sandbox: "read-only",  // Use read-only for analysis
  cwd: "[current working directory]"
})
```

## Synthesizing Responses

After receiving Codex output:

1. **Extract key findings** - Don't dump raw output
2. **Prioritize actionable items** - Critical issues first
3. **Add your assessment** - Experts can be wrong; evaluate critically
4. **Format for user** - Clear, scannable presentation

## Example: Bug Analysis Delegation

```typescript
mcp__codex__codex({
  prompt: `TASK: Analyze the authentication module for bugs and potential runtime errors.

EXPECTED OUTCOME: List of bugs with severity, location, and fixes.

CONTEXT:
- Current state: Authentication module handles JWT tokens and session management
- Relevant code: src/auth/jwt.py, src/auth/session.py
- Background: User reported occasional 500 errors during login

CONSTRAINTS:
- Python 3.11
- FastAPI framework
- Must not break existing token format

MUST DO:
- Check all error handling paths
- Verify token expiration logic
- Look for race conditions in session handling

MUST NOT DO:
- Suggest architectural changes
- Propose new dependencies

OUTPUT FORMAT:
- Bugs listed by severity
- Each with location, issue, impact, fix
- Summary with counts`,
  "developer-instructions": "[Bug Analyzer prompt]",
  sandbox: "read-only",
  cwd: "/path/to/project"
})
```
