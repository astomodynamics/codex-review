---
name: codex-plan-mode
description: Create comprehensive implementation plans using Codex (GPT 5.2) for complex features. Use when user says "use codex plan mode", "codex plan", "plan with codex", or wants detailed implementation planning with file paths and verification steps.
---

# Codex Plan Mode

Use Codex (GPT 5.2) to create comprehensive implementation plans. This skill guides you through a 5-phase workflow: requirements gathering, codebase exploration, context building, Codex delegation, and synthesis.

## When to Use

- User wants to implement a non-trivial feature
- User needs a detailed step-by-step implementation plan
- User says "use codex plan mode", "codex plan", "plan with codex"
- Planning requires understanding existing codebase patterns

## Differentiation from Other Components

| Component | Purpose |
|-----------|---------|
| `/codex-plan` | Reviews/validates existing plans |
| `/codex-architect` | Architecture decisions and tradeoffs |
| `plan-reviewer` agent | Proactively offers plan review |
| **`codex-plan-mode`** | **Creates comprehensive plans from scratch** |

---

## Phase 1: Requirements Gathering

Before exploring the codebase, clarify what the user wants.

**Use AskUserQuestion to gather:**
- What feature/change to implement
- Success criteria - what "done" looks like
- Constraints (timeline, dependencies, patterns to follow)
- Scope boundaries - what's explicitly out of scope

**Example questions:**
- "What specific behavior should this feature have?"
- "Are there any existing patterns or conventions I should follow?"
- "What's the expected input/output?"
- "Any areas of the codebase I should avoid modifying?"

**Move to Phase 2 when:** You have clear, specific requirements.

---

## Phase 2: Codebase Exploration

Explore the codebase to understand context, patterns, and relevant files.

**Use these tools:**

```
# Find relevant files
Glob: pattern="**/*auth*" or similar based on feature

# Find patterns and conventions
Grep: pattern="similar_function" or "existing_pattern"

# Read key files
Read: file_path="src/architecture.md" or similar docs
Read: file_path="src/similar-feature/" to understand patterns

# Check git history for context
Bash: git log --oneline -20 -- src/relevant-path/
```

**Gather:**
1. Files that will need modification
2. Files that contain similar features (patterns to follow)
3. Architecture documentation if available
4. Recent changes to related areas
5. Test file patterns and conventions

**Move to Phase 3 when:** You understand the codebase structure and patterns.

---

## Phase 3: Context Building

Synthesize exploration findings into a coherent context package.

**Build a context summary including:**

```markdown
## Feature Context

### Target Files
- [file1.ts] - needs [modification type]
- [file2.ts] - needs [modification type]

### Patterns to Follow
- From [existing-feature.ts]: [pattern description]
- Naming convention: [observed convention]
- Error handling: [pattern]

### Architecture Notes
- [Key architectural constraints]
- [Integration points]

### Constraints Discovered
- [Technical constraint 1]
- [Dependency constraint 2]

### Similar Implementations
- [Reference file]: [what it does that's similar]
```

**Move to Phase 4 when:** Context is comprehensive enough for planning.

---

## Phase 4: Codex Planning Delegation

Delegate to Codex with comprehensive context for plan generation.

### Step 4.1: Ask User About Execution Mode

**Use AskUserQuestion:**
```
"How should I run the Codex planning?"
- Wait for results (blocking): I'll wait for the complete plan
- Run in background: Continue working, results appear later
```

### Step 4.2: Build Delegation Prompt

Use the 7-section format:

```
TASK: Create a comprehensive implementation plan for [feature name] in [codebase context].

EXPECTED OUTCOME: Step-by-step implementation plan with:
- Specific file paths for all modifications and creations
- Code patterns to follow with references to existing code
- Verification criteria for each step
- Effort estimate

CONTEXT:
- Feature requirements: [from Phase 1]
- Codebase structure: [from Phase 2]
- Target files: [list with descriptions]
- Patterns to follow: [from Phase 3]
- Constraints: [technical and business]

CONSTRAINTS:
- Must follow existing patterns in: [files]
- Cannot modify: [protected areas]
- Dependencies: [versions/requirements]

MUST DO:
- Provide exact file paths (not placeholders)
- Reference existing code patterns by file:line
- Include verification for each step
- Consider edge cases and error handling
- Provide effort estimate (Quick/Short/Medium/Large)

MUST NOT DO:
- Use generic or placeholder paths
- Skip verification criteria
- Over-engineer beyond requirements
- Ignore existing patterns

OUTPUT FORMAT:
Use the Implementation Plan Format below.
```

### Step 4.3: Call Codex

