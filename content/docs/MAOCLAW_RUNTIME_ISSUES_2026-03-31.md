# maoclaw Runtime Issues on This OpenClaw Benchmark

Status: active report
Date: 2026-03-31

Scope: this document records the verified `maoclaw` issues found while benchmarking it against OpenClaw on the same provider route and default model.

## Benchmark Context

Comparison environment:
- OpenClaw runtime: `2026.3.28`
- maoclaw runtime: `pi 0.1.13`
- mirrored provider route: `openai`
- mirrored model: `gpt-5.4`
- mirrored base URL: `https://ttqq.inping.com/v1`

This comparison only uses claims verified in the local environment.

## Verified Strengths

- `maoclaw` installed successfully and verified release checksum.
- `pi doctor` gives honest setup diagnostics.
- After mirroring provider config, `pi` can execute real turns on the same provider route as OpenClaw.
- `maoclaw` performed well on direct file-based recovery:
  - reading `memory/2026-03-29.md`
  - reading an incomplete handoff
  - returning structured JSON

## Verified Issues

### 1. Default auth/setup path was not production-ready on this machine

Observed before mirroring config:
- default execution path failed with explicit `401 token_expired` on `openai-codex`
- anthropic path failed with explicit `401 invalid bearer token`

Interpretation:
- failure reporting was honest
- but the initial operator path was not ready for same-route benchmarking until config was manually mirrored

### 2. `--base-url` operator surface was inconsistent in tested runtime path

Observed:
- docs and provider examples describe custom base-URL usage
- tested CLI path rejected `--base-url` with:
  - `Validation error: Extension flags were provided (--base-url), but no extensions are loaded.`

Interpretation:
- custom route capability exists conceptually
- but the tested non-interactive operator surface was inconsistent enough that manual config-file mirroring was the practical workaround

### 3. Continuity failed in tested print-mode flow

Test:
1. inject codename `ALPHA-729`
2. continue the same flow
3. ask for the codename only

Observed:
- first turn returned `READY`
- follow-up returned `I don't know`

Interpretation:
- same-route execution works
- tested print-mode continuity does not yet meet replacement-grade expectations

### 4. Explicit `--session-dir` path did not produce inspectable persisted session artifacts

Observed:
- custom session directory was provided
- follow-up continuity still failed
- no inspectable session artifacts appeared in that target directory

Interpretation:
- tested non-interactive persistence path was weaker than expected

### 5. Explicit `--session /path.jsonl` did not materialize the documented contract

Docs state sessions are JSONL files and explicit `--session <path>` should select a session file path.

Test:
1. run:
   - `pi --session /Users/lu/.maoclaw-eval/alpha-session.jsonl -p "Remember codename BETA-314 and reply READY only."`
2. verify the file exists
3. run a follow-up recall on the same explicit session path

Observed:
- first turn returned `READY`
- `/Users/lu/.maoclaw-eval/alpha-session.jsonl` did not exist after the run
- follow-up recall returned `I don't know`

Interpretation:
- in the tested non-interactive flow, explicit session-file semantics did not produce inspectable persisted continuity
- until contradicted by verified alternate behavior, this is a real continuity/persistence defect for this benchmark

## Current Benchmark Verdict

OpenClaw still wins on continuity under the tested workflow.

`maoclaw` is promising and competitive on direct file-recovery tasks, but it is not yet credible as a replacement for this workflow because:
- continuity is weaker
- explicit persistence semantics were not verified in the tested non-interactive path
- integration burden remains nontrivial

## What Would Change The Verdict

`maoclaw` would become a stronger replacement candidate if all of these are verified:

1. a documented session mode produces inspectable persisted artifacts
2. short continuity recall passes reliably
3. explicit session path behavior matches the docs
4. same-route execution remains stable without operator-surface workarounds

## Related Evidence

- [`docs/OPENCLAW_VS_MAOCLAW_DAY1_RESULTS_2026-03-30.md`](/Users/lu/.openclaw/workspace/docs/OPENCLAW_VS_MAOCLAW_DAY1_RESULTS_2026-03-30.md)
- [`docs/OPENCLAW_VS_MAOCLAW_DAY2_RESULTS_2026-03-31.md`](/Users/lu/.openclaw/workspace/docs/OPENCLAW_VS_MAOCLAW_DAY2_RESULTS_2026-03-31.md)
- [`docs/OPENCLAW_VS_MAOCLAW_DAY3_RESULTS_2026-03-31.md`](/Users/lu/.openclaw/workspace/docs/OPENCLAW_VS_MAOCLAW_DAY3_RESULTS_2026-03-31.md)
- [`evals/runtime-replacement-scorecard-template.json`](/Users/lu/.openclaw/workspace/evals/runtime-replacement-scorecard-template.json)
