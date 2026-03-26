---
description: "Analyze code for security vulnerabilities using Codex (GPT 5.2)"
argument-hint: "[file paths or leave empty for recent changes]"
allowed-tools: Read, Glob, Grep, Bash, mcp__codex__codex, AskUserQuestion, Task
---

# Security Analysis with Codex

Delegate security vulnerability analysis to Codex GPT expert. This command sends code to Codex for thorough security review including OWASP Top 10, authentication issues, and injection vulnerabilities.

## Instructions

1. **Gather context**:
   - If file paths provided, read those files
   - If no paths, identify security-sensitive files (auth, API endpoints, data handling)
   - Use `git diff --name-only HEAD~3` to find recently modified files
   - Read relevant code to include in the delegation

2. **Ask execution mode**:
   Use AskUserQuestion to ask:
   - "How should Codex run?"
   - Options: "Wait for results" (blocking) or "Run in background" (continue working)

3. **Build the delegation prompt** using the 7-section format:

```
TASK: Analyze [files/component] for security vulnerabilities, focusing on OWASP Top 10 and common attack vectors.

EXPECTED OUTCOME: Prioritized list of vulnerabilities with severity, risk rating, and remediation guidance.

CONTEXT:
- Current state: [describe what the code does, especially security-sensitive functionality]
- Relevant code:
  [include code snippets or file contents]
- Assets at risk: [what data or systems could be compromised]
- Background: [why analysis is needed - new feature, security audit, etc.]

CONSTRAINTS:
- [Language/framework versions]
- [Authentication mechanism in use]
- [Deployment environment - cloud, on-prem, etc.]

MUST DO:
- Check OWASP Top 10 categories
- Review authentication and authorization logic
- Examine input validation and sanitization
- Look for injection vulnerabilities (SQL, XSS, command)
- Check for secrets/credentials in code or config
- Identify insecure data handling
- Review error handling for information leakage

MUST NOT DO:
- Flag low-risk theoretical concerns
- Suggest architectural overhauls
- Recommend security-by-obscurity approaches
- Propose unnecessary dependencies

OUTPUT FORMAT:
For each vulnerability:
- Location: [file:line or function]
- Severity: [Critical/High/Medium/Low]
- Category: [OWASP category or vulnerability type]
- Issue: [description of the vulnerability]
- Attack scenario: [how it could be exploited]
- Remediation: [specific fix recommendation]

RISK RATING: [Critical/High/Medium/Low - overall assessment]
SUMMARY: [X critical, Y high, Z medium vulnerabilities found]
PRIORITY FIXES: [Top 3 items to address first]
```

4. **Call Codex** (based on user's execution mode choice):

**If "Wait for results" (blocking):**
```typescript
mcp__codex__codex({
  prompt: "[your delegation prompt]",
  "developer-instructions": "You are a security analysis expert with an attacker's mindset. Find vulnerabilities before attackers do. Focus on: 1) OWASP Top 10 2) Authentication/Authorization flaws 3) Input validation 4) Injection vulnerabilities 5) Secrets exposure 6) Data handling. Be practical - prioritize exploitable issues over theoretical concerns. Output vulnerabilities by severity with attack scenarios and specific remediation steps.",
  sandbox: "read-only",
  cwd: "[current working directory]"
})
```

**If "Run in background":**
Use the Task tool with `run_in_background: true`:
```typescript
Task({
  subagent_type: "general-purpose",
  description: "Run Codex security analysis",
  prompt: "Call mcp__codex__codex with this prompt: [delegation prompt]. Developer instructions: You are a security analysis expert with an attacker's mindset. Find vulnerabilities before attackers do. Focus on OWASP Top 10, auth flaws, input validation, injection, secrets exposure. Sandbox: read-only. Synthesize the results with risk rating and priority fixes.",
  run_in_background: true
})
```
Tell the user: "Codex is analyzing security in the background. I'll notify you when results are ready. You can continue working."

5. **Synthesize results**:
   - Lead with overall risk rating
   - Present critical/high severity vulnerabilities first
   - Group by vulnerability category (auth, injection, etc.)
   - Include attack scenarios for high-severity issues
   - Add your assessment of exploitability and business impact
   - Recommend priority order for remediation
   - Offer to help implement security fixes

## Example Usage

User: `/codex-security src/api/`

Response flow:
1. Read files in src/api/
2. Ask: "Wait for results or run in background?"
3. Build delegation prompt with code context and assets at risk
4. Call Codex (blocking or background based on choice)
5. Present: "Codex security analysis: HIGH risk. Found 2 critical, 3 high vulnerabilities. Priority: Fix SQL injection in user.ts..."
