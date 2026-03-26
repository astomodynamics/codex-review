# Review Output

Default to findings-first output.

## Required Shape

1. `Findings`
2. `Open questions / assumptions`
3. `Summary`

Keep the summary brief. The review itself should focus on problems, not on
re-describing the patch.

## Finding Template

Use one item per finding:

```text
- [high] Short title ([path/to/file.py]:123)
  Issue: what is wrong
  Impact: what can break and for whom
  Evidence: why the current code causes that outcome
```

Keep the title terse. Put the evidence in your own words; do not paste long diff
blocks.

## No-Finding Case

If nothing survives verification, say so explicitly:

```text
No findings.

Residual risk:
- Focused tests were not run locally.
- Large generated diff made manual validation partial.
```

## Review Norms

- Order findings from highest to lowest severity.
- Include file references for every finding.
- Mention missing or unrun tests when they affect confidence.
- Keep open questions separate from findings.
