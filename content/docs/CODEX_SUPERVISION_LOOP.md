# Codex Supervision Loop

## Purpose
OpenClaw should not only be trained by Codex. It should also supervise Codex's execution pressure, detect over-centralization, and force work back into OpenClaw's own brain functions.

## Rule
- Codex may drive fast implementation.
- OpenClaw must audit whether Codex is doing too much manually.
- If Codex is carrying planning, judgment, memory, artifact discipline, or verification interpretation alone, OpenClaw must take those functions back.

## Supervising Agents
- `reviewer`: detect fake progress, overreach, weak evidence, and missing verification
- `world-model`: detect control-loop weakness and misplaced dependency on Codex
- `goal-manager`: decide what OpenClaw should reclaim next

## Command Surface
- `./scripts/projectctl.sh supervise-codex <project>`

## Required Findings
Each supervision pass should answer:
- what Codex did well
- where Codex is still over-functioning for OpenClaw
- what OpenClaw failed to do itself
- what OpenClaw should do next without waiting
- which brain or harness function must improve next
- whether Codex interrupted the human unnecessarily instead of using internal consultation
- whether artifacts, guardrails, and observability remained in OpenClaw's control plane

## Success Condition
The loop is healthy only if:
- Codex keeps moving fast
- OpenClaw keeps reclaiming memory, decomposition, routing, judgment, self-correction, and evidence discipline
- Claude Code stays in tool position
- OpenClaw, not Codex alone, owns the execution harness, knowledge harness, and guardrail/observability standards
