# OpenClaw Product Bible

日期：2026-03-14  
定位：这是一份面向 OpenClaw 本体与同类产品开发的总纲文档。  
目标：把当前系统现状、产品理解、核心能力、生产力门槛、设计原则、反模式、演进路径收敛成一份“天书”。

## 1. 先说结论

OpenClaw 不应该被理解成“一个会聊天的多 Agent 壳子”。

它真正要成为的是：

- 一个本地优先的 AI 操作系统
- 一个把模型、工具、记忆、执行、监督、恢复、外部通道统一起来的控制平面
- 一个可以长期陪伴项目推进，而不是只在单轮对话里表现聪明的系统

一句话定义：

**OpenClaw = Brain OS + Execution OS + Evidence OS。**

如果只有对话，没有执行，不够。  
如果只有执行，没有监督，不够。  
如果只有输出，没有证据，不够。  
如果只有记忆文件，没有可回收能力，也不够。

## 2. 当前系统快照

以下是 2026-03-14 当前工作区的有效系统快照。

### 2.1 网关与访问面

- `gateway.bind = loopback`
- `gateway.auth.mode = token`
- `gateway.auth.allowTailscale = true`
- `gateway.tailscale.mode = serve`
- `gateway.trustedProxies = ["127.0.0.1"]`

产品含义：

- 本机 CLI 是一等公民，不能为了远程访问牺牲本地可用性
- 外部访问应通过 Tailscale 之类的受控网络，而不是裸暴露
- 控制面必须是安全的、可回收的、可诊断的

### 2.2 Agent 编排

当前 agent 集合：

- `main`
- `architect`
- `coder`
- `tester`
- `reviewer`
- `optimizer`
- `evolution`
- `goal-manager`
- `world-model`
- `goal-manager-auto`
- `reviewer-auto`
- `evolution-auto`
- `mentor`
- `claude-code`（ACP）
- `codex`（ACP）

当前心跳策略：

- 默认 heartbeat 为 `500h`
- `claude-code` / `codex` 不走普通角色心跳

产品含义：

- 系统已经不是单 Agent
- 但多 Agent 的价值不在“并行越多越强”，而在角色边界明确、可回收、可收敛
- `main` 必须是脑，不是另一个大号 worker

### 2.3 记忆与上下文

- 长期记忆：`MEMORY.md`
- 每日记忆：`memory/YYYY-MM-DD.md`
- 默认工作区：`/Users/lu/.openclaw/workspace`
- memory search：`ollama / nomic-embed-text`
- compaction：
  - `recentTurnsPreserve = 4`
  - `postCompactionSections = ["Every Session", "Safety"]`

产品含义：

- 记忆已经有层级
- 但“写进记忆”不等于“系统学会”
- 真正的记忆能力标准是：能减少重复错误、改善路由、改善分解、改善恢复

### 2.4 Telegram 团队

当前已接入 Telegram account：

- `main` -> `@atlas_oc_main_20260313_bot`
- `architect` -> `@atlas_oc_architect_20260313_bot`
- `coder` -> `@atlas_oc_coder_20260313_bot`
- `reviewer` -> `@atlas_oc_reviewer_20260313_bot`
- `tester` -> `@atlas_oc_tester_20260313_bot`

当前真实状态：

- 这 5 个 bot 都已经接入 `openclaw.json`
- 这 5 个 provider 都能在运行态进入 `running`
- `main / architect / coder / reviewer` 已可主动对用户私聊发消息
- `tester` 仍需要用户侧先手动 `/start`
- 群聊 privacy 仍受 BotFather 限流影响，当前必须显式 `@mention` 或 reply 才稳定

产品含义：

- IM 通道已经从概念进入可用阶段
- 但距离“成熟多通道协作产品”还有差距
- 真正成熟的 IM 层应支持：
  - direct chat
  - group orchestration
  - thread binding
  - permission model
  - recoverable session mapping

### 2.5 当前系统已经具备的能力类

