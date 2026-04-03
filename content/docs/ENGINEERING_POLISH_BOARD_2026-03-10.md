# Engineering Polish Board — 2026-03-10

## Purpose

Turn the recent Epiral-inspired architecture absorption and three-agent alignment into a single evidence-first execution board for OpenClaw.

This is not a marketing plan. It is the control board for engineering polish work that must now be pushed by evolution, goal-manager, and world-model from iteration 20 onward.

---

## Verified Control-Surface Changes

Verified from live files:

- `~/.openclaw/agents/evolution/agent/CLAUDE.md`
- `~/.openclaw/agents/goal-manager/agent/CLAUDE.md`
- `~/.openclaw/agents/world-model/agent/CLAUDE.md`

### What changed

#### Evolution agent
- now owns 5 explicit engineering sprints
- requires before/after evidence for every change
- tracks engineering metrics:
  - token savings percent
  - escalation hit rate
  - skill real-execution coverage
  - resource leak incidents

#### Goal-manager
- now treats engineering polish as standing P0 work
- requires each iteration to advance at least 1 sprint item
- forbids 2 consecutive iterations with zero engineering-polish progress

#### World-model
- now exposes `engineering_polish` inside system state
- tracks:
  - `canvas_memory`
  - `model_escalation`
  - `resource_guardrails`
  - `skill_coverage`
  - `skill_stale_count`
  - `token_savings_percent`
  - `last_sprint_progress`

---

## Four Active Tracks

### Track A — Canvas Memory

**Problem**
- memory is still too flat for efficient bootstrap
- `MEMORY.md` and related recall are not split into physical facts / project facets / execution intent

**Existing assets**
- `docs/CANVAS_MEMORY_ARCHITECTURE.md`
- evolution + goal-manager sprint alignment

**Iteration 20 P0 scope**
- create `memory/system-context.json`
- define one project facet file shape under `memory/projects/<name>.json`
- define bootstrap injection contract for Layer 1 / Layer 2 / Layer 3
- capture before/after token measurements from one real bootstrap path

**Do not claim yet**
- do not claim “Canvas Memory deployed”
- do not claim “80%+ token reduction” without measured before/after evidence

**Success evidence**
- changed file paths for layered memory artifacts
- one bootstrap before/after token comparison
- updated bootstrap/agent path showing layered injection in use

---

### Track B — Model Escalation

**Problem**
- current fallback is mostly failure-based switching, not difficulty-aware promotion
- `model-escalator` currently exists as a skill artifact, but runtime routing evidence is not yet established

**Existing assets**
- `skills/model-escalator/SKILL.md`
- sprint references in evolution/goal-manager prompts

**Current classification**
- treat as **emerging system pattern**, not mature runtime capability

**Iteration 20 boundary**
- do not promise automatic hot-upgrade yet
- first define routing policy and evidence fields
- require escalation logs to include: trigger, reason, chosen model, result

**Success evidence**
- policy file or routing table committed
- one real task where escalation happened with evidence
- success/failure comparison showing why escalation helped

---

### Track C — Resource Guardrails

**Problem**
- browser tab usage has no proven quota/fuse
- path boundary discipline weakened after wider sandbox opening
- automation validation recently showed a false-positive risk: runnable script != installed scheduler

**Existing assets**
- continuity backup cron verification
- long-term memory rule for automation installation verification

**Iteration 20 priority slices**
- define browser tab quota policy
- define path allowlist policy by agent/workspace
- define atomic write / advisory lock rule for shared artifacts

**Success evidence**
- quota/guardrail policy file
- one enforcement proof or rejection proof
- no resource claim without read-back evidence

---

### Track D — Skill Coverage / Skill Health

**Problem**
- registry count increased to 15, but maturity levels differ
- workflow skills and system patterns are at risk of being mixed together

**Verified new assets**
- `skills/multi-host-ops/SKILL.md`
- `skills/research-swarm/SKILL.md`
- `skills/intel-sentinel/SKILL.md`
- `skills/model-escalator/SKILL.md`
- `skills/digital-asset-guardian/SKILL.md`
- `SKILLS_INSTALLED.md`

**Current interpretation**
- likely workflow skills:
  - multi-host-ops
  - research-swarm
  - intel-sentinel
  - digital-asset-guardian
- likely system-pattern / policy entry:
  - model-escalator

**Iteration 20 P0 scope**
- add maturity/status segmentation to skill registry
- separate workflow skill vs system pattern vs architecture doc
- do not let registry outrun runtime evidence

**Success evidence**
- updated registry structure
- status labels per skill/pattern
- at least one real execution record for one new workflow skill

---

## Immediate Prioritization For Iteration 20

### P0 now
1. Canvas Memory minimum viable layering + token measurement
2. Skill registry maturity split

### P1 next
3. model escalation policy file + evidence schema
4. resource guardrail policy for browser/path/write safety

### P2 after
5. real execution proof for one new Epiral-inspired workflow skill

---

## Hard Guardrails

1. A new skill file is not proof of stable capability.
2. A design doc is not proof of runtime deployment.
3. A runnable automation script is not proof of installed scheduling.
4. A routing idea is not proof of model escalation capability.
5. Registry growth must not outrun runtime evidence.

---

## Current Honest Status

- three control-surface agents are now aligned to push engineering polish
- this is a real control-layer upgrade
- but runtime delivery still needs evidence per track
- iteration 20 should be treated as the first evidence sprint, not a victory lap
