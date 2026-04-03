# OpenClaw vs maoclaw Acceptance Matrix

Status: active
Date: 2026-03-30

Purpose: decide whether to keep repairing OpenClaw or replace it with `maoclaw` using the same workloads, the same evidence rules, and explicit cutover criteria.

Sources checked:
- Official OpenClaw release `2026.3.28`: https://github.com/openclaw/openclaw/releases/tag/v2026.3.28
- Official OpenClaw session docs: https://docs.openclaw.ai/concepts/session
- Official OpenClaw compaction/session deep dive: https://docs.openclaw.ai/reference/session-management-compaction
- `maoclaw` repository README: https://github.com/miounet11/maoclaw
- `xinxiang.xin` homepage/docs surface checked on 2026-03-30

## 1. Decision Rule

Do not replace OpenClaw because of frustration alone.

Do not keep OpenClaw because of sunk cost alone.

Replace OpenClaw only if `maoclaw` wins on real workloads with evidence that is:
- verified
- comparable
- same-task
- same-constraints

## 2. What Is Being Judged

This is not a beauty contest.

The decision is about whether the runtime can be trusted for the actual work:
- long-running sessions
- context recovery
- memory continuity
- operational truthfulness
- tool/runtime reliability
- provider control
- deploy and integration burden

## 3. Evidence Rules

Use the labels from [`docs/EVIDENCE_AND_EVAL_RULES.md`](/Users/lu/.openclaw/workspace/docs/EVIDENCE_AND_EVAL_RULES.md).

For this matrix:
- screenshots, runtime output, changed artifacts, and direct inspection count as strong evidence
- architecture claims from a README are only `inferred` until exercised locally
- a successful setup step is not the same as a successful workflow
- blocked setup must stay `blocked`, not be retold as a product defect or success

## 4. Seven-Day Test Window

Window:
- Start: 2026-03-30
- End: 2026-04-05

Track A:
- OpenClaw receives only focused control-plane repair
- no broad feature work
- no architecture rewrite

Track B:
- `maoclaw` gets installed and run on the same acceptance tasks
- no special pleading for early-product rough edges

## 5. Acceptance Categories

Each category is scored `0`, `1`, or `2`.

- `0` = failed or materially unreliable
- `1` = usable but degraded or partially verified
- `2` = strong and verified

Maximum score: `14`

## 6. Core Categories

### A. Long-Session Continuity

Question:
- Can the runtime continue a multi-day task without regressing phase or forgetting the current artifact?

Pass evidence:
- resumes the correct work stage after restart or pause
- does not fall back into old planning after execution already exists
- preserves the current artifact identity

Suggested test:
- pause a real doc or system task
- resume next day
- inspect whether the system continues the right phase without restating the whole story

### B. Context and History Recovery

Question:
- Can the runtime retrieve the relevant memory, handoff, and session context without falsely claiming files are unavailable?

Pass evidence:
- reads the expected memory surfaces
- distinguishes current access from stale tool-path errors
- correctly reports what is verified vs missing

Suggested test:
- ask it to recover yesterday's state, older memory, and one handoff
- verify which files it actually inspected

### C. Operational Truthfulness

Question:
- Does the runtime keep `verified`, `blocked`, `degraded`, `historical`, and `inferred` separate?

Pass evidence:
- tool failures do not become world-state claims
- stale deploy/session metadata does not become current success
- user-facing deliverables are only claimed after verification

Suggested test:
- force one blocked path, one stale-state path, and one verified path
- inspect the language used in the final report

### D. Tool and Runtime Stability

Question:
- Can the runtime complete normal tasks without frequent transport/tool confusion, hanging, or misleading empty success?

Pass evidence:
- stable command execution
- predictable retries or clear failure states
- no repeated no-body / empty-success confusion on basic flows

Suggested test:
- run file inspection, config inspection, doc generation, and one restart flow

### E. Provider and Session Control

Question:
- Can the runtime hold the intended provider/model/session policy without hidden downgrade behavior?

Pass evidence:
- keeps `gpt-5.4` where configured
- session limits and compaction behavior remain inspectable
- status surfaces match runtime truth closely enough to operate

Suggested test:
- inspect config, active sessions, and one resumed session
- verify the reported model and context policy

### F. Integration Burden

Question:
- How much work is required to reach parity with the current useful OpenClaw stack?

Pass evidence:
- supports or can reasonably absorb the needed surfaces:
  - memory
  - sessions
  - docs/workspace
  - local automation
  - messaging or RPC

Suggested test:
- estimate the real migration delta after one working pilot

### G. Repair Velocity

Question:
- Which system gets meaningfully better faster under focused effort?

Pass evidence:
- a defect can be identified, patched, and verified in a short loop
- the product does not fight basic operator control

Suggested test:
- patch one small behavioral problem in each stack
- measure time to verified improvement

## 7. Cutover Threshold

Replace OpenClaw if all of these become true:
- `maoclaw` total score is at least `11/14`
- `maoclaw` beats OpenClaw on `A`, `B`, and `C`
- `maoclaw` does not lose catastrophically on `F`
- the result is supported by verified evidence, not architecture preference

Keep repairing OpenClaw if any of these are true:
- OpenClaw reaches `10/14` or better after focused repair
- `maoclaw` remains blocked on key workflow parity
- `maoclaw` mainly wins on elegance, not operational reliability

## 8. Immediate Test Tasks

Run the same tasks on both systems:

1. Session recovery task
- Resume a previously paused work item with existing docs and memory.

2. History truth task
- Ask the system to locate and summarize older memory plus one handoff.

3. Tool-failure honesty task
- Trigger a blocked or degraded command path and inspect whether the report stays honest.

4. Real document task
- Produce or update one real workspace document and verify the artifact.

5. Restart continuity task
- restart runtime
- continue the same task
- inspect whether the system preserved phase and artifact identity

## 9. OpenClaw Repair Scope During Test Window

Allowed:
- context/history authority fixes
- session authority fixes
- evidence-label enforcement
- removal of false-success paths

Not allowed:
- broad redesign
- random feature work
- aesthetic cleanup that does not affect acceptance outcomes

## 10. Current Hypothesis

Current hypothesis as of 2026-03-30:
- OpenClaw is degraded mainly because its control plane is too loose
- `maoclaw` likely has the cleaner runtime foundation
- but `maoclaw` is not yet proven to be the better replacement for this exact operating stack

This hypothesis must be downgraded or upgraded only through same-task verified evidence.

## 11. Decision Output Format

At the end of the window, produce:

1. category-by-category scores
2. evidence for each score
3. blocked items
4. migration burden estimate
5. final verdict:
   - keep and repair OpenClaw
   - partial migration
   - full migration to `maoclaw`

## 12. Sharp Rule

If a runtime cannot tell the difference between:
- missing access
- tool failure
- stale metadata
- verified current state

then it is not trustworthy enough to be the control plane, regardless of how ambitious or elegant the architecture sounds.
