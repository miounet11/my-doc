# OpenClaw × autoresearch 融合方案（全面修复导向）

## 1. 结论

`karpathy/autoresearch` 最值得 OpenClaw 吸收的，不是单 GPU 训模型，而是它的 **有边界自治实验回路**：

- 单一可变面（one mutable surface）
- 冻结评估器（frozen evaluator）
- 固定实验预算（fixed budget）
- keep / discard / crash 三态
- 独立结果日志
- 用 `program.md` 这类组织代码驱动 agent 行为

这套机制非常适合 OpenClaw 当前的“全面修复”方向，因为它能减少：
- 假完成
- 阶段漂移
- 一次改太多导致无法归因
- 评估标准跟着被优化对象一起漂移

---

## 2. OpenClaw 当前最该吸收的骨架

### 2.1 单一可变面
每轮自治修复/优化只允许改一个明确 surface，例如：
- 一个脚本
- 一个 prompt
- 一个协议文件
- 一个 skill
- 一个发布流程模板

目的：确保变化可归因。

### 2.2 冻结评估器
被优化对象不能同时修改裁判。

例如：
- 优化发布脚本时，固定 publish probe
- 优化 heartbeat 时，固定 heartbeat 检查项
- 优化路由规则时，固定 readiness / benchmark / failure probes

### 2.3 固定预算
每轮优化必须有边界：
- 固定时间
- 固定轮数
- 固定 token/命令数
- 到点必须停并判定结果

### 2.4 keep / discard / crash
每轮结果都必须明确归档为：
- `keep`：验证后确实更好
- `discard`：跑通了但没更好
- `crash`：没跑通 / 没有有效结果

### 2.5 独立结果日志
不要让改动结果只活在聊天里。

建议每个 bounded loop 都有结构化记录，例如：

```text
artifacts/autoresearch/{loop-id}/
  program.md
  target.md
  evaluator.md
  results.tsv
  runs/
```

---

## 3. 对 OpenClaw 的直接落地位置

## 3.1 发布链路修复循环
适用对象：`publish-mydoc.sh` 等高频脚本

- mutation surface: `scripts/publish-mydoc.sh`
- evaluator: 固定 publish + ssh + http 200 probe
- budget: 每轮 1 次补丁 + 1 次验证
- metric:
  - SSH 可达
  - rsync 成功
  - 远端 rebuild 成功
  - HTTP 200
  - warning 数量下降

### keep 条件
- 成功发布且验证 200
- 没引入额外回退

### discard 条件
- 能跑但无明显改善

### crash 条件
- 连接失败 / shell 出错 / 验证失败

---

## 3.2 Prompt / Protocol 修复循环
适用对象：
- HEARTBEAT
- context-control protocol
- routing rules
- evidence labels
- status/report 模板

- mutation surface: 单一协议或 prompt 文件
- evaluator: 固定 benchmark / fixed probes / fake-success checks
- budget: 每轮 1 个文件 + 1 次验证集
- metric:
  - pass rate
  - fake success 降低
  - token efficiency
  - fewer regressions

---

## 3.3 Skill 迭代循环
适用对象：
- GEO 文档技能
- deploy / ops / research 类技能

- mutation surface: 一个 SKILL.md 或关联模板
- evaluator: 固定任务集
- metric:
  - 完成率
  - 输出可交付性
  - 错误率
  - 用户少追问率

---

## 4. 建议引入的新目录结构

```text
workspace/artifacts/bounded-loops/
  {loop-id}/
    target.md         # 本轮目标
    surface.txt       # 唯一允许修改的 surface
    program.md        # 本轮自治规则
    evaluator.md      # 固定评估逻辑
    results.tsv       # keep/discard/crash 历史
    baseline/         # 基线结果
    runs/             # 每轮产物
```

---

## 5. 建议结果表格式

```tsv
run_id\tsurface\tmetric_before\tmetric_after\tstatus\tdescription
r001\tpublish-mydoc.sh\tssh-flaky\thttp200+stable\tkeep\tprefer explicit password auth and fixed known_hosts
r002\tpublish-mydoc.sh\thttp200\thttp200\tdiscard\tcosmetic log wording only
r003\theartbeat.md\tpass92\tpass0\tcrash\tbroke required inputs
```

---

## 6. 不应该直接照搬的部分

### 6.1 不照搬 “NEVER STOP”
OpenClaw 应吸收 bounded loop，不吸收无限奔跑口号。

### 6.2 不照搬单指标崇拜
OpenClaw 很多任务需要多指标，但仍要有主判定逻辑。

### 6.3 不照搬“代码即全部”
在 OpenClaw 里，很多最有价值的 mutation surface 是：
- prompt
- protocol
- workflow
- skill
- report template
而不只是代码文件。

---

## 7. 与 OpenClaw 现有 doctrine 的一致性

这套吸收方向与当前 doctrine 是一致的：

- Evidence-first：只有测量改进才 keep
- Brain over tool：优化的是 OpenClaw 控制层，不只是执行器输出
- Fake-success suppression：discard / crash 不得伪装成 success
- Memory discipline：实验结果进入 artifacts 和 memory，而不是只留在聊天里

---

## 8. 我对“全面修复”的具体建议

优先顺序：

### P0
1. 为 publish 链路建立 bounded repair loop
2. 为 heartbeat / readiness 建立 bounded prompt loop
3. 为状态检查建立固定 evaluator

### P1
1. 给关键 skill 建立单 surface 迭代机制
2. 给报告模板建立 keep/discard 流程

### P2
1. 做通用 bounded-loop runner
2. 让 OpenClaw 可重复地优化自己的 prompt / protocol / scripts

---

## 9. 一句话总结

`autoresearch` 真正能融入 OpenClaw 的地方，不是自动训模型，而是：

> 用 **单变更面 + 冻结评估器 + 固定预算 + keep/discard 纪律**，把 OpenClaw 的自治修复从“感觉在优化”升级成“可验证的控制迭代”。