根据现有能力矩阵与脚本面，当前 OpenClaw 已具备这些大类能力：

- Search
- Browser automation
- Memory
- Exec and debug
- ACP orchestration
- Proactive queue
- Form automation
- GitHub deploy planning
- Email outbox
- Knowledge sync
- Telegram IM

但当前短板不在“有没有这个能力类”，而在：

- 稳定性
- 自证能力
- 默认工作流整合度
- 多通道成熟度
- 监督闭环强度

## 3. 我对 OpenClaw 这种产品的理解

### 3.1 它不是 Chat UI

Chat 只是一个入口，不是产品本体。

如果一个系统只有：

- 会说
- 会搜
- 会调工具
- 会输出看似漂亮的答案

它仍然只是一个增强聊天助手。

OpenClaw 这种产品的真正价值不在“单次回答更聪明”，而在：

- 长任务不丢状态
- 多角色协作不失控
- 能连接外部表面但不丢安全边界
- 可以留下证据、日志、状态、回顾
- 可以把失败转成下次更稳定的规则

### 3.2 它是控制面产品

OpenClaw 的核心不是某一个模型，也不是某一个技能，而是控制面：

- 什么时候问模型
- 什么时候调用工具
- 什么时候 spawn worker
- 什么时候不该继续
- 什么时候先留证据
- 什么时候应该回退
- 什么时候要把判断收回到主脑

如果这些控制面没有做好，再强的模型也只是在放大混乱。

### 3.3 它是长期工作产品

能不能真正有生产力，不看一轮对话，而看三件事：

1. 能不能持续推进一个项目一整天
2. 系统出故障后能不能自诊断和恢复
3. 七天后是不是比今天更少犯同样的错

如果这三件做不到，就不能叫操作系统，只能叫高配聊天壳。

## 4. 这种产品必须完成的核心能力

下面这些能力不是“加分项”，而是骨架。

### 4.1 控制平面

必须具备：

- 统一入口
- 统一配置
- 统一权限模型
- 统一状态观察
- 统一故障恢复

关键问题：

- 当前任务由谁负责
- 当前任务在哪个 runtime 上跑
- 当前输出是否可信
- 当前失败属于模型问题、环境问题、工具问题，还是编排问题

如果没有统一控制面，多 Agent 会退化成多噪音。

### 4.2 执行平面

必须具备：

- shell / file / patch / browser / API / IM 执行能力
- 可追踪的任务状态机
- 长任务的结构化产物

每个执行单元最好至少留下：

- brief
- status
- attempts
- heartbeat
- result
- reflection

如果“生成过计划”会被误当成“已经执行”，那执行平面就是假的。

### 4.3 监督平面

必须具备：

- fake success 检测
- 风险判断
- 路由纠偏
- 目标优先级管理
- 回顾与证据板

这里就是 `reviewer / world-model / goal-manager` 这类角色真正该发挥作用的地方。

没有监督，多 Agent 只会制造更快的幻觉。

### 4.4 记忆平面

必须具备：

- 长期记忆
- 会话记忆
- 项目记忆
- 失败记忆
- 决策记忆
- 检索与压缩

成熟标准不是“有多少记忆文件”，而是：

- 是否在关键时刻被取回
- 是否影响下次判断
- 是否降低重复成本

### 4.5 外部通道平面

必须具备：

- IM 通道
- 浏览器通道
- 本地桌面通道
- 未来的邮件 / GitHub / 表单 / 文档对象通道

但原则必须是：

- local-first
- draft-before-send
- explicit-permission
- recoverable-state

任何直接外发动作都不能是黑箱。

### 4.6 学习平面

必须具备：

- 失败转规则
- 失败转脚本
- 失败转重试策略
- 失败转文档约束
- 学习效果回测

真正的学习不等于“记住今天发生过什么”，而是：

- 下次更早发现
- 下次更少出错
- 下次更少打断用户

### 4.7 可靠性平面

必须具备：

