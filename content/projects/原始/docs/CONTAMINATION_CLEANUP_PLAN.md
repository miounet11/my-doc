# 历史污染清理计划

## 目标
- 把“历史假修复叙事”从“当前状态判断”里隔离出去。
- 不篡改历史快照，但给它们补明确标签。
- 让未来的 supervision / evidence board / loop report 默认引用当前可信产物，而不是旧叙事。

## 当前污染源
- 历史 ACP/session-spawn 伪模式：
  - 额外 `payload` 字段式伪描述
  - `native_host_persist` 这类伪任务名
  - 缺少完整路由字段的不完整 spawn 片段
- 历史 world-model / autonomy 文本中反复出现的“bridge verified / host_write_ok / persistence resolved”类叙事
- 早于 loop 19 的 summary / reflection 中对“inspectable artifacts = self-correction complete”的过度归纳

## 清理原则
- 不删除历史事实。
- 不重写历史当时的运行快照。
- 只新增污染标签、当前对照、和引用边界。

## 执行动作
1. 所有 evidence board / summary / retrospective 在引用旧产物时，必须标明：
   - `historical snapshot`
   - `not current state`
2. session-spawn audit 保持作为 contamination source，而不是普通 degraded 噪音。
3. 新 loop / supervision 默认引用：
   - latest `completion-return`
   - latest schema-aligned worker status
   - latest `readiness-last.json`
4. 对旧的假修复高频文本，不做批量重写；用集中清单隔离并逐步减少被引用机会。
5. 项目内新的 ACP 计划文本必须遵守 `projects/原始/docs/ACP_DESCRIPTOR_HYGIENE.md`，禁止继续复写历史伪 descriptor。

## 当前可信主锚点
- /Users/lu/.openclaw/workspace/projects/原始/data/retrospectives/loop-19.md
- /Users/lu/.openclaw/workspace/projects/原始/data/retrospectives/loop-19-reflection.md
- /Users/lu/.openclaw/workspace/projects/原始/data/orchestration/iteration-19-20260310-032140/completion-return.json
- /Users/lu/.openclaw/workspace/data/system/readiness-last.json