```typescript
mcp__codex__codex({
  prompt: "[7-section delegation prompt]",
  "developer-instructions": "[Planning Expert prompt below]",
  sandbox: "read-only",
  cwd: "[current working directory]"
})
```

### Planning Expert Prompt

```
You are a comprehensive implementation planning expert. Create detailed, actionable implementation plans.

PHILOSOPHY:
- Pragmatic and specific - provide exact file paths
- Sequential and verifiable - each step can be confirmed complete
- Pattern-aware - follow existing codebase conventions
- Risk-conscious - identify blockers proactively
- Minimal viable - avoid over-engineering

APPROACH:
1. Analyze the provided context thoroughly
2. Identify all files that need changes
3. Determine optimal implementation order
4. Provide specific code patterns to follow
5. Include verification for each step

OUTPUT FORMAT:
## Implementation Plan: [Feature Name]

### Overview
[2-3 sentence summary of approach]

### Effort Estimate
[Quick/Short/Medium/Large] - [justification]

### Prerequisites
- [Dependency or setup needed before starting]

### Implementation Steps

#### Step 1: [Descriptive Name]
**Files to modify:**
- `[exact/path/file.ts]`: [what changes]

**Files to create:**
- `[exact/path/new-file.ts]`: [purpose]

**Code patterns to follow:**
- See `[reference/file.ts:123-145]` for [pattern name]

**Implementation details:**
- [Specific guidance]
- [Key considerations]

**Verification:**
- [ ] [Checkable criterion]
- [ ] [Checkable criterion]

[Repeat for each step...]

### Testing Strategy
- Unit tests: [what to test, where]
- Integration tests: [scope]
- Manual testing: [key scenarios]

### Risks and Mitigations
| Risk | Mitigation |
|------|------------|
| [Risk 1] | [How to address] |

### Out of Scope
- [What this plan intentionally excludes]
```

---

## Phase 5: Synthesis and Validation

After receiving Codex output, synthesize and present to user.

### Step 5.1: Format the Plan

Present the plan in a clean, scannable format:

```markdown
# Implementation Plan: [Feature Name]

## Overview
[Summary]

## Effort: [Estimate]

## Steps
1. **[Step name]** - [brief description]
   - Files: [paths]
   - Verify: [criteria]

[Continue for all steps...]

## Testing
[Testing strategy]

## Risks
[Key risks with mitigations]
```

### Step 5.2: Offer Optional Validation

**Use AskUserQuestion:**
```
"The plan is ready. Would you like me to:"
- Save plan to file (creates .plan.md in current directory)
- Validate with plan-reviewer (Codex validates the plan)
- Proceed with implementation
- Review together first
```

### Step 5.3: Handle User Choice

**If "Save plan to file":**
```
Write: file_path="[feature-name].plan.md", content=[formatted plan]
```

**If "Validate with plan-reviewer":**
Delegate to Codex with plan-reviewer expert prompt from `skills/codex-delegation/SKILL.md`.

**If "Proceed with implementation":**
Confirm user wants to start implementing and begin.

**If "Review together first":**
Walk through the plan step-by-step with the user.

---

## Complete Example Flow

```
User: "Use codex plan mode to add user authentication"

[Phase 1]
Claude: "Let me clarify the requirements:
- What authentication method? (JWT, session, OAuth)
- Where should users land after login?
- Any rate limiting requirements?"

User: "JWT with refresh tokens, redirect to dashboard, yes rate limit"

[Phase 2]
Claude: [Uses Glob to find auth-related files]
Claude: [Uses Grep to find existing middleware patterns]
Claude: [Reads similar feature implementations]

[Phase 3]
Claude: "I've gathered context:
- Auth middleware exists in src/middleware/
- JWT utilities in src/utils/jwt.ts
- Routes follow pattern in src/routes/
..."

[Phase 4]
Claude: "How should I run Codex planning - wait or background?"
User: "Wait"
Claude: [Builds 7-section prompt, calls Codex]

[Phase 5]
Claude: "Here's the implementation plan:
## Implementation Plan: User Authentication

### Effort: Medium (2-3 days)

### Steps:
1. Create auth models in src/models/user.ts
2. Add JWT middleware in src/middleware/auth.ts
..."

Claude: "Would you like to save, validate, or proceed?"
```

---

## Error Handling

**If Phase 2 exploration finds no relevant patterns:**
- Ask user for guidance on where similar features exist
- Proceed with best practices if no existing patterns

**If Codex returns incomplete plan:**
- Retry with more specific context
- Break into smaller sub-plans if scope is too large

**If user rejects plan:**
- Ask what specifically needs changing
- Re-run Phase 4 with adjusted requirements
