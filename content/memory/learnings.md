# Learnings - 学习笔记和知识积累

> 自动分类：技术学习、工具使用、方法论
> 置信度：每次引用 +0.5，每月衰减 -0.1
> TTL: 60 天未使用自动归档

---

## [P1] Claude Skill Creator 最佳实践
<!-- confidence: 0.9, learned: 2026-03-06 -->

### Description Tuning 精度目标
- 目标：≥97% 触发准确率
- 方法：A/B 测试 + 用户反馈迭代
- 工具：`evals/description-tuner.sh`

### Trigger 设计原则
1. **明确性**：避免模糊词汇（"help", "do something"）
2. **覆盖性**：列举常见表达方式
3. **排他性**：明确不触发的场景

### 示例
```markdown
## Trigger
User asks for code implementation:
- "Implement X"
- "Build Y"
- "Create Z"

NOT triggered by:
- "Tell me about X" (knowledge-retriever)
- "Search for Y" (x-platform-agent)
```

---

## [P1] Evals-First 工作流
<!-- confidence: 0.9, learned: 2026-03-06 -->

### 核心理念
**测试先行，质量内建**

### 流程
1. **定义测试**：写 test-cases.json
2. **设定目标**：pass_rate≥98%, token_efficiency≥70%
3. **实现功能**：TDD 方式开发
4. **运行 benchmark**：5 runs A/B 测试
5. **回归检测**：对比历史 baseline
6. **调优迭代**：直到达标

### 关键指标
- **Pass Rate**：功能正确性
- **Token Efficiency**：资源使用效率
- **Response Time**：性能
- **Variance**：稳定性
- **No Regression**：质量保证

---

## [P1] Memory-Like-A-Tree 设计哲学
<!-- confidence: 0.9, learned: 2026-03-06 -->

### 三层架构
1. **长期记忆**（MEMORY.md）：核心知识，P0/P1/P2 优先级
2. **分类记忆**（memory/*.md）：语义分类，快速检索
3. **日志记忆**（memory/YYYY-MM-DD.md）：原始记录，完整历史

### 衰减机制
- **时间衰减**：未使用自动降级
- **置信度衰减**：每周 -0.05
- **自动归档**：低置信度条目移除

### 知识图谱
- 跨文件引用：`<!-- 链接: path/to/file.md -->`
- 语义关联：自动识别相关条目
- 搜索工具：`evals/memory-search.sh`

---

## [P2] Bash 脚本最佳实践
<!-- confidence: 0.8, learned: 2026-03-06 -->

### 错误处理
```bash
set -e  # 遇错即停
set -u  # 未定义变量报错
set -o pipefail  # 管道错误传播
```

### 路径处理
```bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"  # 脚本所在目录
```

### 并行执行
```bash
for i in {1..5}; do
  task $i &
done
wait  # 等待所有后台任务完成
```

---

_自动维护：每月整理学习笔记，提炼到 patterns.md_
