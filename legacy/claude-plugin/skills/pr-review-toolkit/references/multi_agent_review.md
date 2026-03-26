# Multi-Agent Review

Use multiple agents when one reviewer would spend too long reconstructing
context, or when the change has independent risk surfaces.

## Good Split Points

- More than about 10 changed files
- Multiple subsystems or directories
- Code plus infra, config, or migrations in one patch
- Security, public API, or performance-sensitive surfaces

## Ownership Pattern

- Lead reviewer: own scoping, synthesis, and any cross-cutting verification.
- Agent 1: map the diff, identify hotspots, and flag files that deserve deeper
  reading.
- Agent 2: inspect correctness, edge cases, and behavior changes.
- Agent 3: inspect tests, regression risk, and observability.
- Optional Agent 4: inspect security, migrations, performance, or infra risk
  when those appear in the diff.

Assign either disjoint files or disjoint risk questions. Do not ask several
agents to review the exact same surface unless you want intentional redundancy.

## Delegation Rules

- Give every agent the exact review range and the files or risk surface it owns.
- Ask for findings only, with severity and file references.
- Tell agents to skip style nits and speculative refactors.
- Keep working locally while the agents run; do not block unless their results
  are needed for synthesis.

## Prompt Skeleton

```text
TASK: Review the diff <base>..<head> for <risk area>.

OWNERSHIP:
- Files: <paths>
- Focus: <correctness | tests | security | performance>

RETURN:
- Findings only
- One item per finding
- Severity, file reference, issue, impact, evidence
- Note missing tests when relevant
```

## Synthesis

- De-duplicate overlapping claims.
- Re-read the relevant code before accepting any agent finding.
- Present one unified review to the user instead of several agent transcripts.
