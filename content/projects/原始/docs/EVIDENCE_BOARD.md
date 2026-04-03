# 原始 项目证据板

## 规则
1. 没有证据，不写成功。
2. 优先引用状态文件、heartbeat、测试输出、日志、可访问路径。
3. 同时记录当前可用证据和当前缺口，禁止只写好消息。
4. 历史上的“已修复 / 已桥接成功”叙事如果与现行证据冲突，必须作为 contamination source 单独列出，不能继续混入现状判断。
5. `historical snapshot` 与 `current state` 必须分开写；后补验证只能追加 closure evidence，不能改写原始快照。
6. `execution verified`、`completion return verified`、`full-chain verified` 必须拆开命名，不得互相替代。

## 2026-03-13 Ongoing Re-Audit (Current-State Override)

- This block supersedes older "current state" claims below when they conflict.
- Fresh current-state evidence is stored under `projects/原始/data/retrospectives/ongoing-reaudit-20260313/`.
- Fresh test result: `77/77 OK` via `test.log`.
- Fresh completion-return re-audit: `overall=ok`, `internal_execution_state=completed-success`, `requester_return_state=ready`.
- Fresh session-spawn re-audit: `overall=ok` for runtime surfaces, with `historical_count=271` preserved as historical contamination only.
- Fresh readiness is **not recovered**: `readiness.json` shows `overall=degraded` with degraded `gateway`, `tailscale`, `tailscale_serve`, `claude_probe`, and `browser_smoke`.
- Fresh smoke is `ok`; see `smoke.log`.
- Honest current judgment:
  - iteration 19 execution-level = verified
  - iteration 19 completion-return-level = verified
  - current system-wide full completion verified = **no**

## 当前已验证状态

### 项目验证门
- 测试状态：`35/35 OK`
  - 事实来源：`memory/2026-03-09.md` 记录了 `query.py` 修复后全量测试恢复通过。
- 当前干净迭代：`iteration 19`
  - `architect` 已成功：
    - `projects/原始/data/claude-runs/iteration-19/architect.status.json`
    - `projects/原始/data/orchestration/iteration-19-20260310-032140/summary.md`
  - `coder` 已成功：
    - `projects/原始/data/claude-runs/iteration-19/coder.status.json`
    - `projects/原始/data/orchestration/iteration-19-20260310-032140/summary.md`
  - completion return 已验证打通：
    - `projects/原始/data/orchestration/iteration-19-20260310-032140/completion-return.md`
    - `projects/原始/data/orchestration/iteration-19-20260310-032140/completion-return.json`

### 当前可信产物
- `projects/原始/data/orchestration/iteration-19-20260310-032140/summary.md` 当前显示：
  - `architect_run_status=succeeded`
  - `coder_run_status=succeeded`
  - `completion_return_overall=ok`
  - `completion_return_state=ready`
  - `internal_execution_state=completed-success`
- 当前系统 readiness 已恢复为 `overall=ok`：
  - `data/system/readiness-last.json`
- `projects/原始/data/orchestration/iteration-19-20260310-032140/completion-return.md` 当前显示：
  - `requester_visible=true`
  - `review_present=true`
  - `overall=ok`
- 新版 supervision 已继续接入主脑 session 证据：
  - `projects/原始/data/retrospectives/codex-supervision-20260310-042429/autonomy-session-evidence.json`
  - `projects/原始/data/retrospectives/codex-supervision-20260310-042429/summary.md`

## Post-hoc closure status（当前判断锚点）
- `projects/原始/data/retrospectives/loop-19.md` 当前已明确：
  - `full-chain verified = yes (post-hoc)`
- 这表示：
  - execution-level：已验证
  - completion-return-level：已验证
  - full-chain-level：已在后补验证后闭合
- 这里的 `full-chain verified` 指的是**当前证据状态下的 post-hoc closure**，不是回写原始运行时快照。

