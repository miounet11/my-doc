# Canvas Memory Architecture — Borrowed from Epiral, Adapted for OpenClaw

## Problem

OpenClaw's memory is flat. Everything lives in MEMORY.md with P0/P1/P2 tags.
This means every agent session ingests the ENTIRE memory file, wasting tokens
on irrelevant context. Epiral claims 20x token reduction with their Canvas Memory.

## Their Model (simplified)

```
Layer 1: Physical Facts (rarely changes)
  - Hardware specs, accounts, network topology
  - Injected once, cached indefinitely

Layer 2: Task Facets (changes per project)
  - Current progress, tech stack, decisions made
  - Injected per-topic, pruned on completion

Layer 3: Execution Intent (changes per turn)
  - Current goal, priority, constraints
  - Injected fresh each turn, never cached
```

## Our Adaptation

### Layer 1: System Context (inject once per session)
File: `memory/system-context.json`
```json
{
  "host": "Mac Studio M2 Ultra",
  "os": "macOS 15.5",
  "user": "lu",
  "network": "tailscale + loopback gateway",
  "agents": ["main", "architect", "coder", "reviewer", ...],
  "browser": "Chrome CDP on :18800",
  "storage": "/Users/lu/.openclaw/",
  "accounts": {
    "github": "lu",
    "anthropic": "active"
  }
}
```
Token cost: ~200 tokens. Inject at session start. Never re-inject.

### Layer 2: Project Context (inject per project switch)
File: `memory/projects/<project-name>.json`
```json
{
  "name": "原始",
  "current_iteration": 19,
  "status": "full-chain-verified",
  "tech_stack": ["node", "shell", "python"],
  "key_decisions": [
    "evidence-first verification",
    "completion-return mandatory",
    "ACP descriptor discipline"
  ],
  "active_concerns": [],
  "last_updated": "2026-03-10"
}
```
Token cost: ~300 tokens per project. Only inject the active project.

### Layer 3: Turn Context (inject per task)
Built dynamically from:
- User's current message
- Last 3 turns of conversation
- Any files mentioned in the task
Token cost: varies. Minimal overhead.

### What We DON'T Inject Anymore
- Full MEMORY.md (currently ~4000 tokens) → replaced by Layer 1+2 (~500 tokens)
- Full SKILLS_INSTALLED.md → only inject relevant skill on trigger
- Full agent list with descriptions → Layer 1 summary

### Migration Path
1. Extract system facts from MEMORY.md → `memory/system-context.json`
2. Extract project state from loops/orchestration → `memory/projects/<name>.json`
3. Keep MEMORY.md for P0 doctrine/lessons only (hard-won knowledge)
4. Update agent bootstrap to inject layers selectively

### Expected Savings
```
Current: ~4000 tokens per session bootstrap
After:   ~500 tokens per session bootstrap
Savings: ~87.5% (roughly Epiral's claimed 20x is marketing, real is 5-8x)
```

## Implementation Priority
- [ ] Create `memory/system-context.json` schema
- [ ] Create `memory/projects/` directory with per-project JSON
- [ ] Modify agent bootstrap to use layered injection
- [ ] Benchmark actual token savings
- [ ] Prune MEMORY.md to doctrine-only
