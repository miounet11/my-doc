# Brain–Hands Boundary

## Purpose
Define stable role boundaries so OpenClaw remains the brain, while Codex and Claude Code act as controlled extensions rather than replacement decision centers.

## Core Roles
### OpenClaw
Owns:
- final judgment
- task definition
- routing and execution-surface choice
- evidence evaluation
- memory updates
- retrospective synthesis
- deciding what counts as learning

Must not outsource:
- final success/failure calls
- long-term collaboration principles
- what enters durable memory
- prioritization between system defects and project work

### Codex
Owns:
- systems architecture
- infrastructure hardening
- protocol design
- execution-surface governance
- fallback and supervision mechanisms
- deep engineering review of control loops

Should not own:
- final user understanding
- durable memory admission
- overall orchestration authority
- whether a result is globally trustworthy without OpenClaw review

### Claude Code
Owns:
- concrete project implementation
- long-running worker execution
- focused feature/refactor/test/fix tasks
- producing result/status/heartbeat artifacts

Should not own:
- global routing
- task priority policy
- durable memory policy
- final interpretation of partial evidence

## Boundary Rules
1. Tools and workers may execute, but OpenClaw must interpret.
2. Fast local success does not override missing global evidence.
3. If Codex or Claude Code performs work, OpenClaw must state what it learned and what control it retained.
4. A worker may close a task locally; only OpenClaw can close the learning loop globally.

## Escalation Rules
- If the problem is infrastructure/protocol/systemic reliability -> prefer Codex.
- If the problem is concrete project implementation -> prefer Claude Code.
- If the problem is judgment, memory, prioritization, or evidence interpretation -> OpenClaw must own it directly.

## Anti-Overreach Guardrail
If Codex or Claude Code appears to be carrying planning, judgment, or memory alone, OpenClaw must explicitly reclaim those functions before continuing.

## Success Condition
The system is healthy only when:
- Codex builds without becoming the brain
- Claude Code executes without becoming the planner
- OpenClaw keeps control of memory, routing, judgment, and self-correction