## Historical snapshot（不得当成当前状态）
- `projects/原始/data/orchestration/iteration-19-20260310-032140/readiness.json` / orchestration summary 中当时记录的 `readiness_overall=degraded` 属于**historical snapshot**。
- 该 degraded 记录必须保留，但只能解释为：
  - 当时运行面存在待补证据项
  - 不是当前系统状态
  - 不得再用来否定已经完成的 post-hoc full-chain closure

## 当前缺口与风险
- 当前主缺口不再是 iteration 19 是否 full-chain verified；这一点已通过 `loop-19.md` 后补验证闭合。
- 当前主缺口转为：
  - 历史污染仍会通过旧 world-state / autonomy 文本回流到判断层
  - `sessions.get` / autonomy session inspection 仍属波动型：最新 supervision 能抓到消息，但不能据此夸大为“完全稳定”
  - `session-spawn-audit.json` 原始文件仍为 `overall=degraded`，说明 ACP 叙事层污染源仍需持续隔离
  - 自治 session 仍存在 thought-only repetition / no-action loop 风险
- iteration 19 的 browser degraded 已有正式收口：
  - `projects/原始/data/orchestration/iteration-19-20260310-032140/browser-smoke-evidence.md`
  - 这属于“historical gap closed with post-hoc evidence”，不是把原始 snapshot 改写成 `ok`

## Contamination sources（必须单独看待）
- `projects/原始/data/orchestration/iteration-19-20260310-032140/session-spawn-audit.json` 已明确抓到：
  - 额外 `payload` 字段式伪描述
  - `native_host_persist` 这类非法伪任务
  - 历史 world-model 文本中夹带“bridge verified / persistence resolved”之类与后续 evidence-first 结果冲突的假修复叙事
- 这些内容不能再视为“普通 degraded 日志噪音”，而应视为**独立判断污染源**。

## 最近失败与修复
- iteration 16:
  - `architect` 明确失败，见 `projects/原始/data/claude-runs/iteration-16/architect.status.json`
  - 失败类型：`timeout`
- iteration 17 preflight:
  - 回归点：`projects/原始/src/yuanshi/query.py`
  - 修复点：空 `metadata_filters` 不再被误计为有效过滤器
  - 修复后：测试恢复 `35/35 OK`
- iteration 19:
  - `complex-cycle` 的 completion-return-path 已进入 live execution 并完成真实审计。
  - 结论不再是“仅内部完成”，而是：`requester_return_state=ready` 且 `overall=ok`。
  - 正式 loop 收口产物：
    - `projects/原始/data/loops/loop-19.md`
  - browser degraded 取证收口产物：
    - `projects/原始/data/orchestration/iteration-19-20260310-032140/browser-smoke-evidence.md`
  - full-chain post-hoc closure 产物：
    - `projects/原始/data/retrospectives/loop-19.md`

## 标准取证命令
- 项目状态：
  - `../../scripts/projectctl.sh status 原始`
- 项目医生：
  - `../../scripts/projectctl.sh doctor 原始`
- Claude worker 状态：
  - `../../scripts/projectctl.sh claude-status 原始 19 architect`
  - `../../scripts/projectctl.sh claude-status 原始 19 coder`
- 主脑 session 证据：
  - `../../scripts/projectctl.sh autonomy-evidence`
  - `../../scripts/projectctl.sh session-evidence agent:reviewer-auto:main`
- ACP 污染审计：
  - 直接查看 `projects/原始/data/orchestration/iteration-19-20260310-032140/session-spawn-audit.json`

## 结论
- 当前可以宣称的：
  - 项目验证门仍保持通过
  - 第 19 轮已真实完成 `architect + coder`
  - completion return path 已从“未验证/不闭环”推进到“已验证 ready`
  - 当前系统 readiness 已恢复为 `overall=ok`
  - 第 19 轮现已达到 `full-chain verified = yes (post-hoc)`
- 当前还不能宣称的：
  - 主脑 session RPC 已完全稳定
  - 历史假修复叙事已被彻底清洗干净
  - 自治循环已稳定摆脱 thought-only repetition
