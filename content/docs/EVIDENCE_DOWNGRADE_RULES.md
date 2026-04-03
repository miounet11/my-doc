# Evidence Downgrade Rules

Status: guardrail table
Date: 2026-03-30

| Weak evidence case | Allowed label(s) | Not allowed |
|---|---|---|
| ACP spawn/session created but no artifact path captured | degraded, unknown | verified, approved |
| Transcript claims completion but no file/test/runtime artifact exists | inferred, unable_to_verify | verified |
| Builder says done but handoff file missing | rework_required, degraded | approved |
| Review summary exists only in chat/session output | unknown, incomplete | approved_with_caveats |
| Verify step has no concrete source refs | unable_to_verify | verified, partially_verified |
| Example/demo trace intentionally illustrative | illustrative | verified |

## Rule
If evidence is weaker than the contract requires, downgrade the label instead of upgrading the story.
