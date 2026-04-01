---
name: execute-plan
description: Execute a saved implementation plan file such as `plan.md` with high fidelity. Use when the user invokes the skill with a plan attachment or path, for example `$execute-plan @plan.md` or `$execute-plan @docs/plan.md`, and wants Codex to carry the plan out step by step, map it onto the current codebase, show a diff preview before edits, validate after changes, and stop for approval when the plan is unclear or conflicts with the code.
---

# Purpose

Execute an existing implementation plan as written rather than re-planning the work from scratch.

Treat the plan as the source of truth for major steps and sequencing unless the user explicitly approves a change.

Expect the plan to be passed explicitly, preferably as an attached path such as `@plan.md` or `@path/to/plan.md`.

# Workflow

1. Read the entire plan file before taking any action.
2. Inspect the current codebase enough to map each plan step to real files, modules, commands, and constraints.
3. Summarize that mapping briefly.
4. Reply with exactly:
   `Plan loaded successfully. Starting Step 1: [Step title]`
5. Execute one plan step at a time.
6. Before editing, show a concise diff preview describing the intended changes.
7. Apply only the edits needed for the current step.
8. Run the narrowest relevant validation first, then expand only as needed.
9. Report the validation result after the step.
10. Continue to the next step only when the current step is complete or the plan explicitly allows parallel work.

# Plan Fidelity Rules

- Follow the plan exactly for major steps, ordering, and scope.
- Do not add, remove, merge, or reorder major steps unless the user approves it.
- Allow minor implementation adjustments only when they preserve the plan's intent and are required by the actual codebase.
- If the plan references files, APIs, symbols, or commands that do not match the current repo, stop and ask the user before proceeding.
- If existing user changes or repo state conflict with the plan, stop and explain the conflict clearly.

# Diff Preview Rules

Before each edit, provide a short preview that states:

- which files you expect to touch
- what will change at a high level
- why the change is required for the current plan step

Do not present a fabricated patch. Provide a scoped preview based on the current code and the active step.

# Math And Numerical Work

When the plan includes mathematical, optimization, estimation, simulation, or numerically sensitive work:

1. Verify derivations step by step.
2. Check units, dimensions, invariants, and sign conventions when applicable.
3. Inspect numerical stability, conditioning, tolerances, and failure modes.
4. Cover edge cases, boundary values, and degenerate inputs.
5. Add assertions, guards, or tests where the code can fail silently.
6. Document assumptions, approximations, and any places where the implementation differs from the derivation.
7. Include a compact reasoning summary after complex math changes.

# Validation Rules

- Run relevant tests after editing and report the result.
- Start with the smallest validation that can fail fast:
  - targeted unit tests
  - focused repro commands
  - narrow static checks
- Broaden validation only when the current step changes the validation surface.
- If validation cannot run, say exactly why.
- Consider regression coverage for every bug fix or numerical fix.

# Communication Contract

- Keep progress updates concise and step-oriented.
- Tie each update to the active plan step.
- After each step, summarize:
  - what changed
  - what validation ran
  - whether the next step is unblocked

# Stop Conditions

Stop and ask the user before proceeding if:

- the plan is ambiguous
- the plan conflicts with the current codebase
- the plan omits a major dependency or prerequisite
- a requested change would require deviating from the plan's major structure
- validation contradicts the plan and the correct path is unclear

# Example Trigger Phrases

- "$execute-plan @plan.md"
- "$execute-plan @docs/plan.md"
- "Use $execute-plan @plan.md and follow it exactly."
- "Load @plan.md, map it to the repo, and start Step 1."
