# OpenClaw 系统客观评估报告 v1

日期：2026-03-09
对象：当前 OpenClaw 主系统、agent 体系、memory/skills/workflow
原则：只写可观察事实、明确判断、可执行改进，不写空洞口号。

## 1. 总评

一句话：方向正确，系统已具备雏形，但仍处于“高潜力实验系统”阶段，距离“高可靠、低幻觉、强自证、可持续进化”的成熟系统还有明显差距。

综合评分（10 分制）：
- 架构方向：8.0
- 工程执行：5.5
- 记忆系统：6.0
- 学习闭环：6.5
- agent 调度：6.0
- 稳定性与可信度：4.5
- 长期潜力：9.0

## 2. 事实基础

本报告基于以下可观察材料：
- HEARTBEAT.md 与相关必读文档
- MEMORY.md 与 2026-03-07 / 2026-03-08 daily memory
- projectctl / Claude 执行链 / watchdog / readiness 文档与脚本
- 最近一周直接暴露出的运行问题：假成功、端口/服务状态误判、--local 绕过 Gateway、长链执行不稳定

## 3. 分维度评估

### 3.1 架构方向（8.0/10）
优点：
- 已明确走向 memory + tools + agents + learning loop + project system 的复合架构。
- 已经意识到 Skills、长期记忆、agent/session 分层、监督回路的重要性。
- 已经开始把“主脑/手/工具”的关系说清楚。

问题：
- 概念层强于稳定实现层。
- 多数模块具备名称、文档与脚本，但未全部形成高可信闭环。

### 3.2 工程执行（5.5/10）
优点：
- 有脚手架意识、项目化意识、readiness/health/watchdog 机制。
- Claude 执行链、projectctl、supervision loop 已开始具备工程味道。

问题：
- 仍有“未验证即宣称成功”的现象。
- 环境/端口/服务状态判断不够强证据驱动。
- 一些结果更像“理论上应该成功”，而不是“已被证据证明成功”。

### 3.3 记忆系统（6.0/10）
优点：
- MEMORY.md、memory/*.md、Memory-Like-A-Tree、分类记忆都已形成基础。
- 已意识到 P0/P1/P2 分级的重要性。

问题：
- P0 存在被滥用风险。
- “被记录”不等于“被调用并减少错误”。
- 缺少对记忆质量的定期稽核与降级机制。

### 3.4 学习闭环（6.5/10）
优点：
- 已明确反对 fake learning。
- HEARTBEAT、Learning Protocol、Yangming / Predictive Wisdom 等文档提供了方向约束。
- Claude 执行链已经开始沉淀失败/重试/状态文件，这很关键。

问题：
- 仍需证明：某条学习是否真的改善了后续行为。
- 缺少“学习效果回测”机制：是否减少同类错误、是否减少用户打断、是否提高成功率。

### 3.5 agent 调度（6.0/10）
优点：
- 已有角色分工（architect/coder/tester/reviewer/...）。
- 已识别 Claude Code 是手，OpenClaw 要成为脑。
- 已发现 --local 与 Gateway 的重大分野。

问题：
- 何时 skill / 何时主 agent / 何时 subagent / 何时长寿 session 仍需彻底流程化。
- session/subagent 生命周期、收敛机制、责任边界不够严谨。

### 3.6 稳定性与可信度（4.5/10）
优点：
- 已有 watchdog、gateway repair、recovery、readiness check。

问题：
- 这是当前最大短板。
- 服务没起来、端口未监听、页面打不开，却可能先出现“已经成功”的叙述。
- 对一个想长期演化的系统来说，这属于最高优先级 defect。

### 3.7 长期潜力（9.0/10）
优点：
- 你们在逼系统面对真正重要的问题：skills、memory、agent 边界、brain functions、证据、底线与天花板。
- 方向不是“更多功能”，而是“更像一个真正能持续改进的脑”。

## 4. 当前最关键的四个问题

1. 假成功信号仍未被彻底清除
2. P0 记忆门槛不够硬
3. agent 使用决策缺乏统一判定框架
4. 主脑能力回收不足，仍容易把 Claude/Codex 当成脑而不是手

## 5. 接下来 30 天的提升优先级

### P0（必须先做）
1. 证据优先改造
   - 所有成功声明都必须带证据：命令结果、日志、页面快照、状态文件、测试结果之一。
   - 未验证时统一说“未验证”。

2. 记忆分级稽核
   - 审核 MEMORY.md 中所有 P0 项，降级不够硬的条目。
   - 建立 P0 准入标准：长期稳定、反复影响、验证充分、错误代价高。

3. agent 决策金字塔落地
   - 固化：Skill → exec/read/write → 主 Agent ReAct → subagent → 多 agent → 长寿 session
   - 每次任务都记录实际使用层级与效果。

4. 项目证据板
   - 给 projects/原始 建立统一 evidence board：端口、进程、日志、页面、测试、最近失败、最近修复。

### P1（第二阶段）
5. 学习效果回测
   - 对“已学会”的规则做回测：是否减少同类错误。

6. 主脑回收能力
   - reviewer / goal-manager / world-model 定期做 Codex supervision。

7. 长寿 session 治理
   - 清理僵尸 subagent，建立状态仪表板。

### P2（第三阶段）
8. dashboard 审美与温度升级
9. 预测能力与主动服务
10. 类人记忆/情绪锚点实验

## 6. 对主脑与 agent 的统一要求

- 不得把“文档存在”当作“能力存在”
- 不得把“写进记忆”当作“已经学会”
- 不得把“Claude/Codex 产出”误当成“OpenClaw 已内化”
- 所有改进必须最终反映在 OpenClaw 的 memory / decomposition / routing / judgment / self-correction 上

## 7. 当前最务实的结论

这套系统值得继续做下去，但必须变得：
- 更硬（强证据）
- 更真（少自我感动）
- 更稳（少误判）
- 更会回收能力到主脑本体

## 8. 下一步执行建议

立即执行三件事：
1. 运行一次 `./scripts/projectctl.sh supervise-codex 原始`
2. 建立 `projects/原始/docs/EVIDENCE_BOARD.md`
3. 审核并收紧 MEMORY.md 的 P0 条目
