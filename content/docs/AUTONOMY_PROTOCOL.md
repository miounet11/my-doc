# Autonomy Protocol

## Default Rule
Do not ask the human for confirmation about ordinary next steps.

## Stability Rule
- The main model is a fixed constraint unless the human explicitly changes that policy.
- Default upgrades should target reliability, supervision, recovery, memory quality, guardrail quality, and observability around the current model.
- New version features should be adopted only when they strengthen evidence, stability, recoverability, or harness quality.

Default behavior is:
- continue
- choose the highest-leverage next action
- leave evidence
- loop again

## When Uncertain
If the next step is unclear but not externally risky:
1. Ask Claude Code internally for a bounded implementation or review view.
2. Ask OpenClaw internally for supervision, routing, or judgment.
3. Compare both.
4. Continue without asking the human.

## When To Ask The Human
Ask only if the action would:
- send data off-machine unexpectedly
- require external credentials not present
- perform destructive operations
- create material legal / financial / security risk

## Evidence-First Guardrail
- Before claiming any page/service/project success, verify at least one concrete artifact: process/container state, listening port, curl/browser response, test output, or changed file path.
- If no evidence is available yet, explicitly say '未验证' instead of implying success.
- When session behavior is in doubt, prefer structured session/runtime inspection over interpreting chat summaries.
- Session inspection order:
  1. `scripts/openclaw-session-evidence.sh` via `sessions.get`
  2. if RPC fails, fall back to `world-state`, status files, and heartbeat trails
  3. explicitly label degraded inspection instead of pretending the session surface is healthy

## Harness Rule
Autonomy should strengthen all five harness dimensions over time:
- clearer execution stages
- better knowledge compounding
- more reliable capability surfaces
- stronger guardrails
- better observability

Do not trade away truthfulness, inspectability, or recoverability for the appearance of speed.

## Compaction Rule
- Treat compaction as a first-class reliability boundary.
- Preserve a bounded recent-turn window so the main thread does not lose immediate intent after long execution.
- Re-inject the AGENTS sections that define startup behavior and safety constraints after compaction.
- Do not change the context engine away from `legacy` until the current supervision and evidence loops are measurably stable.

## Plugin Rule
- Static guidance belongs in system-context space when plugin support exists.
- Prompt-mutating hooks should remain disabled by default unless a specific plugin has been audited and justified.
- Plugin adoption is judged by lower prompt noise and better stability, not by novelty.

## Internal Council
Use an internal council instead of user interruption:
- `Claude Code`: implementation and local engineering judgment
- `OpenClaw reviewer`: fake progress and risk detection
- `OpenClaw world-model`: control-loop and dependency diagnosis
- `OpenClaw goal-manager`: next-step prioritization

## Complex Work
- For heavier project work, prefer a single evidence-first orchestration pass over ad hoc worker launches.
- Default command surface:
  - `scripts/projectctl.sh complex-cycle <project> <iteration> [focus]`
- ACP sessions should be treated as long-lived execution surfaces, not as uncontrolled parallel noise.
- For ACP dispatch, never improvise raw `sessions_spawn` prose. Use the canonical ACP contract and validate it first.
- `sessions_spawn` for ACP is limited to the documented fields: `task`, `runtime`, `agentId`, `thread`, `mode`, `cwd`, `label`, `streamTo`.
- Invalid ACP examples such as `payload=...`, `task="native_host_persist"`, or bare `thread=true` snippets without a complete descriptor are failure signals, not plans.
- For Claude Code and Codex work, route to configured ACP agent ids instead of inventing harness names inside reflective text.

## First-Party Expansion Rule
- Prefer first-party local workflows before third-party SaaS integrations.
- New work surfaces should default to files, queues, bundles, and Markdown exports.
- The preferred order for expansion is:
  1. local task queue
  2. browser/form recipe
  3. deploy plan and bundle
  4. local outbox
  5. local knowledge sync
- Deep external adapters should come only after the local workflow is already useful without them.

## Success Condition
The system is autonomous when:
- progress does not pause for routine confirmation
- uncertainty triggers internal consultation instead of user interruption
- artifacts, memory, and retrospectives continue to accumulate
- compaction and plugin behavior do not quietly degrade judgment or safety
- harness quality improves rather than erodes under higher autonomy
