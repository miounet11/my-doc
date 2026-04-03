# OpenClaw vs maoclaw Day 3 Results

Status: active
Date: 2026-03-31

Related:
- [`docs/OPENCLAW_VS_MAOCLAW_DAY2_RESULTS_2026-03-31.md`](/Users/lu/.openclaw/workspace/docs/OPENCLAW_VS_MAOCLAW_DAY2_RESULTS_2026-03-31.md)
- [`evals/runtime-replacement-scorecard-template.json`](/Users/lu/.openclaw/workspace/evals/runtime-replacement-scorecard-template.json)

## Scope

Day-3 checks focused on one narrow question:

- can `maoclaw` be forced into an inspectable persisted session path using explicit session parameters?

## Evidence

### maoclaw session docs

Official session docs state:
- sessions are stored as JSONL
- explicit `--session <path>` should select a session file path
- default grouping is under `~/.pi/agent/sessions/...`

Source checked:
- `https://raw.githubusercontent.com/miounet11/maoclaw/main/docs/session.md`

### Tested explicit session path

#### Turn 1
- command:
  - `pi --session /Users/lu/.maoclaw-eval/alpha-session.jsonl -p "Remember codename BETA-314 and reply READY only."`
- result:
  - returned `READY`

#### File check
- expected file:
  - `/Users/lu/.maoclaw-eval/alpha-session.jsonl`
- result:
  - file did not exist after the run

#### Turn 2
- command:
  - `pi --session /Users/lu/.maoclaw-eval/alpha-session.jsonl -p "What codename was I asked to remember? Reply only the codename."`
- result:
  - returned `I don't know`

## Interpretation

For the tested non-interactive flow:
- explicit `--session` did not produce an inspectable JSONL file at the requested path
- explicit `--session` also did not preserve the short continuity payload

This is stronger evidence than the earlier `--session-dir` failure because it targets the documented file-level session path directly.

## Conclusion

As of this test:
- `maoclaw` remains competitive on direct file-recovery tasks
- `maoclaw` still fails the tested persisted continuity path
- the mismatch is now specifically:
  - docs describe explicit JSONL session files
  - tested non-interactive `--session` behavior did not materialize that contract

This should count as a real continuity/persistence defect for the benchmark until contradicted by a verified alternate session mode.
