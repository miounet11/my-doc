# Decisions - 架构和技术决策

> 自动分类：技术选型、架构决策、工具选择
> 置信度：每次引用 +1，每月衰减 -0.05
> TTL: 永久保留（P0）或 180 天（P1）

---

## [P0] Evals 框架技术栈
<!-- confidence: 1.0, decided: 2026-03-06 -->

**决策**：使用 JSON + Bash + HTML 构建 evals 系统

**理由**：
- JSON：跨语言兼容，易于解析和扩展
- Bash：零依赖，快速执行，适合 CI/CD
- HTML + Chart.js：交互式可视化，无需后端

**替代方案**：
- Python + pytest：过重，依赖管理复杂
- TypeScript + Jest：需要编译，启动慢

**结果**：✓ 系统轻量、快速、易维护

---

## [P0] Memory-Like-A-Tree 架构
<!-- confidence: 1.0, decided: 2026-03-06 -->

**决策**：分层记忆系统

**层次**：
1. **MEMORY.md**：长期记忆（P0/P1/P2 优先级）
2. **memory/*.md**：分类记忆（patterns, decisions, bugs, optimizations, learnings）
3. **memory/YYYY-MM-DD.md**：日志（原始记录）

**衰减机制**：
- P0：永久保留
- P1：90 天未使用 → P2
- P2：30 天未使用 → 归档

**置信度系统**：
- 每次使用 +0.1
- 每周自动衰减 -0.05
- 低于 0.3 自动归档

---

## [P1] Skill 触发机制
<!-- confidence: 0.9, decided: 2026-03-06 -->

**决策**：基于关键词 + 语义匹配的混合触发

**实现**：
1. 关键词快速匹配（"implement", "fix", "optimize"）
2. 语义相似度计算（向量距离）
3. 置信度阈值：≥0.7 自动触发，0.5-0.7 询问用户

**避免**：
- 纯关键词：误触发率高
- 纯语义：计算成本高

---

_自动维护：每月审查决策有效性_
