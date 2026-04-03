# Auto Growth Engine 开发文档

> 目标：复刻并超越 GoShipFast 的核心逻辑，做一个面向 SaaS founder / indie hacker / 小团队的「自动获客系统」，实现从关键词挖掘、内容生产、渠道分发到注册归因的闭环。

## 1. 产品定义

### 1.1 一句话定位
一个帮助 SaaS 和独立开发者自动完成 **买家关键词发现 -> 内容生成 -> 多渠道分发 -> 注册归因 -> 持续优化** 的增长引擎。

### 1.2 用户价值
用户不需要：
- 自己做 SEO
- 自己写大量内容
- 自己管理分发节奏
- 自己拼装归因工具链

用户得到：
- 持续发现高意图关键词
- 持续产出博客 / 落地页 / 社媒内容
- 自动或半自动发布到渠道
- 知道哪些内容真正带来注册
- 每周获得增长动作和结果汇总

### 1.3 目标用户
- SaaS founder
- indie hacker
- 小团队
- 重增长但没有专职 SEO / content / growth 团队的项目

---

## 2. 产品原则

1. **卖结果，不卖工具堆砌**
   - 对外不是“SEO 工具”
   - 对外是“自动获客系统”

2. **闭环优先，不做单点功能炫技**
   - 关键词
   - 内容
   - 分发
   - 归因
   - 优化

3. **先服务化，后平台化**
   - MVP 阶段允许人工 + AI + workflow
   - 先验证用户愿不愿意付费
   - 再逐步产品化

4. **证据优先**
   - 不把“已生成内容”当成增长成功
   - 成功指标必须落到点击、注册、转化

---

## 3. 核心业务逻辑

### 3.1 闭环链路
1. 发现高购买意图关键词
2. 对关键词打分排序
3. 生成内容 brief
4. 生成博客 / 落地页 / 社媒内容
5. 分发到博客、X、LinkedIn 等渠道
6. 记录曝光、点击、注册
7. 归因分析哪些内容真正带来用户
8. 下一轮优先生成更高 ROI 内容

### 3.2 核心差异点
与传统工具相比：
- 不是只给关键词建议
- 不是只给 AI 写作
- 不是只给社媒排程
- 不是只给分析面板

而是：
**把整条增长链做完**

---

## 4. MVP 范围

### 4.1 MVP 目标
交付一个可运行的最小闭环，让一个项目可以：
- 配置网站和产品信息
- 获取一批高意图关键词
- 自动生成一组内容草稿
- 发布到至少 2 个渠道
- 追踪内容带来的注册
- 在 dashboard 中看到每周结果

### 4.2 MVP 必备模块

#### 模块 A：Project Workspace
功能：
- 创建项目
- 填写产品描述
- 录入 ICP
- 配置官网域名
- 配置目标市场 / 语言
- 配置竞争对手
- 配置分发渠道

#### 模块 B：Keyword Engine
功能：
- 导入 / 抓取关键词
- 自动打意图分
- 自动打相关性分
- 自动优先级排序
- 标记已采用 / 已生成 / 已发布

#### 模块 C：Content Engine
功能：
- 根据关键词生成 article brief
- 生成博客草稿
- 生成 landing page copy
- 生成 X / LinkedIn 文案
- 保留人工审核入口

#### 模块 D：Distribution Engine
功能：
- 发布到博客
- 发布到 X
- 发布到 LinkedIn
- 记录发布时间和 URL
- 支持手动审核后发布

#### 模块 E：Attribution Engine
功能：
- UTM 自动生成
- 记录内容来源
- 捕获注册来源
- 建立 content -> click -> signup 的映射
- 汇总每条内容带来的注册数

#### 模块 F：Weekly Dashboard
功能：
- 本周发现关键词数
- 本周生成内容数
- 本周发布内容数
- 本周带来注册数
- 高 ROI 内容榜单
- 下周建议动作

---

## 5. 用户流程

### 5.1 Onboarding
1. 用户创建项目
2. 填写产品基础信息
3. 选择目标市场和语言
4. 输入官网和竞争对手
5. 授权博客 / X / LinkedIn / analytics
6. 进入增长 dashboard

### 5.2 每周系统流程
1. 系统发现新关键词
2. 系统筛出高意图关键词
3. 系统生成内容计划
4. 系统生成草稿
5. 系统自动或半自动发布
6. 系统追踪点击与注册
7. 系统出周报和建议

---

## 6. 系统架构

### 6.1 总体架构

