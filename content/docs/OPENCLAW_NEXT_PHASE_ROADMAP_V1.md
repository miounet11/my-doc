# OpenClaw-Like 产品下一阶段开发方向 v1

日期：2026-03-14  
对象：基于 Pi 开发、当前完成度已较高的 OpenClaw 同类产品  
定位：这不是重复产品总纲，而是下一阶段该怎么打的工程路线文档。

## 1. 结论先行

如果你现在的系统已经具备：

- 多 agent
- 多工具
- 记忆
- 浏览器 / shell / IM / API 执行
- 一定程度的自主调度

那下一阶段不要再把重心放在“再多接几个 agent / channel / feature”。

下一阶段的主线应该是：

**把系统从一个聪明的自动化 demo，推成一个可持续工作的生产级控制面。**

一句话说，就是：

**下一阶段不该继续堆能力广度，而该强化任务闭环、证据闭环、恢复闭环、记忆闭环。**

---

## 2. 你真正要补的，不是 feature，而是 7 个系统骨架

## 2.1 单一真相源控制面

现在很多 OpenClaw-like 系统的真实问题是：

- Telegram 是一套状态
- 本地 CLI 是一套状态
- agent session 是一套状态
- memory 文件又是一套状态
- 人脑里还有一套状态

这会导致系统“看起来很忙”，但没有统一真相。

下一阶段必须把这些对象收口成统一控制面实体：

- `Goal`
- `Task`
- `Run`
- `Worker`
- `Artifact`
- `ChannelBinding`
- `Policy`

要求：

- 所有外部通道都只是“入口”或“视图”，不是事实源
- 所有 agent 执行都必须绑定到 `Task/Run`
- 所有成功、失败、阻塞都必须能回写到统一状态对象

如果这一步不做，多 agent 和多通道只会继续放大混乱。

## 2.2 任务状态机

大多数系统现在是“会接任务”，但不会严谨地推进任务。

下一阶段必须把任务推进从聊天叙事改成状态机。

建议的最小状态集：

- `intake`
- `clarifying`
- `planned`
- `ready`
- `running`
- `awaiting_approval`
- `blocked`
- `verifying`
- `completed`
- `failed`
- `archived`

每个 `Task` 至少要有：

- `id`
- `goal_id`
- `title`
- `owner`
- `status`
- `priority`
- `current_run_id`
- `next_action`
- `blocked_reason`
- `acceptance_criteria`
- `updated_at`

核心要求：

- 没有 `acceptance_criteria`，不能进入 `ready`
- 没有 `Artifact`，不能从 `verifying` 进入 `completed`
- 任何长任务中断后，系统必须能从 `Task + Run` 继续，不依赖上下文运气

## 2.3 Evidence OS

这是最值钱、也最容易被忽略的一层。

真正有生产力的系统，不是“会输出”，而是“会留下可检查证据”。

下一阶段必须让每一次关键动作都产出结构化证据：

- `terminal_log`
- `patch`
- `test_result`
- `page_snapshot`
- `api_response`
- `decision_note`
- `failure_summary`
- `handoff_note`

建议的最小 Artifact 结构：

```json
{
  "id": "art_123",
  "taskId": "task_456",
  "runId": "run_789",
  "type": "test_result",
  "summary": "unit tests passed",
  "uri": "artifacts/tests/2026-03-14/jest.txt",
  "createdAt": "2026-03-14T05:30:00+08:00",
  "verified": true
}
```

这里的原则很硬：

- “计划已写好”不算完成
- “代码已生成”不算完成
- “agent 说成功了”不算完成
- 只有证据挂上去，且过了验证，才算完成

## 2.4 Worker 生命周期治理

你的系统如果 agent 已经很多，下一阶段最该做的不是“再加角色”，而是治理 worker。

每个 worker 必须是受控对象，而不是一段漂浮的上下文。

每个 `Worker` / `Run` 至少要有：

- `brief`
- `task_id`
- `runtime`
- `agent_id`
- `started_at`
- `heartbeat_at`
- `attempt_count`
- `max_attempts`
- `status`
- `last_artifact_id`
- `reflection`

必须补上的治理规则：

- spawn 必须有理由，不允许随手分叉
- worker 必须有 attempt budget
- worker 超时后必须自动分类：环境故障 / 工具故障 / 模型故障 / 目标不清
- 僵尸 worker 必须自动回收
- worker 结束后必须产出 `reflection` 或 `handoff`

没有生命周期治理，系统越强，失控越快。

## 2.5 Action Governance

如果你想把它推到生产力层级，这一层必须做。

不是所有动作都应该被同一种策略执行。

至少分四类：

- `read`
- `write`
- `external_send`
- `destructive`

治理要求：

- `read` 默认放行
- `write` 记录影响面
- `external_send` 需要显式授权或白名单策略
- `destructive` 必须二次确认或 require policy override

进一步要做的是：

- 把“可以主动发 Telegram / 邮件 / GitHub comment / 表单提交”的权限单独建模
- 把“当前 agent 为什么有这个权限”写清楚
- 把“审批”变成系统对象，不要停留在聊天语气里

## 2.6 Memory 从“记录”升级到“可回收”

很多系统已经很会写 memory，但还不够会用 memory。

下一阶段不要继续堆 memory 文件数量，而要改成 memory effectiveness。

真正该做的是三层：

### A. 任务态记忆

- 当前任务的目标、阻塞、最近证据、下一步

### B. 项目态记忆

- 哪些模块容易坏
- 哪些命令可靠
- 哪些流程有坑

### C. 策略态记忆

- 路由规则
- 恢复规则
- 审批规则
- 反模式

衡量标准不是“写了多少条”，而是：

- 是否减少重复错误
- 是否减少重复澄清
- 是否改善路由准确率
- 是否缩短恢复时间