- readiness
- health
- retries
- degraded mode
- auto-recovery
- backups
- log rotation
- failure classification

这部分是大多数 agent 产品最容易偷懒的地方，但它恰恰决定生产力。

## 5. 设置到什么程度，才能真正有生产力

我把成熟度分成五层。

### Level 0: Demo

特征：

- 会聊天
- 会调一两个工具
- 看起来很聪明

但不能：

- 稳定推进项目
- 管理长期上下文
- 在故障中恢复

结论：

- 演示产品，不是生产工具

### Level 1: Useful Assistant

特征：

- 可以完成明确的小任务
- 能读写文件
- 能浏览网页
- 能留下部分结果

但不能：

- 管理复杂项目状态
- 可靠跨天协作
- 多角色高质量收敛

结论：

- 有用，但仍是辅助工具

### Level 2: Productive Assistant

必须满足：

- 有清晰的控制面
- 有证据优先规则
- 有项目级状态板
- 有结构化记忆
- 有稳定工具调用面
- 有最基本的恢复机制

达到这一层，系统才开始真正省时间。

### Level 3: Production Operator

必须满足：

- 长任务可持续运行
- 多通道可用
- 多角色协作可收敛
- 外部动作有草稿和审计
- 故障能自动分级与恢复
- 监督层能主动指出错误方向

达到这一层，系统才配叫“AI 操作系统”。

### Level 4: Self-Improving System

必须满足：

- 失败会自动生成改进动作
- 记忆会改变未来路由
- 监督层会主动回收失控 worker
- 复杂项目不需要频繁人工确认普通下一步

这是 OpenClaw 的长期目标，但当前还没有完全达到。

## 6. 当前 OpenClaw 离真正高生产力还差什么

当前已经接近 `Level 2 ~ Level 3` 之间，但还没完全站稳。

最关键的差距有六个：

### 6.1 运行态证据仍不够统一

同一个系统里，不同命令看到的健康状态有时并不一致。

例如：

- `channels status` 比 `health --json` 更可信
- 某些状态命令会把旧默认账号或降级状态混进来

产品要求：

- 健康状态必须统一、单源、可解释

### 6.2 Telegram 群聊还没达到成熟状态

当前问题：

- group privacy 还没彻底关闭
- ambient 群聊还不稳定
- `tester` 还没完全完成用户侧首次启动

产品要求：

- 每个 bot 的 direct / group / thread 行为都要可预测

### 6.3 监督层已经有形，但还不够自动

当前文档和角色已经到位，但还需要更强的自动回收能力：

- 自动识别假成功
- 自动触发 evidence board 更新
- 自动生成下一步最小闭环动作

### 6.4 学习闭环还需要“效果验证”

当前已有：

- memory
- retrospectives
- heartbeat
- supervision

缺的是真正的回测问题：

- 哪条规则减少了多少错误
- 哪条脚本减少了多少人工介入
- 哪种编排显著提升了成功率

### 6.5 外部通道还不够广

当前 Telegram 已经成形，但要成为同类产品的标杆，还需要：

- 更成熟的 IM 多通道
- 更成熟的邮件 / outbox
- 更成熟的 GitHub / deploy / docs object surface

### 6.6 产品入口还不够统一

现在很多强能力已经有了，但分散在：

- docs
- scripts
- memory
- local conventions

这也是这份“天书”要解决的问题之一。

## 7. 开发同类产品的设计原则

如果我们自己做 OpenClaw 同类型产品，我认为必须守住这些原则。

### 7.1 Evidence First

- 没验证，不许说成功
- 没证据，不许说完成
- 日志、状态、页面、测试、返回值至少有一个

### 7.2 Brain-Hand Separation

- 主脑负责判断、路由、优先级、收敛
- worker 负责执行
- 不允许把最强执行模型长期误当作主脑

### 7.3 Local First

- 本地工作流先成熟
- 之后再接外部平台
- 不要过早 SaaS 化自己的控制面

### 7.4 Draft Before Send

