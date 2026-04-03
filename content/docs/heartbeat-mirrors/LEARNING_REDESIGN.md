# 🧠 小龙虾学习系统重构方案

## 当前问题

### 1. 空转问题
```bash
# autonomous-loop.ts:293
execCommand(`openclaw chat --agent ${task.assignee} "${task.description}"`);
# ❌ 'chat' 命令不存在，每次都失败
# ❌ 但 line 296 标记为 completed
```

### 2. 虚假学习
- 100 条经验记录都是 "目标成功完成"
- 没有真实的 Agent 执行
- 没有实际的反馈数据
- 学习引擎在处理垃圾数据

---

## 重构方案

### 阶段 1: 修复 Agent 通信 (立即)

```typescript
// autonomous-loop.ts:285-303
async function executeTasks(tasks: Task[]): Promise<void> {
  log(`⚡ 执行 ${tasks.length} 个任务...`);

  for (const task of tasks) {
    log(`  - ${task.description} (分配给: ${task.assignee})`);

    try {
      // ✅ 使用正确的命令
      const command = `openclaw agent --agent ${task.assignee} --message "${task.description}" --json`;
      const output = execCommand(command);

      // ✅ 解析 JSON 响应
      const result = JSON.parse(output || '{}');

      // ✅ 根据实际结果判断
      if (result.success !== false) {
        task.status = 'completed';
        task.result = result;
        log(`  ✅ 完成: ${task.description}`);
      } else {
        task.status = 'failed';
        task.error = result.error;
        log(`  ❌ 失败: ${result.error}`, 'error');
      }
    } catch (error) {
      task.status = 'failed';
      task.error = String(error);
      log(`  ❌ 异常: ${error}`, 'error');
    }
  }
}
```

### 阶段 2: 真实反馈机制 (核心)

```typescript
// learning-engine.ts - 增强 Experience 结构
interface Experience {
  id: string;
  timestamp: Date;

  // 上下文
  context: {
    state: SystemState;      // 系统状态
    goal: string;            // 目标描述
    constraints: string[];   // 约束条件
  };

  // 动作
  action: {
    type: string;            // 动作类型
    params: any;             // 参数
    agent: string;           // 执行 Agent
    command: string;         // 实际命令
  };

  // 结果 (真实数据)
  outcome: {
    success: boolean;        // ✅ 真实成功/失败
    result: any;             // ✅ Agent 返回的数据
    duration: number;        // ✅ 实际耗时
    cost: number;            // ✅ Token 消耗
    error?: string;          // ✅ 错误信息
  };

  // 奖励 (基于真实结果计算)
  reward: number;            // -1 到 +1
}
```

### 阶段 3: 智能目标识别 (进化)

```typescript
// autonomous-loop.ts - 更智能的目标识别
function identifyGoals(observation: Observation): Goal[] {
  const goals: Goal[] = [];

  // 1. 系统维护目标
  if (observation.system.disk > 80) {
    goals.push({
      id: `goal-${Date.now()}-disk`,
      type: 'maintenance',
      description: '清理磁盘空间',
      priority: 'P0',
      reason: `磁盘使用率 ${observation.system.disk}% > 80%`,
      impact: 'system_health',
      estimatedEffort: 1,
      expectedOutcome: { freed: 1024 } // ✅ 预期结果
    });
  }

  // 2. 从历史学习目标
  const recentFailures = getRecentFailures();
  if (recentFailures.length > 3) {
    goals.push({
      id: `goal-${Date.now()}-analyze-failures`,
      type: 'learning',
      description: `分析最近 ${recentFailures.length} 次失败`,
      priority: 'P1',
      reason: '失败率上升，需要分析原因',
      impact: 'capability',
      estimatedEffort: 2,
    });
  }

  // 3. 主动优化目标
  const patterns = analyzePatterns();
  if (patterns.repetitive.length > 0) {
    goals.push({
      id: `goal-${Date.now()}-automate`,
      type: 'proactive',
      description: `自动化重复任务: ${patterns.repetitive[0].name}`,
      priority: 'P2',
      reason: `任务重复 ${patterns.repetitive[0].count} 次`,
      impact: 'efficiency',
      estimatedEffort: 3,
    });
  }

  return goals;
}
```

### 阶段 4: 强化学习循环 (AGI)

```typescript
// learning-engine.ts - 真正的学习
class LearningEngine {
  async learn(): Promise<void> {
    console.log('\n🧠 开始学习循环...');

    const experiences = this.buffer.getRecent(100);

    // 1. 分析成功模式
    const successPatterns = this.analyzeSuccessPatterns(experiences);
    console.log(`✅ 发现 ${successPatterns.length} 个成功模式`);

    // 2. 分析失败原因
    const failureReasons = this.analyzeFailures(experiences);
    console.log(`❌ 识别 ${failureReasons.length} 个失败原因`);

    // 3. 更新策略
    for (const pattern of successPatterns) {
      if (pattern.confidence > 0.8) {
        this.policyManager.addRule({
          condition: pattern.context,
          action: pattern.action,
          priority: Math.floor(pattern.confidence * 100),
          confidence: pattern.confidence,
        });
      }
    }

    // 4. 生成改进建议
    const improvements = this.generateImprovements(failureReasons);
    console.log(`💡 生成 ${improvements.length} 个改进建议`);

    // 5. 自动执行高置信度改进
    for (const improvement of improvements) {
      if (improvement.confidence > 0.9 && improvement.risk === 'low') {
        await this.executeImprovement(improvement);
      }
    }
  }

  private analyzeSuccessPatterns(experiences: Experience[]): Pattern[] {
    const successful = experiences.filter(e => e.outcome.success);

    // 按 action type 分组
    const grouped = this.groupBy(successful, e => e.action.type);

    const patterns: Pattern[] = [];

    for (const [actionType, exps] of Object.entries(grouped)) {
      if (exps.length < 3) continue;

      // 提取共同特征
      const commonContext = this.extractCommonContext(exps);
      const avgReward = exps.reduce((sum, e) => sum + e.reward, 0) / exps.length;

      patterns.push({
        id: `pattern-${actionType}-${Date.now()}`,
        name: `${actionType} 成功模式`,
        context: commonContext,
        action: { type: actionType, template: exps[0].action.params },
        confidence: exps.length / successful.length,
        frequency: exps.length,
        avgReward,
      });
    }

    return patterns;
  }
```
