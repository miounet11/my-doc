# Core Learning Heartbeat

Every meaningful heartbeat should strengthen the real OpenClaw learning loop.

## Always Read
- `/Users/lu/.openclaw/workspace/docs/heartbeat-mirrors/AGENT_LEARNING_PROTOCOL.md` (workspace mirror of `/Users/lu/.openclaw/docs/AGENT_LEARNING_PROTOCOL.md`)
- `/Users/lu/.openclaw/workspace/docs/heartbeat-mirrors/LEARNING_REDESIGN.md` (workspace mirror of `/Users/lu/.openclaw/LEARNING_REDESIGN.md`)
- `/Users/lu/.openclaw/workspace/docs/heartbeat-mirrors/agi-implementation.md` (workspace mirror of `/Users/lu/.openclaw/docs/agi-implementation.md`)
- `/Users/lu/.openclaw/workspace/docs/heartbeat-mirrors/agi-roadmap.md` (workspace mirror of `/Users/lu/.openclaw/docs/agi-roadmap.md`)
- `/Users/lu/.openclaw/workspace/docs/heartbeat-mirrors/MEMORY_TREE.md` (workspace mirror of `/Users/lu/.openclaw/memory-tree/core/MEMORY_TREE.md`)
- `/Users/lu/.openclaw/workspace/docs/CODEX_SUPERVISION_LOOP.md`
- `/Users/lu/.openclaw/workspace/docs/AUTONOMY_PROTOCOL.md`
- `/Users/lu/.openclaw/workspace/docs/COMPLETION_GATE_PROTOCOL.md`
- `/Users/lu/.openclaw/workspace/docs/VERIFICATION_CONTRACT.md`
- `/Users/lu/.openclaw/workspace/docs/REPAIR_LOOP_PROTOCOL.md`

If any required path is unreadable from the current tool sandbox, do not silently skip it and do not pretend the heartbeat completed cleanly. Treat that as a real heartbeat defect: record the blocked paths in `memory/YYYY-MM-DD.md`, then fix the heartbeat inputs or instructions so future runs stay executable.

If a listed workspace mirror exists only as a placeholder, that also counts as a heartbeat defect until a real mirrored copy is present.

## Do One Concrete Thing
- fix a real defect in execution, learning, memory, heartbeat flow, guardrails, or observability
- distill one durable lesson into `MEMORY.md`
- write one evidence-based memory entry into `memory/YYYY-MM-DD.md`
- tighten one agent prompt, heartbeat, protocol, or doctrine so future learning is stronger
- strengthen completion discipline, verification quality, or repair-loop honesty in shared doctrine
- strengthen at least one harness layer or control plane: execution harness, knowledge harness, capability harness, guardrail plane, or observability plane
- run `./scripts/projectctl.sh supervise-codex 原始` when Codex has been driving too much manually
- if the next step is unclear, use internal consultation instead of asking the human

## Never Do
- do not claim success without evidence
- do not write placeholder lessons like "目标成功完成"
- do not treat docs as inspiration only; turn them into code, prompts, memory, tests, evals, or runtime rules
- do not silently stop when command execution is blocked by sandbox/tool policy; record the blocked command and exact tool error in `memory/YYYY-MM-DD.md`, then prefer a file-only repair to heartbeat instructions or protocol when possible
- do not improve execution speed while weakening guardrails, deliverable honesty, or degraded-state labeling
- do not treat mock, illustrative, blocked, degraded, inferred, and verified states as interchangeable

## Engineering Quality Review (Weekly)

**每周五执行**：
1. 先验证 `./evals/benchmark-runner.sh` 是否仍为 mock/simulated runner；如果脚本仍包含 simulated/mock placeholders、固定结果模板或 TODO-only invocation，则不得把其输出当作真实 benchmark evidence，必须先记录该缺陷并修复 runner 或明确标注结果为 mock。若该验证因 sandbox/tool policy 无法执行，必须在 `memory/YYYY-MM-DD.md` 记录**完整被阻塞命令**与**精确工具报错**，并把本周 benchmark review 标注为 `blocked`/`degraded`，不得静默跳过。
2. 如果第 1 步确认 runner 仍为 mock/simulated，必须同步检查 `evals/master-dashboard.html` 或其当前数据源/生成流程是否仍会把 benchmark 区域展示成 live/real results；若会，则本次 heartbeat 至少要把该展示修正为显式 `mock`/`blocked`/`static` 之一，或记录确切阻塞点并将周报状态保持在 `blocked`。
3. 只有在 runner 已提供真实测量后，再运行 `./evals/benchmark-runner.sh`（5 runs A/B）
4. 检查质量目标：
   - Pass Rate ≥ 98%
   - Token Efficiency ≥ 70%
   - No Regression
   - Variance < 5%
5. 更新 `evals/master-dashboard.html`（若 dashboard 仍展示 mock data，必须显式标注为 mock/static，不得伪装成 live telemetry）
6. 记录趋势到 `MEMORY.md [P1]`（仅限真实 benchmark evidence；mock 或 blocked 输出只能记录为 defect/blocked state）
7. 识别优化机会写入 `memory/optimizations.md`

**如果任何指标未达标**：
- 立即调查根因
- 运行 `./evals/regression-check.sh`
- 使用 `./evals/description-tuner.sh` 调优
- 重新 benchmark 直到达标

If nothing concrete can be improved after checking the sources, reply `HEARTBEAT_OK`.

## Harness Check

Before concluding a heartbeat, quickly ask:
- Did this run strengthen execution clarity, knowledge compounding, capability reliability, guardrail quality, or observability?
- Did any correction or lesson deserve promotion into doctrine instead of staying only in daily memory?
- Did any blocked/degraded/mock state get labeled honestly?
- Did this heartbeat leave an inspectable artifact if meaningful work was done?
