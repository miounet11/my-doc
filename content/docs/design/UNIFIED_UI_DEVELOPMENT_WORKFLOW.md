# 后续项目统一 UI 开发工作流（Goal-Driven × AI Design × Frontend Implementation）

日期：2026-03-19

## 目标
为后续所有项目建立统一的 UI 开发工作流，把需求目标、AI-native 设计方法、原型验证、前端实现、测试验收串成一条高一致性链路。

这套流程不是“先设计、后开发”的传统瀑布，而是：

> Goal → Flow → Structure → AI Design Exploration → Review → Frontend System → Validation → Iteration

---

## 一、总流程概览

```text
1. Goal Definition
2. User / Task Flow Design
3. Information Architecture
4. AI Design Exploration
5. Human Review & Selection
6. Design System Mapping
7. Frontend Implementation
8. Interaction / State Validation
9. Review Archive & Iteration
```

---

## 二、阶段拆解

### Phase 1 — Goal Definition（目标定义）
在任何 UI 开工前，先定义：
- 用户是谁
- 用户当前任务是什么
- 页面成功条件是什么
- 失败/中断状态是什么
- 哪些信息必须优先呈现
- 哪个动作最高频

**输出物**：
- `GOAL_DRIVEN_UI_BRIEF.md`

**禁止**：
- 直接进入画页面
- 先谈视觉风格，后补任务逻辑

---

### Phase 2 — User / Task Flow Design（任务流设计）
先画流程，不先画精修页：
- 起点页
- 中间状态
- 分支路径
- 失败恢复路径
- 完成页

**输出物**：
- `USER_FLOW.md`
- `STATE_FLOW.md`

**原则**：
- flow-first > page-first

---

### Phase 3 — Information Architecture（信息架构）
定义每个页面：
- 主信息
- 次信息
- 行动区
- 状态反馈区
- 风险提示区
- 辅助信息区

**输出物**：
- `IA_MAP.md`
- `PAGE_ROLE_TABLE.md`

**原则**：
- hierarchy correctness > visual richness

---

### Phase 4 — AI Design Exploration（AI 设计探索）
在目标、flow、IA 已明确之后，用 AI-native 设计方式做快速探索：
- 输出多个页面方向
- 输出多种信息布局
- 输出风格变体
- 输出跨页面原型

**AI 的角色**：
- 放大探索速度
- 帮助快速做变体
- 帮助形成高保真草案

**AI 不负责**：
- 产品真相判断
- 复杂业务逻辑判断
- 最终交互取舍

**输出物**：
- `DESIGN_VARIANTS.md`
- `PROTOTYPE_NOTES.md`

---

### Phase 5 — Human Review & Selection（人工审稿与选型）
必须人工审查：
- 信息顺序是否正确
- 高频动作是否足够轻量
- 风险反馈是否明确
- 页面是否只是“热闹”而非“高效”
- 是否符合后续工程实现

**角色分工**：
- architect：看结构与任务逻辑
- reviewer：看可理解性与噪音控制
- coder：看组件边界与实现成本
- tester：看关键路径与异常路径

**输出物**：
- `UI_REVIEW_DECISION.md`

---

### Phase 6 — Design System Mapping（设计系统映射）
把已选方案映射到统一设计系统：
- color roles
- typography
- spacing scale
- surfaces
- button / input / card / panel patterns
- empty / loading / error / success states

**输出物**：
- `DESIGN_SYSTEM_MAP.md`
- `COMPONENT_INVENTORY.md`

**原则**：
- 设计系统前置，不做最后补丁式统一

---

### Phase 7 — Frontend Implementation（前端实现）
实现时必须按组件系统和状态模型落地：
- 组件抽象
- 布局系统
- 响应式策略
- 页面容器与状态分离
- 可测试交互点

**输出物**：
- component library
- page implementations
- state model notes

**原则**：
- design must be implementation-aware

---

### Phase 8 — Interaction / State Validation（交互与状态验证）
不是“页面能打开”就算完成，必须验证：
- 主任务是否顺畅
- 中断恢复是否清晰
- 错误状态是否有反馈
- loading / empty / success / fail 是否一致
- 移动端 / 桌面端是否都合理

**输出物**：
- `UI_ACCEPTANCE.md`
- `STATE_CHECKLIST.md`

---

### Phase 9 — Review Archive & Iteration（归档与迭代）
每次重要 UI 迭代都应留痕：
- 做了什么变化
- 为什么改
- 哪些问题解决了
- 哪些问题仍存在
- 下一轮改进点是什么

**输出物**：
- `ITERATION_LOG.md`
- `UI_RETROSPECTIVE.md`

**原则**：
- 设计迭代必须可回看、可比较、可学习

---

## 三、统一角色分工

### main
- 统筹目标、方法论、审稿标准、长期沉淀

### architect
- 负责目标拆解、流程、信息架构、系统级一致性

### coder
- 负责组件化、前端实现、设计系统工程化

### reviewer
- 负责降噪、发现假优化、识别体验缺陷

### tester
- 负责验证主路径、异常路径、状态反馈与一致性

---

## 四、统一工作原则

### 原则 1：Goal-first
所有 UI 必须服务明确任务目标。

### 原则 2：Flow-first
优先设计任务流和状态流，而不是孤立页面。

### 原则 3：System-first
设计系统从第一天就存在。

### 原则 4：AI-for-exploration
AI 用于探索和变体，不代替判断。

### 原则 5：Implementation-aware
设计必须考虑组件化和可实现性。

### 原则 6：Evidence-based review
任何“UI 变好了”的判断都要有实际证据：路径更短、理解更快、状态更清晰、错误更少。

### 原则 7：Archive everything important
每轮重要 UI 迭代都需要可追溯记录。

---

## 五、适用范围
这套流程适用于：
- OpenClaw 工作台
- mydoc / archive center
- 多代理协作界面
- 业务后台 / SaaS 工作台
- 内容工厂与控制台
- 后续所有需要长期维护的产品界面

---

## 六、一句话总结
> 后续项目统一 UI 工作流，不再是“设计一张图，再让前端照着写”，而是“从目标出发，用 AI 加速探索，用设计系统保持一致，用前端工程化落地，用测试和归档保证长期演进”。
