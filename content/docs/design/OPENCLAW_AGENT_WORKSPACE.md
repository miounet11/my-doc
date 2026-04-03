# OpenClaw Agent 工作台方案

日期：2026-03-19

## 目标
设计一个真正面向 Agent 协作与执行验证的工作台，而不是聊天窗口加侧边栏。这个工作台要让用户和系统都能清楚看到：
- 当前目标是什么
- 谁在执行
- 用了什么工具
- 有什么证据
- 哪些地方失败了
- 下一步应该是什么

---

## 一、产品定位
OpenClaw Agent 工作台是：
- 多代理协作的主界面
- 目标驱动执行面板
- evidence-first 状态中心
- 任务 / 文档 / memory / review 的连接层
- 人机协作的控制驾驶舱

一句话：
> 它不是“更高级的聊天框”，而是一个能看见目标、执行、证据、审查和恢复的 agent-native workspace。

---

## 二、工作台核心结构

### 顶部状态条
显示：
- 当前主目标
- 当前工作模式（执行 / review / archive / recovery）
- 当前活跃 agent
- 当前上下文规模
- 最近一次验证状态

### 左侧：任务与会话区
用于：
- 当前任务列表
- 最近任务
- 已归档任务
- 会话切换
- 目标分组

目标：让用户快速看到“正在干什么”和“还有什么没干”。

### 中央：主工作区
根据当前模式切换：

#### 模式 A：执行模式
显示：
- 当前任务说明
- agent 输出流
- 工具调用摘要
- 当前产物链接
- 下一步建议

#### 模式 B：Review 模式
显示：
- reviewer 意见
- mentor-style feedback
- 风险点
- 质量判断
- 差距与修正建议

#### 模式 C：Archive 模式
显示：
- 当前任务相关文档
- memory 片段
- evidence 文件
- 归档动作

#### 模式 D：Recovery 模式
显示：
- 最近失败点
- 失败原因
- 阻塞状态
- 重试路径
- 手动接管入口

---

### 右侧：证据与状态面板
这是工作台最关键的部分，必须比普通聊天产品更强。

固定显示：
- 最近工具调用
- 最近验证结果
- 最近 artifacts
- evidence checklist
- 当前 risk / uncertainty
- memory context 摘要

#### evidence checklist 示例
- [ ] 文件已生成
- [ ] 页面已返回 200
- [ ] 关键路径已验证
- [ ] raw output 已保存
- [ ] review 已完成

目标：任何“完成”都必须能被证据支持。

---

## 三、关键页面 / 区域

### 1. Goal Board
展示：
- 当前总目标
- 子目标
- 每个目标状态
- 优先级
- 负责人 agent

### 2. Execution Timeline
按时间显示：
- 任务开始
- 关键调用
- 关键产物
- 失败与恢复
- 完成验证

### 3. Agent Roster
显示多代理状态：
- main
- reviewer
- architect
- coder
- tester

每个 agent 卡片显示：
- 当前角色
- 当前关注点
- 最近输出
- 是否阻塞

### 4. Artifact Panel
统一展示：
- docs
- memory
- code changes
- reports
- screenshots
- review files

### 5. Recovery Center
当任务异常时：
- 直接列出阻塞点
- 显示建议修复路径
- 显示可重试命令/动作
- 保留历史错误记录

---

## 四、设计原则

### 1. Goal-first
用户一进来先看到目标，不是先看到消息流。

### 2. Evidence-first
任何阶段性成果都必须能对应具体证据。

### 3. Mode-based workspace
不同工作模式应该切换不同主视图，而不是全塞在一个聊天流里。

### 4. Human-legible autonomy
自治过程必须让人能读懂、能追踪、能接管。

### 5. Low-noise, high-signal
尽量少花哨，强调状态、证据、路径、产物。

### 6. Recovery is first-class
失败恢复不是异常角落，而是工作台中心能力之一。

---

## 五、适合后续吸收 Stitch 方法的部分

最适合用 Stitch 风格来重构的点：
- workspace 布局层次
- 多屏 flow 连接
- 模式切换视图
- 统一设计系统
- 变体探索（桌面工作台 / 移动控制台）

但不能外包给 Stitch 判断的部分：
- evidence 模型
- agent 角色边界
- 风险表达逻辑
- 失败恢复链路

---

## 六、实施建议

### 第一阶段
- 先做 Goal Board + Execution + Evidence 三栏骨架
- 把聊天从“唯一主视图”降级成“工作区的一部分”

### 第二阶段
- 增加 Review 模式和 Recovery 模式
- 增加 agent roster 和 artifact panel

### 第三阶段
- 增加 archive / memory 连接能力
- 增加设计系统与组件层统一
- 做桌面端 / 移动端变体

---

## 七、一句话总结
> OpenClaw Agent 工作台的目标，不是把聊天做得更炫，而是把目标、执行、证据、审查、恢复整合成一个真正可操作的 agent-native workspace。
