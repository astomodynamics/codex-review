# Review Rubric

Use this rubric to decide what counts as a finding and how severe it is.

## Severity

- `critical`: data loss, security bypass, irreversible corruption, major outage,
  or a crash in a common path.
- `high`: likely production bug, broken public behavior, missing authorization,
  unsafe migration, or a strong regression in a common path.
- `medium`: real but narrower bug, broken edge-case handling, misleading test
  coverage, incorrect fallback, or a defect likely to surface under normal
  variation.
- `low`: correctness-adjacent issue with realistic future breakage risk. Do not
  use `low` for mere polish.

## What Counts As A Finding

- The diff changes behavior in a way that can break callers, users, operators,
  or downstream systems.
- The code assumes an invariant that surrounding code does not guarantee.
- A changed test misses the risky branch, weakens assertions, or locks in the
  wrong behavior.
- A migration, config, or API change is incompatible with existing usage.
- Error handling, cleanup, ordering, or state transitions are now unsafe.

## Evidence Standard

Every finding should answer all of these:

1. Where is the issue?
2. What exact behavior is wrong or risky?
3. Why does the current code lead to that outcome?
4. Who or what is affected?

If you cannot support a claim with code or a concrete execution path, turn it
into an open question instead of a finding.

## Common Review Angles

- Correctness: wrong condition, dropped branch, stale data, wrong index, wrong
  units, missing null handling.
- Compatibility: API shape drift, config default changes, renamed fields, schema
  or migration hazards.
- State and ordering: races, partial updates, cache invalidation, cleanup gaps,
  retry loops, double execution.
- Testing: source changed without meaningful tests, assertions no longer protect
  the bug surface, fixtures hide failure modes.
- Security: authz gaps, unsafe input handling, secret exposure, insecure
  defaults.
- Performance: obvious hot-path regression, accidental O(n^2), repeated I/O, or
  unbounded growth. Skip speculative micro-optimizations.

## Non-Findings

- Formatter or linter nits.
- Naming preferences without a correctness consequence.
- Hypothetical refactors that are not tied to a concrete defect.
- Documentation suggestions unless the user asked for docs review.
- Style comments on generated, vendored, or lockfile changes.
