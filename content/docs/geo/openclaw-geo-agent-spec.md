# OpenClaw GEO Agent 方案文档（给开发直接开工）

## 1. 文档目的

这份文档定义一个 **OpenClaw 版 GEO（Generative Engine Optimization）审计与监控能力**，目标不是复刻某个 Claude Skill，而是把 GEO/AI Search Optimization 作为 OpenClaw 的一个可复用能力模块落地。

适用对象：
- OpenClaw 核心开发
- 做网站审计 / AI 搜索优化 / SEO 自动化的应用开发者
- 需要把“单次分析”做成“持续巡检 + 报告交付”的团队

---

## 2. 背景判断

参考项目：`zubair-trabzada/geo-seo-claude`

对该项目的判断：
- **强项**：市场切口清晰、命令面清楚、交付导向强、容易包装成服务
- **弱项**：底层技术壁垒有限，更多是工作流编排和营销包装，不是 OpenClaw 应该照搬的基础架构

因此 OpenClaw 的正确方向不是“做一个 Claude Skill 同款”，而是做：

> **一个以 OpenClaw 为控制中枢的 GEO 审计与持续监控代理**

核心差异：
- 它偏一次性运行
- 我们应偏持续运营
- 它偏 Claude Code 安装形态
- 我们应偏 OpenClaw 原生能力（抓取、浏览器、定时、消息推送、报告、记忆）

---

## 3. 产品目标

### 3.1 总目标

给一个站点 URL 或域名，OpenClaw 应能：

1. 生成一次性 GEO 审计报告
2. 识别对 AI 搜索可见性最关键的问题
3. 给出按优先级排序的修复建议
4. 支持周期性复查与差异提醒
5. 通过 Telegram / webhook / markdown / PDF 等形式交付

### 3.2 非目标

当前阶段不追求：
- 直接承诺“提升 ChatGPT 排名”之类无法验证的结果
- 做成重量级 SEO 全家桶
- 深度依赖某个单一 LLM 厂商生态
- 将营销数据或行业话术写进系统真理层

---

## 4. OpenClaw 版 GEO Agent 的定位

建议将其定义为一个 **垂直能力包**，而不是一个孤立脚本。

建议命名可选：
- `geo-audit`
- `ai-discoverability-audit`
- `site-citation-readiness`
- `geo-monitor`

我更推荐：

- 用户面能力名：**GEO Audit**
- 内部模块名：`geo-audit`

---

## 5. 用户价值

### 5.1 典型用户

- 独立开发者：想知道自己网站是否容易被 AI 搜索引用
- SaaS 团队：想提升品牌在 ChatGPT / Perplexity / Gemini / Google AI Overviews 中的可见性
- Agency：需要可交付给客户的站点审计报告
- 内容团队：需要知道页面是否具备“可引用性”
- 运维/增长团队：希望持续监测 robots/schema/站点可抓取性的异常变化

### 5.2 要解决的真实问题

不是“做一份炫酷分析”，而是解决下面这些问题：

1. 站点是否允许主流 AI crawler 正常访问？
2. 页面是否具备被 AI 结果引用的结构与内容特征？
3. 品牌是否在 AI 常引用的外部平台上存在足够信号？
4. 站点结构、schema、元信息是否完整到足够让 AI 理解？
5. 本周与上周相比，哪些关键信号变差了？

---

## 6. 能力边界

### 6.1 MVP 必须覆盖

#### A. 站点抓取与基础发现
- 拉取首页
- 提取 title / meta description / canonical / hreflang（如有）
- 检查 sitemap.xml
- 检查 robots.txt
- 识别主要页面类型（首页 / 文档 / 博客 / 产品页 / 定价页 / FAQ 等）

#### B. AI crawler 可访问性检查
至少检查以下方向：
- robots.txt 是否阻止常见 AI crawler
- 是否对通用抓取器存在明显封禁
- 是否存在非常规阻断（如整站挑战页、强 JS 门槛、空 HTML）

可先支持一组基础 crawler 名单（可配置）：
- GPTBot
- ChatGPT-User
- ClaudeBot
- Claude-SearchBot
- PerplexityBot
- Googlebot
- Google-Extended
- Bytespider（可选）
- CCBot（可选）

#### C. 页面“可引用性 / citability”分析
检查页面内容是否具备这些特征：
- 是否有明确回答型段落
- 是否存在定义型/步骤型/对比型结构
- 关键段落是否相对独立、上下文自洽
- 内容中是否有事实、数字、约束、时间信息
- heading 结构是否清晰
- FAQ / Q&A 模块是否存在

#### D. schema / structured data 检查
- 检测是否存在 JSON-LD
- 识别 schema 类型
- 对以下类型优先做检查：
  - Organization
  - WebSite
  - Article / BlogPosting
  - Product
  - FAQPage
  - LocalBusiness
  - SoftwareApplication