- 邮件先 outbox
- 部署先 bundle
- 表单先 plan
- 外发通道必须有审计边界

### 7.5 Everything Leaves Artifacts

- 任务要留痕
- 错误要留痕
- 回顾要留痕
- 恢复要留痕

没有产物，就没有系统进化。

### 7.6 Multi-Agent Must Converge

- 多 Agent 不等于多并发
- 多 Agent 的价值在于多视角后可收敛
- 任何角色存在都要回答一个问题：
  - 它减少了什么错误？
  - 它提升了什么判断？

### 7.7 Reliability Before Novelty

- 先稳定
- 再自动化
- 再扩通道
- 再追求更高级的主动性

不要反过来。

## 8. 反模式清单

这些是开发此类产品时最危险的坑。

- 把 chat UI 当成产品本体
- 把文档存在当成能力存在
- 把记忆文件增长当成系统学会
- 把 worker 输出当成主脑内化
- 把“理论上会成功”写成“已经成功”
- 把多 Agent 变成多线程噪音
- 把外部集成做得比本地闭环还早
- 用更强模型掩盖系统工程缺陷
- 过早宣称 autonomous，而实际上还要人不断 babysit

## 9. 一套同类产品要达到生产级，最少要过哪些验收门槛

### 9.1 系统门槛

- 网关稳定
- 本地 CLI 稳定
- 有受控远程访问
- 有日志和备份
- 有恢复机制

### 9.2 执行门槛

- 文件 / shell / browser / patch / API 至少四类执行面稳定
- 每类都有失败策略
- 长任务有状态文件

### 9.3 监督门槛

- 至少一个 reviewer 面
- 至少一个 goal/routing 面
- 至少一个 world-state 面
- 有 evidence board 或同等机制

### 9.4 记忆门槛

- 有长期记忆
- 有项目记忆
- 有失败记忆
- 有检索
- 有压缩

### 9.5 通道门槛

- 至少一个成熟 IM 通道
- 至少一个浏览器通道
- 至少一个草稿型外发通道

### 9.6 产品门槛

- 用户不需要理解全部内部结构也能使用
- 默认入口清晰
- 默认失败反馈可理解
- 默认恢复路径明确

## 10. 对 OpenClaw 接下来的规整建议

### 10.1 文档层

建议把文档分成四层：

1. `docs/OPENCLAW_PRODUCT_BIBLE.md`
   - 产品总纲
2. `docs/OPENCLAW_SYSTEM_OBJECTIVE_EVALUATION_V1.md`
   - 当前客观评估
3. `docs/OPENCLAW_STABLE_STATE_BLUEPRINT.md`
   - 稳定态蓝图
4. `docs/OPENCLAW_CAPABILITY_MATRIX.md`
   - 能力矩阵

这样角色清晰：

- Bible：是什么、为什么、到哪算成熟
- Evaluation：现在几分
- Blueprint：理想稳定态怎么长
- Matrix：能力有哪些、成熟度如何

### 10.2 运行层

下一步优先规整：

- 统一 health / status / channels status 的真相来源
- 收紧 Telegram direct/group/thread 行为差异
- 让 BotFather / privacy / onboarding 具备更明确 runbook

### 10.3 产品层

把默认使用方式收敛成一个明确的用户心智：

- 一个主脑入口
- 一组角色入口
- 一套项目工作流入口
- 一组外部通道入口

用户不应该记住 20 个脚本，系统应该替用户记住。

## 11. 最后判断

OpenClaw 现在最宝贵的，不是已经“全做完了”，而是已经开始踩中真正重要的问题：

- 控制面
- 证据
- 主脑回收
- 多 Agent 收敛
- 记忆是否真有效
- 系统是否可恢复

这说明方向是对的。

真正的目标不是“做一个更花哨的 AI 助手”，而是：

**做一个能长期、可信、可恢复、可进化地陪人把真实项目做成的 AI 操作系统。**

如果把这个目标守住，OpenClaw 这条路线是值得持续押注的。
