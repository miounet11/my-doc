# OpenClaw Operational Doctrine — 2026-03-10

> This is the combat manual. Not theory. Not vision. What to actually do.

## Status

This document remains useful as an execution-facing field manual.

Current baseline doctrine now lives in:

- `docs/OPENCLAW_BEST_PRACTICES.md`
- `docs/OPENCLAW_OPERATING_CHECKLIST.md`

Use this file for:

- execution rhythm
- evidence discipline
- anti-pattern reminders
- practical operator posture

Do not treat this file alone as the full current fork standard.

## 1. Decision Loop (OODA for Agents)

```
Observe → Orient → Decide → Act → Verify → Learn
```

Every cycle must complete all 6 steps. Stopping at Act without Verify is a fake success.

### Observe
- Read `data/system/readiness-last.json`
- Check `crontab -l`
- Read latest `data/loops/loop-*.md`
- Check gateway health: `curl -s http://127.0.0.1:3456/health`

### Orient
- What changed since last cycle?
- What's degraded?
- What's the user's current priority?

### Decide
- Pick ONE thing to focus on
- Not three. One.
- The one with highest impact and clearest evidence of need

### Act
- Execute via the right tool (Claude Code for code, browser for web, gateway API for agents)
- Keep scope tight

### Verify
- Did it actually work? Prove it.
- File exists? Read it back.
- API works? Call it.
- Test passes? Show output.

### Learn
- Write what you learned to memory
- Update doctrine if needed
- Don't learn the same lesson twice

## 2. Tool Selection Matrix

| Task | Tool | NOT This |
|------|------|----------|
| Write/edit code | Claude Code (me) | Don't use sandbox agents |
| Web research | `web_search` + `web_fetch` | Don't hallucinate URLs |
| Browser automation | CDP via `scripts/openclaw-browser-smoke.sh` | Don't fake browser results |
| System health | `scripts/openclaw-readiness.sh` | Don't guess from memory |
| Agent coordination | Gateway API `/api/sessions` | Don't spawn without purpose |
| File operations | Direct fs (read/write/edit) | Don't use base64 workarounds |
| Git operations | `git` CLI directly | Don't use wrapper scripts that hide errors |
| Deploy | `gh` CLI + SSH | Don't push without tests |

## 3. Evidence Hierarchy

```
Tier 1: Live command output (strongest)
  └── curl response, test output, file readback
Tier 2: Timestamped artifact
  └── JSON with ISO timestamp, git commit SHA
Tier 3: Structured log entry
  └── Gateway log, cron output
Tier 4: Agent self-report (weakest)
  └── "I did X" without readback proof
```

**Rule: Never accept Tier 4 as completion evidence.**

## 4. Memory Discipline

### What goes in P0 (permanent)
- Architectural decisions that affect multiple components
- User preferences confirmed across 3+ interactions
- Security-critical patterns
- Lessons learned from production incidents

### What goes in P1 (90 days)
- Current project state and progress
- Working patterns that might change
- Tool configurations
- Integration details

### What goes in P2 (30 days)
- TODO items
- Temporary workarounds
- Experimental approaches
- One-off findings

### Memory Hygiene
- Before writing: search if it already exists
- Before promoting to P0: verify against 3+ instances
- Monthly: scan for stale P1/P2 entries
- Never: duplicate information across files

## 5. Agent Routing Rules

```
Is it a single, focused task?
  ├── Yes → Main agent handles it directly
  └── No → Is it decomposable?
       ├── Yes → Decompose, then:
       │    ├── Code tasks → coder agent
       │    ├── Architecture → architect agent
       │    ├── Review → reviewer agent
       │    └── Tests → tester agent
       └── No → Escalate to human with clear description of ambiguity
```

**Anti-pattern**: Spawning 5 agents for a task that one agent can handle in 30 seconds.

## 6. Failure Response Protocol

```
Error occurs
  ├── Is it a network/sandbox error?
  │    └── Check execution surface (sandbox vs host)
  │        Don't blame the model for infra failures
  ├── Is it a code error?
  │    └── Read the actual error message
  │        Fix the root cause, not the symptom
  ├── Is it a timeout?
  │    └── Check if the task scope was too large
  │        Break it down
  └── Is it a permission error?
       └── Check settings.json and execution policy
           Fix permissions, don't work around them
```

## 7. Communication Protocol with Claude Code

When OpenClaw sends a task to Claude Code (me), it should include:

```json
{
  "task": "clear one-sentence description",
  "context": "why this matters right now",
  "scope": ["file1.ts", "file2.ts"],
  "success_criteria": "how to verify completion",
  "constraints": ["don't modify X", "must be backward compatible"]
}
```

When Claude Code returns results, OpenClaw should verify:
- [ ] Files mentioned actually exist
- [ ] Tests mentioned actually pass
- [ ] Changes mentioned are visible in `git diff`
- [ ] No unintended side effects

## 8. Daily Rhythm

```
Cognitive cron (every 2h):
  - Memory tree maintenance
  - Stale entry cleanup
  - Index update

Backup (every 6h):
  - Full workspace backup to GitHub
  - Verify backup integrity

On-demand:
  - Project iterations
  - Research tasks
  - System repairs
```

## 9. What NOT to Do

1. **Don't fake evidence.** If you can't verify it, say so.
2. **Don't spawn agents for simple tasks.** Direct execution is faster and more reliable.
3. **Don't write essays when code suffices.** Show, don't tell.
4. **Don't confuse planning with doing.** A plan file is not an achievement.
5. **Don't repeat the same error.** Check memory before retrying.
6. **Don't overclaim.** "execution verified" ≠ "full-chain verified".
7. **Don't ignore sandbox boundaries.** Host ≠ sandbox. Period.
8. **Don't accumulate TODOs.** Do them or delete them.
9. **Don't trust previous cycle's "success" without re-verifying** if the task involves state.
10. **Don't use ACP pseudo-descriptors.** Every ACP call must have valid schema fields.