- 标记明显缺失项和不一致项

#### E. 技术基础检查（轻量）
- SSR / HTML 首屏可读性
- 页面基础可抓取性
- 响应状态码
- canonical 基本合理性
- index/noindex 基本状态
- 站内重要链接可发现性

#### F. 输出报告
最少支持：
- markdown 报告
- Telegram 摘要

---

### 6.2 V2 建议覆盖

#### G. 品牌外部信号扫描
扫描是否在以下来源存在品牌信号：
- GitHub
- Reddit
- YouTube
- LinkedIn
- 官方文档站 / 社区站
- 行业目录 / review 站
- X.com（若可用）

说明：
- 这一层要明确标注为“外部信号/推断”，不能伪装成精确排名结果
- 只做 presence / evidence gathering，不做虚假归因

#### H. 竞争对手对比
输入主站 + 竞品站，输出：
- schema 完整度对比
- FAQ / answer block 对比
- docs / blog / product 页面深度对比
- 品牌外部提及对比

#### I. 周期巡检与告警
通过 cron 支持：
- 每日/每周巡检
- 变化 diff
- 发现高风险异常时主动通知

#### J. PDF/客户报告
- 适合外部交付
- 包含评分、摘要、优先级与行动计划

---

## 7. 核心设计原则

### 7.1 OpenClaw 负责 WHAT，不把所有 HOW 塞进一个提示词
控制层职责：
- 理解用户意图
- 选择审计范围
- 调度子分析任务
- 聚合证据
- 输出给正确交付面
- 持续监控和提醒

执行层职责：
- 页面抓取
- robots/schema/content 解析
- 外部来源扫描
- 报告渲染

### 7.2 证据分层
输出时必须区分：
- `verified-now`：刚刚抓到的页面/robots/schema 等真实内容
- `inferred`：根据页面结构做出的合理推断
- `external-signal`：来自外部平台的品牌存在证据
- `unknown`：当前无法确认

不要把“看起来可能会被 AI 喜欢”说成“已经被 AI 引用”。

### 7.3 单次审计只是入口，持续监控才是长期价值
所有设计要默认兼容定时执行，而不是一次性命令后结束。

### 7.4 报告优先服务行动，不优先服务炫技
报告必须回答：
- 现在问题是什么
- 为什么重要
- 先修什么
- 修完如何复查

---

## 8. 推荐系统结构

## 8.1 模块图

```text
User / Trigger
   |
   v
OpenClaw Controller
   |- scope resolver
   |- task planner
   |- evidence aggregator
   |- delivery router
   |
   +--> Fetcher Layer
   |      |- homepage fetch
   |      |- sitemap/robots fetch
   |      |- page sampler
   |
   +--> Analyzer Layer
   |      |- crawler analyzer
   |      |- citability analyzer
   |      |- schema analyzer
   |      |- technical analyzer
   |      |- brand signal analyzer (v2)
   |
   +--> Report Layer
   |      |- markdown report
   |      |- telegram summary
   |      |- pdf renderer (v2)
   |
   +--> Monitor Layer
          |- cron schedules
          |- diff engine
          |- alerting
```

---

## 9. 推荐命令面 / 调用面

如果作为 OpenClaw 内部能力，建议支持以下意图：

### 9.1 单次审计
- `audit <url> for GEO`
- `analyze AI search visibility for <url>`
- `检查这个网站的 GEO` 

### 9.2 快速检查
- `quick geo check <url>`
- `看看这个站 AI 搜索友好吗`

### 9.3 专项检查
- `check AI crawler access for <url>`
- `check schema quality for <url>`
- `check citation readiness for <url>`

### 9.4 持续监控
- `monitor this site weekly for GEO changes`
- `每周检查这个站的 AI 搜索可见性并发我摘要`

---

## 10. 输出格式设计

## 10.1 Markdown 报告结构（建议标准）

```markdown
# GEO Audit Report — {domain}

## Executive Summary
- Overall assessment
- Top 3 risks
- Top 3 quick wins

## Evidence Snapshot
- Crawlability
- AI crawler access
- Structured data presence
- Answerability / citability
- External brand signals

## Findings by Category
### 1. AI Crawler Access
### 2. Content Citability
### 3. Structured Data
### 4. Technical Discoverability
### 5. Brand Signals (if enabled)

## Priority Actions
### P0
### P1
### P2

## Suggested Next 30 Days

## Appendix
- checked URLs
- detected schema types
- robots.txt notes
- sitemap notes
```

## 10.2 Telegram 摘要结构

建议压缩成：
- 总评一句
- 3 个最高优先级问题
- 3 个 quick wins
- 报告地址