```text
Frontend (Next.js)
  ├── Landing Page
  ├── App Dashboard
  ├── Project Settings
  ├── Keyword Board
  ├── Content Queue
  └── Analytics Dashboard

Backend API
  ├── Auth / User / Project API
  ├── Keyword API
  ├── Content API
  ├── Distribution API
  ├── Attribution API
  └── Reporting API

Workers / Pipelines
  ├── Keyword Discovery Worker
  ├── Keyword Scoring Worker
  ├── Content Generation Worker
  ├── Distribution Worker
  ├── Attribution Sync Worker
  └── Weekly Summary Worker

Data Layer
  ├── Postgres
  ├── Queue (Redis / pg-boss / BullMQ)
  ├── Object Storage (optional)
  └── Analytics store (same DB first, warehouse later)

Integrations
  ├── LLM provider
  ├── Search / keyword sources
  ├── Blog CMS
  ├── X API
  ├── LinkedIn API
  ├── PostHog / Plausible / GA4
  └── Email / waitlist
```

### 6.2 推荐技术栈

#### 前端
- Next.js
- Tailwind CSS
- shadcn/ui

#### 后端
- Next.js Route Handlers 或 NestJS
- Postgres
- Prisma / Drizzle
- Redis 或 pg-boss

#### AI / 内容生成
- OpenAI / Claude
- prompt templates
- structured output schema

#### 分析 / 归因
- PostHog 或 Plausible
- 自建 event ingestion
- UTM tracking

#### 部署
- Vercel / self-hosted
- Supabase / Neon / RDS

---

## 7. 数据模型设计

### 7.1 users
- id
- email
- name
- created_at

### 7.2 projects
- id
- user_id
- name
- website_url
- product_summary
- icp_summary
- target_market
- primary_language
- status
- created_at

### 7.3 competitors
- id
- project_id
- domain
- notes

### 7.4 channels
- id
- project_id
- type (`blog`, `x`, `linkedin`)
- auth_status
- config_json

### 7.5 keywords
- id
- project_id
- query
- source
- intent_score
- relevance_score
- difficulty_score
- priority_score
- cluster_name
- status
- created_at

### 7.6 content_items
- id
- project_id
- keyword_id
- type (`blog`, `landing_page`, `x_post`, `linkedin_post`)
- title
- brief
- draft_markdown
- final_content
- review_status
- generation_status
- created_at

### 7.7 distribution_jobs
- id
- project_id
- content_item_id
- channel_type
- scheduled_at
- published_at
- external_url
- status
- error_message

### 7.8 attribution_events
- id
- project_id
- content_item_id
- keyword_id
- visitor_id
- source
- medium
- campaign
- event_type (`visit`, `signup`, `purchase`)
- event_value
- occurred_at

### 7.9 weekly_reports
- id
- project_id
- week_start
- keywords_found
- contents_generated
- contents_published
- signups_attributed
- summary_markdown

---

## 8. 核心服务设计

### 8.1 Keyword Discovery Service
输入：
- project profile
- website
- competitor list
- target market

输出：
- 新关键词列表
- keyword cluster
- intent 评估

来源可以包括：
- 搜索建议
- competitor pages
- Search Console
- 第三方关键词 API
- 用户手动导入

### 8.2 Keyword Scoring Service
评分维度：
- buyer intent
- 与产品相关性
- 搜索难度
- 商业价值
- 内容可产出性

最终输出：
- priority_score
- recommended content type
- suggested angle

### 8.3 Content Generation Service
输入：
- keyword
- project profile
- competitor context
- brand voice

输出：
- article brief
- article draft
- landing copy
- social posts
- meta title / description

要求：
- 支持 structured generation
- 支持人工审核
- 保留 prompt + generation trace

### 8.4 Distribution Service
支持：
- 博客发布
- X 发布
- LinkedIn 发布
- 定时发布

输出：
- publish status
- published url
- channel metrics hook

### 8.5 Attribution Service
目标：
- 将内容和注册建立尽可能明确的关联

实现方式：
- 每条内容带独立 UTM
- 页面访问埋点
- signup 时记录 first-touch / last-touch
- content_item_id 作为主关联键

### 8.6 Reporting Service
每周输出：
- 本周发现关键词
- 本周发布内容
- 带来注册的内容排行
- 表现最佳关键词簇
- 下周建议优先级

---

## 9. Workflow 设计

### 9.1 Workflow A: Keyword Discovery
定时任务：每天 / 每周
1. 拉取项目配置
2. 抓取候选关键词
3. 去重
4. 评分
5. 写入 keyword queue

### 9.2 Workflow B: Content Planning
1. 选取 top keywords
2. 生成 content brief
3. 选择内容类型
4. 写入 content queue

### 9.3 Workflow C: Content Generation
1. 读取 content task
2. 调用 LLM 生成内容
3. 存 draft
4. 标记待审核 / 可发布

### 9.4 Workflow D: Distribution
1. 获取待发布内容
2. 按渠道格式化
3. 发布或定时发布
4. 记录 URL 与状态

