# Patterns - 设计模式和最佳实践

> 自动分类：代码模式、架构模式、工作流模式
> 置信度：每次使用 +1，每周衰减 -0.1
> TTL: 90 天未使用自动归档

---

## [P1] Evals-First 开发模式
<!-- confidence: 1.0, last_used: 2026-03-07 -->

1. 先写测试用例（test-cases.json）
2. 设定质量目标（pass_rate≥98%, token_efficiency≥70%）
3. 实现功能
4. 运行 benchmark（5 runs A/B）
5. 调优直到达标
6. 记录到 MEMORY.md

**适用场景**：所有新功能、新 skill、重大重构

---

## [P1] Agent Teams 决策模式
<!-- confidence: 0.9, last_used: 2026-03-07 -->

**触发条件**：
- 架构级决策
- 多方案选择
- 性能关键路径
- 安全敏感操作

**流程**：
1. 主 Agent 识别复杂度
2. 召集专家团队（architect, coder, tester, reviewer, optimizer）
3. 多轮辩论（每个 Agent 提出方案 + 反驳）
4. 综合最优方案
5. 记录决策理由到 memory/decisions.md

**避免**：简单任务不要过度设计

---

## [P2] 文件命名规范
<!-- confidence: 0.8, last_used: 2026-03-07 -->

- 配置文件：`UPPERCASE.md`（SOUL.md, MEMORY.md）
- 技能文档：`SKILL.md`
- 日志文件：`YYYY-MM-DD.md`
- 分类记忆：`lowercase.md`（patterns.md, bugs.md）

---

_自动维护：每周清理低置信度条目_
