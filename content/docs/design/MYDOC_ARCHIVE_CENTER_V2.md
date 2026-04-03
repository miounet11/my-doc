# mydoc.inping.com 新版归档中心方案

日期：2026-03-19

## 目标
把 `mydoc.inping.com` 从“静态文件目录页”升级为真正的资料资产中心，让文档、记忆、评估、情报、快照都能被清晰查看、按日期追踪、按类别检索，并支持长期稳定增长而不失控。

---

## 一、产品定位
`mydoc.inping.com` 不只是站点，而是：
- OpenClaw 与项目资料的对外可读归档面
- 阶段成果提交中心
- review / mentor feedback / intel 的沉淀面
- 重要 bootstrap 文件和 memory 的备份面
- 后续 GitHub / NAS 同步的上游整理层

一句话：
> 这是知识资产中心，不是文件列表页。

---

## 二、首页结构（新版）

### 顶部区域
- 站点标题
- 今日更新时间
- 最近一次 review 时间
- 最近一次快照时间
- 快速入口按钮

### 一级导航
1. Today
2. Review Archive
3. Intel Archive
4. Memory
5. Core Docs
6. Workspace Core
7. Projects
8. Snapshots

### 首页默认展示模块
#### 1. 今日新增
- 今天新增文档数
- 今天新增 review 数
- 今天新增 memory 数
- 直接跳转链接

#### 2. 最近评审
展示最近 3 次：
- phase-review
- mentor-feedback
- intel-brief
- llm-review

#### 3. 核心资料入口
- MEMORY.md
- SOUL.md
- USER.md
- TOOLS.md
- IDENTITY.md

#### 4. 项目资料入口
- 每个活跃项目显示名称、最近更新时间、文档数

#### 5. 归档状态卡片
- review archive 状态
- intel archive 状态
- snapshot 状态
- GitHub sync 状态（后续）

---

## 三、目录与信息架构

### 推荐目录
```text
/content/
  archive/
    review/
      YYYY-MM-DD/
    submissions/
      YYYY-MM-DD/
    snapshots/
      YYYY-MM-DD/
    intel/
      daily/
      weekly/
      state/
  docs/
    doctrine/
    protocols/
    architecture/
    operations/
    reports/
  memory/
    daily/
    distilled/
  workspace-root/
  projects/
    <project>/
      docs/
      reviews/
      evidence/
```

### 信息组织原则
- 时间变化的内容：按日期归档
- 稳定说明类文档：按主题分类
- 项目资料：按项目聚合
- 核心 bootstrap 文件：固定入口
- 自动生成内容与手工总结内容分开

---

## 四、关键页面设计

### 1. Today 页面
展示：
- 今日新增文档
- 今日 review 包
- 今日情报
- 今日 memory
- 今日快照

目标：快速回答“今天有什么变化”。

### 2. Review Archive 页面
按日期列出：
- phase-review
- mentor-feedback
- intel-brief
- llm-review
- evidence.json

支持：
- 日期筛选
- 最近 7 天 / 30 天切换
- 缺失项提示（比如某天没有 llm-review）

### 3. Intel Archive 页面
按：
- 日报
- 周报
- source category
- priority（P0/P1/P2）

目标：避免情报成为一堆散文档。

### 4. Memory 页面
分成两块：
- daily memory
- distilled memory

用户能直观看到：
- 每日记录
- decisions
- learnings
- patterns
- system knowledge

### 5. Workspace Core 页面
固定展示：
- MEMORY.md
- SOUL.md
- USER.md
- TOOLS.md
- IDENTITY.md

### 6. Projects 页面
每个项目卡片显示：
- 项目名
- 最近更新时间
- 文档数量
- evidence / review / docs 入口

### 7. Snapshots 页面
用于查看某个日期的关键快照：
- bootstrap docs snapshot
- project summary snapshot
- archive snapshot metadata

---

## 五、交互原则

### 1. 信息优先，不追求花哨
优先级：
- 可找
- 可追踪
- 可比较
- 可回看

### 2. 日期驱动必须明显
每个时间相关模块都应有：
- 生成时间
- 最后更新时间
- 时间范围筛选

### 3. 缺失状态必须显式
如果某天：
- review 缺失
- llm-review 失败
- intel 未生成
- snapshot 未落地
必须明确显示，不允许假装正常。

### 4. 文件浏览应服务于理解，而不只是下载
不是只让人点 raw file，而是帮助人理解结构和上下文。

---

## 六、实施建议

### 第一阶段
- 重做首页导航
- 增加 Today / Review / Memory / Projects 入口
- 补分类目录和状态卡片

### 第二阶段
- 给 archive 页面加日期索引
- 增加自动生成的 index.json / listing
- 展示缺失项与生成状态

### 第三阶段
- 打通 GitHub sync 状态
- 打通 NAS 备份状态
- 增加全文检索 / 主题筛选（后续）

---

## 七、一句话总结
> `mydoc.inping.com` 的新版升级目标，不是让它更像“漂亮文件站”，而是让它成为一个按日期组织、按职责分层、可长期演进的资料资产中心。
