# Evidence and Eval Rules

Status: active draft
Date: 2026-03-30

Purpose: keep OpenClaw's evidence language, verification standards, and evaluation logic honest enough that harness improvements can be measured without self-deception.

## 1. Evidence States
Important outcomes should be labeled with one of these states whenever ambiguity matters:
- verified
- partially-verified
- blocked
- degraded
- mock
- illustrative
- inferred
- unknown

These states are not interchangeable.

## 2. Definitions

### verified
Direct evidence exists from runtime behavior, tests, browser inspection, changed artifacts, or equivalent first-order inspection.

### partially-verified
Some parts are evidenced, but important parts remain unverified.

### blocked
The intended check or action could not proceed because of tool limits, policy, missing credentials, missing environment, or another hard blocker.

### degraded
The task proceeded through a reduced-confidence path, fallback surface, or partial inspection method.

### mock
The output was simulated or placeholder by design and must not be treated as production evidence.

### illustrative
The output is an example, sketch, or design mockup meant to explain a concept rather than prove reality.

### inferred
The claim is a reasoned conclusion based on available signals, but was not directly checked.

### unknown
There is not enough basis to say more.

## 3. Core Rules

### Rule 1: Never upgrade state without new evidence
A blocked, degraded, mock, illustrative, inferred, or unknown state may only be upgraded when fresh evidence exists.

### Rule 2: Verification is not implementation
Code changes, config edits, or written plans do not automatically count as runtime verification.

### Rule 3: Mock and real must remain separate
Mock or illustrative outputs may help design or explain, but they must never be mixed into benchmark claims, MEMORY trend claims, or user-facing success claims as if they were verified.

### Rule 4: Degraded paths must stay visible
Fallbacks are allowed, but the loss of confidence must remain explicit.

### Rule 5: Same-turn artifacts outrank stale summaries
Fresh artifacts, outputs, and direct inspection beat old narratives about what supposedly happened.

## 4. What Counts as Strong Evidence
Strong evidence usually includes one or more of:
- test output
- process/container/runtime state
- browser snapshot or interactive check
- changed file path with inspectable contents
- structured tool output with clear status
- deployment or delivery surface that the user can actually access

Weak evidence includes:
- unsupported narration
- bare "completed" fields without inspected payloads
- historical memory without fresh confirmation
- routing logs mistaken for accomplishment

## 5. Eval Rules

### Harness-sensitive evaluation
Do not evaluate only the final answer.
Also evaluate:
- stage discipline
- artifact quality
- verification quality
- memory reuse
- guardrail quality
- capability reliability
- observability / trace quality

### Infrastructure-noise awareness
If behavior changes, consider whether the cause was:
- model change
- prompt/protocol change
- tool/runtime change
- environment change
- evaluation harness change

Do not attribute everything to the model.

### Trace usefulness test
A trace or memory entry is useful if a future reviewer could answer:
- what was attempted?
- what evidence was gathered?
- what state was verified vs inferred?
- what should change next time?

## 6. Benchmark Rules
- Never count simulated or blocked runs as passed evidence.
- If the runner is mock-only, say so explicitly.
- If a dashboard is static/mock, label it as static/mock.
- If a run mixes real and illustrative data, separate them clearly.
- Do not report trends from non-real measurements as if they were live telemetry.

## 7. Promotion Rules
Promote an evidence lesson into doctrine/protocol when:
- the same evidence confusion happens more than once
- a benchmark or dashboard risks misleading future work
- a capability surface frequently returns ambiguous status
- users are likely to mistake local/demo/mock outputs for real delivery

## 8. Sharp Rules
- Faster falsehood is worse than slower truth.
- A nice dashboard with mock data is still mock data.
- A successful fallback is not the same thing as a verified primary-path success.
- If you cannot say what was verified, you should not imply that it was.