### 9.5 Workflow E: Attribution Sync
1. 拉取 analytics events
2. 匹配 UTM / content id
3. 归因到 keyword / content
4. 更新 dashboard metrics

### 9.6 Workflow F: Weekly Summary
1. 聚合本周数据
2. 生成 summary
3. 生成 next actions
4. 推送到 dashboard / email

---

## 10. 页面信息架构

### 10.1 落地页
- Hero
- Why this matters
- How it works
- Dashboard preview
- For who
- Founder pricing / waitlist
- FAQ

### 10.2 App Dashboard
- 本周关键词
- 本周内容
- 本周发布
- 本周注册
- ROI top content
- next actions

### 10.3 Keyword Board
- list view
- cluster view
- score filters
- adopt / reject actions

### 10.4 Content Queue
- 待生成
- 待审核
- 待发布
- 已发布

### 10.5 Analytics
- by keyword
- by content
- by channel
- by conversion step

---

## 11. 权限与审核策略

### MVP 阶段建议
- 内容默认先“生成草稿”
- 发布默认“人工审核后发布”
- 归因数据自动收集

### 后续增强
- 用户可选 autopublish
- 敏感渠道增加 approval gate
- 高风险内容添加 brand safety rules

---

## 12. 指标体系

### 12.1 北极星指标
- attributed signups per week

### 12.2 核心运营指标
- keywords found
- high-intent keyword ratio
- drafts generated
- publish rate
- click-through rate
- signup conversion rate
- attributed signups
- attributed revenue（后续）

### 12.3 系统质量指标
- generation success rate
- publish success rate
- attribution match rate
- time-to-publish
- cost per generated content item

---

## 13. MVP 开发计划

### Phase 1: 验证版（1-2 周）
目标：手动 + AI + 最小系统闭环
- landing page
- waitlist
- project onboarding
- keyword import
- content draft generation
- manual publish support
- simple weekly report

### Phase 2: 半自动版（2-4 周）
目标：内部可持续运营
- keyword discovery worker
- scoring service
- content queue
- scheduled distribution
- UTM attribution
- dashboard v1

### Phase 3: 平台版（4-8 周）
目标：对外正式 SaaS 化
- multi-project support
- self-serve onboarding
- richer analytics
- automation rules
- billing
- role permissions

---

## 14. 开发优先级

### P0
- project setup
- keyword table
- content generation pipeline
- blog publish flow
- UTM tracking
- signup attribution
- dashboard overview

### P1
- X / LinkedIn integration
- keyword scoring improvement
- weekly report automation
- content approval workflow

### P2
- content cluster strategy
- landing page generation
- team collaboration
- billing / plans
- autopublish rules

---

## 15. 风险与应对

### 风险 1：看起来自动，实际全靠人工
应对：
- 明确区分人工步骤和系统步骤
- 先跑通闭环，再提高自动化比例

### 风险 2：内容很多，但没有注册
应对：
- 以 buyer intent 为筛选核心
- 归因优先，不以产量冒充成果

### 风险 3：渠道 API 不稳定
应对：
- 先支持手动审核 + 手动发布 fallback
- 将分发服务设计为可替换 adapter

### 风险 4：内容质量不稳定
应对：
- 引入 brief -> draft -> review 的多阶段流程
- 保留品牌语气配置

---

## 16. 超越 GoShipFast 的方向

1. 不止做 SEO 内容，还做 landing page 和转化页面
2. 不止做发布，还做 attribution 和 ROI 排序
3. 不止做执行，还给出 next best action
4. 后续可引入 agent system 做多角色协作：
   - keyword strategist
   - content writer
   - distribution operator
   - attribution analyst
   - growth planner

---

## 17. MVP 验收标准

MVP 完成的最低标准：
- 能创建项目
- 能导入或生成关键词
- 能生成至少一种长内容和一种短内容
- 能发布到至少 1 个博客渠道和 1 个社媒渠道
- 能记录内容链接
- 能看到哪些内容带来了访问 / 注册
- 能生成一份周报

---

## 18. 推荐实施策略

最现实的落地方式：
1. 先把它做成 **产品化增长服务**
2. 再把重复动作逐步平台化
3. 不要一开始就追求全自动
4. 优先证明：用户愿意为“自动获客闭环”付钱

---

## 19. 交付建议

建议你接下来直接拆成 4 个并行文档：
1. PRD
2. DB Schema
3. API 设计
4. 页面原型 / 文案

如果继续开发，建议下一步先做：
- 数据库 schema
- API 路由设计
- dashboard 页面结构
- landing page 文案

---

## 20. 结论

这不是一个“SEO 工具”项目。
这是一个 **自动增长操作系统** 项目。

真正要做出来的不是关键词、文章、排程这些功能本身，
而是一个能持续把“搜索需求”转成“注册增长”的闭环引擎。