所以你下一阶段该补的是：

- memory 写入准入
- retrieval ranking
- task-type scoped recall
- 记忆命中后的效果回测

## 2.7 Autonomous Recovery

真正生产可用的系统，核心竞争力不是正常时聪明，而是异常时不崩。

下一阶段必须有恢复闭环：

1. 发现异常
2. 分类异常
3. 选择重试 / 切换 / 回退 / 升级人工
4. 写入恢复证据
5. 更新策略

至少要有的错误分类：

- provider timeout
- tool unavailable
- permission denied
- environment drift
- invalid plan
- missing evidence
- blocked by human approval

至少要有的恢复动作：

- retry same run
- reroute to another runtime
- narrow scope and retry
- rollback partial state
- escalate with exact blocker

---

## 3. 下一阶段最值得做的 5 个产品界面

如果你要继续做产品面，而不是只做底层协议，我建议优先级如下。

## 3.1 Operator Console

这是第一优先级。

你需要一个地方能一眼看见：

- 当前有哪些 Goal / Task
- 哪些在跑
- 哪些 blocked
- 哪些 waiting approval
- 哪些 run 卡死
- 最近失败原因是什么

如果没有这块，系统越复杂，人的掌控感越差。

## 3.2 Evidence Board

每个任务都应该能点进去看到：

- 最近执行记录
- 最新证据
- 验证状态
- 当前 blocker
- 下一步动作

这个界面会直接决定你能不能把系统用于真实项目推进。

## 3.3 Worker Inspector

你需要可视化地看到：

- 每个 worker 负责什么
- 当前在第几次尝试
- 最后一次心跳是什么时候
- 死在哪一步
- 是否应该 kill / retry / handoff

这是多 agent 系统从“玄学”变“工程”的分界线。

## 3.4 Approval Inbox

所有需要人类批准的动作必须进入统一收件箱，例如：

- 发消息
- 提交 PR
- 删除文件
- 发布页面
- 修改生产配置

这样人类不需要盯着所有线程，只需要盯决策点。

## 3.5 Memory Debugger

你需要一个地方能回答三个问题：

- 这次为什么召回了这条记忆
- 为什么没召回另一条
- 这条记忆到底改善了什么

没有 memory debugger，记忆系统会很快变成“看起来很多，但谁也说不清有没有用”。

---

## 4. 推荐的实际开发顺序

## Phase P0：先把系统变硬（未来 2-4 周）

目标：从“能跑”变成“可控”。

只做五件事：

1. 建立统一 `Task / Run / Artifact / Worker / Policy` schema
2. 建立任务状态机
3. 建立 evidence gate
4. 建立 worker heartbeat + timeout + retry + reflection
5. 建立 approval gate

这阶段要克制住，不要分心去做：

- 新 agent 角色
- 新聊天入口
- 新花哨 UI
- 新记忆格式

## Phase P1：把系统变成长期工作体（未来 4-8 周）

目标：从“可控”变成“能持续推进”。

做四件事：

1. 项目级 evidence board
2. 项目级恢复策略库
3. task-type memory retrieval
4. run resume / handoff

完成标志：

- 一个跨天任务可以恢复
- 一个失败任务可以重试
- 一个换人接手任务可以继续
- 一个 channel 断掉不会让任务蒸发

## Phase P2：再做多通道和多团队爆发（未来 8-12 周）

目标：从“能持续推进”变成“可扩展”。

这时再去扩：

- Telegram / Slack / Email / GitHub / Browser 等多通道统一收口
- 多 agent 分工自动化
- 主动任务队列
- 日程 / 定时 / SLA / escalation
- 群聊协作和 thread binding

这一步应该建立在前两步已经稳定之上。

否则你只是把更多流量接入一个还不稳定的中枢。

---

## 5. 生产力门槛怎么判断

你的系统达到下面这些标准，才算真正进入生产力区，而不是演示区：

1. 一个任务从 intake 到 completed，状态转换是显式的，不靠聊天理解。
2. 一个任务完成时，必然能看到对应证据。
3. 一个 worker 挂掉后，5 分钟内系统能判断该 retry、reroute 还是 blocked。
4. 人类不需要翻所有对话，只看 console 就知道当前全局状态。
5. 记忆能减少重复错误，而不是只增加文档体积。
6. 外部动作有审批，不会因为 agent 兴奋就直接发出去。
7. 多 agent 的价值体现在收敛速度和质量，而不是输出数量。
8. 一个项目可以连续跑 8 小时以上，不靠人工频繁救火。

---

## 6. 你现在最该避免的 6 个误区

1. 把更多 agent 当成更强系统。
2. 把更多 channel 当成更高完成度。
3. 把 memory 条目数当成学习能力。
4. 把 plan 生成速度当成执行能力。
5. 把“会主动发消息”误认为“会自主完成任务”。
6. 把 UI 丰富度误认为控制面成熟度。

---

## 7. 我给你的直接建议

如果你现在基于 Pi 做的这个系统完成度已经很高，我建议你接下来 30 天只盯一条主线：

**把控制面对象化，把执行面状态化，把结果证据化，把异常恢复化。**

更直白一点：

- 先别急着继续做“更像人”
- 先把它做成“更像操作系统”

只有这一步做完，后面不论你要做：

- agent 团队
- IM 协作
- 主动任务
- 群聊会话
- 长期项目陪跑

才会真的进入“爆炸级效果”，而不是“爆炸级复杂度”。

---

## 8. 最后给 Pi 的一句指令

如果你要把这份文档发给 Pi，可以直接给它一句很硬的话：

**下一阶段暂停 feature-first，改为 control-plane-first；暂停 agent 扩张，改为 task/evidence/recovery 三件套优先；暂停表面聪明，改为长期可控。**