示例：

```text
GEO 审计完成：example.com

总评：基础可抓取性尚可，但 AI 可引用性和 schema 完整度偏弱。

高优先级：
1. robots 对部分 crawler 策略不清晰
2. FAQ/回答型段落不足
3. 缺少 Organization + WebSite + FAQ 结构化数据

Quick wins：
1. 补 FAQ 区块
2. 增加 JSON-LD
3. 调整 3 个核心页面为“问题-答案”结构

完整报告：{url}
```

---

## 11. 推荐评分框架（仅作内部启发，不宜包装成绝对真理）

建议采用 100 分制，但必须在文档中注明：

> 该分数是内部启发式审计分，不等价于任何真实搜索引擎排名分。

推荐权重：
- AI crawler access：20
- 内容 citability：25
- schema/structured data：20
- 技术可发现性：15
- 信息架构 / 页面可理解性：10
- 外部品牌信号：10

评分输出要附带证据项，而不是只给数字。

---

## 12. 实现建议（按 OpenClaw 能力拆分）

### 12.1 抓取层
首选：
- `web_fetch` 抓取可读内容
- 必要时 `browser` 做 JS 页面补充抓取

建议封装：
- homepage fetcher
- robots fetcher
- sitemap fetcher
- page sampler

### 12.2 分析层
建议尽量做成独立小模块：
- `crawler_access.py`
- `citability.py`
- `schema_check.py`
- `technical_discoverability.py`
- `brand_signal_scan.py`（v2）

### 12.3 编排层
由 OpenClaw 控制：
- 决定跑哪些子模块
- 是否并行
- 如何聚合结果
- 如何给出最终优先级

### 12.4 报告层
建议输出到：
- workspace 下固定目录
- markdown 为主
- 后续可转 html / pdf

建议目录：

```text
workspace/reports/geo/
  {domain}/
    latest.md
    runs/
      2026-03-21T08-00-00.md
      2026-03-28T08-00-00.md
    latest.json
    diff/
```

---

## 13. 和参考项目相比，OpenClaw 应该强化的地方

### 13.1 从“技能安装包”升级成“持续服务”
不是只让用户运行一次命令，而是：
- 可定时
- 可追踪变化
- 可持续通知

### 13.2 从“Claude 专属”升级成“OpenClaw 原生控制平面能力”
让它天然支持：
- Telegram 触发
- cron 调度
- browser 辅助抓取
- webhook/消息交付
- 多 agent / 多模块编排

### 13.3 从“营销叙事”回到“证据驱动”
所有高层结论都必须回扣到：
- 页面真实结构
- robots/schema 原文证据
- 外部来源链接

### 13.4 从“单次报告”升级成“运营闭环”
完整流程应该是：
- 审计
- 建议
- 修复
- 复查
- diff
- 周期摘要

---

## 14. 推荐 MVP 范围（真正值得先做的版本）

### MVP 功能清单
1. 输入站点 URL
2. 抓首页、robots.txt、sitemap.xml
3. 识别 3~10 个关键页面
4. 输出以下检查：
   - AI crawler access
   - 基础 citability
   - schema 检测
   - 技术可发现性基础项
5. 生成 markdown 报告
6. 输出 Telegram 摘要

### MVP 明确不做
- 全网品牌扫描
- 大规模竞品对比
- PDF 美化
- 非常复杂的性能检测
- 伪精确“AI 排名预测”

---

## 15. 推荐开发顺序

### Phase 1 — 可用版
- 抓取器
- robots/schema/citability/technical 四个检查器
- markdown 报告模板
- 手动触发

### Phase 2 — 好用版
- 多页面采样
- 更稳定的页面分类
- Telegram 摘要
- 结果持久化
- 历史运行记录

### Phase 3 — 有运营价值版
- cron 周期巡检
- diff 检测
- 告警规则
- 外部品牌信号扫描

### Phase 4 — 可对外交付版
- PDF
- 竞品对比
- 客户版摘要
- 可分享报告页面

---

## 16. 对开发的明确要求

1. 不要把行业营销话术硬编码成事实
2. 不要输出“已被 ChatGPT 推荐/收录”这类无法直接验证的断言
3. 所有关键结论都要可追溯到证据
4. 报告必须带优先级，不要只做信息堆砌
5. 先做稳定的 MVP，不要一开始追求大而全
6. 输出必须区分“当前已验证”和“合理推断”

---

## 17. 一句话结论

这件事值得做，但正确姿势不是复制 `geo-seo-claude`，而是把它验证过的市场包装，重构成一个 **OpenClaw 原生的 GEO 审计 + 持续监控能力**。

如果做对，它不只是一个分析工具，而是一个可以长期交付价值的 AI 搜索可见性运营代理。
