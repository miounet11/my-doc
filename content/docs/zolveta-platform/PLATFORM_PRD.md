# Zolveta 平台开发方案（PRD + 技术设计草案）

> 目标：构建一个可持续运营的数字内容发布平台，支持漫画、小说、短视频、短剧的统一上传、编排、试看、订阅付费与正式发布。

## 1. 项目定位

Zolveta 是一个面向数字内容消费的平台，核心目标不是“做一个网站”，而是建立一套完整可靠的内容接收、生产、审核、发布、试看、订阅付费、访问控制与运营分析系统。

平台支持的内容类型：
- 漫画
- 小说
- 短视频
- 短剧

平台核心商业模式：
- 免费试看 / 试听 / 试读
- 会员订阅制
  - 月会员
  - 年会员
- 后续可扩展：单集解锁 / 单本购买 / 创作者分账 / 联名栏目 / 多语言发行

---

## 2. 产品目标

### 2.1 用户侧目标
用户可以：
- 浏览首页推荐内容
- 按内容类型分类浏览
- 查看作品详情页
- 免费试看部分内容
- 登录 / 注册
- 购买月会员或年会员
- 解锁会员专属完整内容
- 继续观看 / 阅读历史记录
- 收藏、追更、查看更新提醒

### 2.2 运营侧目标
运营人员可以：
- 创建作品
- 配置作品元数据
- 上传封面 / 漫画图片 / 小说章节 / 视频文件
- 配置免费试看范围
- 配置会员可见范围
- 配置上架时间 / 下架时间 / 地区策略 / 标签 / 专题位
- 审核和发布内容
- 查看数据面板（试看转付费、留存、播放完成率、阅读完成率、热门作品）

### 2.3 技术侧目标
系统需要具备：
- 高可靠性
- 可扩展的内容模型
- 清晰的接收和发布流程
- 权限控制与支付状态控制
- 可审计的发布记录
- 面向未来的多语言、多站点、多付费模型扩展能力

---

## 3. MVP 范围

第一阶段建议只做以下闭环：

### 用户端 MVP
- 首页
- 分类页
- 作品详情页
- 内容播放 / 阅读页
- 注册 / 登录
- 月会员 / 年会员订阅
- 免费试看逻辑
- 会员解锁逻辑
- 收藏 / 历史记录

### 管理端 MVP
- 管理员登录
- 内容录入后台
- 作品管理
- 章节 / 集数管理
- 视频 / 图片 / 文本上传
- 免费范围配置
- 发布状态管理
- 首页推荐位管理

### 支付 MVP
- Stripe / 国内支付二选一先落地一个
- 支持：
  - 月会员
  - 年会员
- 订阅状态同步
- 支付成功后权限即时生效

### 技术 MVP
- Web 前台
- Admin 后台
- API 服务
- 对象存储
- 数据库
- 鉴权
- 订阅权限中间层

---

## 4. 用户角色设计

### 4.1 游客
- 可浏览公开内容
- 可试看免费内容
- 不可访问完整付费内容

### 4.2 注册用户
- 可收藏、记录历史
- 可继续试看免费内容
- 未订阅时不能访问完整会员内容

### 4.3 会员用户
- 可访问会员内容
- 可享受月会员 / 年会员权益

### 4.4 内容运营
- 录入作品
- 上传素材
- 设置试看与发布规则
- 编辑专题与推荐位

### 4.5 审核 / 发布管理员
- 审核内容完整性
- 发布 / 下架
- 回滚版本

### 4.6 超级管理员
- 账号与权限管理
- 支付配置
- 站点配置
- 内容策略配置

---

## 5. 内容模型设计

建议采用“统一作品模型 + 内容子类型扩展”的方式。

### 5.1 核心实体

#### Work（作品）
统一作品主表：
- id
- slug
- title
- subtitle
- description
- cover_image
- poster_image
- type（comic / novel / short_video / short_drama）
- status（draft / review / scheduled / published / archived）
- language
- country
- age_rating
- tags
- categories
- is_featured
- publish_at
- unpublish_at
- created_by
- updated_by
- created_at
- updated_at

#### Season（季，可选）
适用于短剧 / 长篇栏目：
- id
- work_id
- season_number
- title
- status

#### Episode / Chapter（章节 / 集数）
- id
- work_id
- season_id（nullable）
- sequence_number
- title
- summary
- content_type（image_series / rich_text / video）
- status
- free_preview_mode
- preview_limit_value
- publish_at
- duration_seconds（视频）
- word_count（小说）
- image_count（漫画）

#### Asset（素材）
- id
- owner_type
- owner_id
- asset_type（cover / comic_page / video / subtitle / trailer / thumbnail）
- file_url
- storage_key
- mime_type
- width
- height
- duration
- checksum
- transcoding_status

#### SubscriptionPlan（订阅计划）
- id
- code
- name
- billing_cycle（月 / 年）
- price
- currency
- status
- platform_channel

#### UserSubscription（用户订阅）
- id
- user_id
- plan_id
- provider
- provider_subscription_id
- status
- start_at
- end_at
- auto_renew

---

## 6. 试看与付费规则设计

### 6.1 通用规则
每个作品 / 每集内容都应支持独立配置试看策略。

### 6.2 支持的试看模式

#### 小说
- 前 N 章免费
- 每章前 X% 免费

#### 漫画
- 前 N 话免费
- 每话前 X 页免费

#### 短视频 / 短剧
- 前 N 集免费
- 每集前 X 秒免费
- 预告片独立免费

### 6.3 推荐规则结构
每个 Episode / Chapter 存储：
- access_level: free / subscriber / paid_single / hidden
- preview_mode: none / by_percent / by_pages / by_seconds / by_episode_index
- preview_value

### 6.4 权限判定逻辑
请求内容时：
1. 判断内容是否公开
2. 判断用户是否登录
3. 判断用户是否有有效会员
4. 判断当前内容是否属于免费试看范围
5. 返回可访问内容片段或完整内容

---

## 7. 内容接收规则（运营后台）

平台成败很大程度取决于内容发布效率，所以接收规则必须标准化。

### 7.1 接收流程总览
1. 创建作品
2. 填写元数据
3. 上传素材
4. 系统校验素材完整性
5. 配置试看与订阅规则
6. 提交审核
7. 审核通过
8. 定时发布 / 立即发布

### 7.2 各内容类型接收标准

#### 漫画接收标准
- 每话为一个独立章节
- 图片格式：WebP / JPEG / PNG
- 页面顺序必须有序编号
- 建议尺寸标准化（例如宽度统一）
- 封面图单独上传
- 可配置前几页试看

#### 小说接收标准
- 每章为独立章节
- 支持富文本 / Markdown 导入
- 标题、摘要、正文结构分离
- 可配置前几章免费或按比例试看

#### 短视频 / 短剧接收标准
- 原视频上传后进入转码流程
- 自动生成多码率版本
- 自动生成封面 / 缩略图 / 时长信息
- 支持字幕文件上传
- 可配置前多少秒试看
- 支持预告片单独上传

### 7.3 系统自动校验项
- 必填字段是否完整
- 封面是否上传
- 章节是否为空
- 视频是否转码成功
- 试看规则是否已配置
- 发布时间是否合法
- slug 是否唯一

### 7.4 状态流转
- Draft（草稿）
- ReadyForReview（待审核）
- Rejected（退回修改）
- Approved（审核通过）
- Scheduled（已排期）
- Published（已发布）
- Archived（已归档）

---

## 8. 发布规则设计

### 8.1 发布原则
发布不是简单“点上线”，而是一次受控操作，必须可追踪、可回滚、可审计。

### 8.2 发布动作应包含
- 作品发布
- 单章节发布
- 定时发布
- 批量发布
- 首页推荐位更新
- 下架
- 回滚到上一个稳定版本

### 8.3 发布记录
每次发布都记录：
- 谁发布的
- 发布时间
- 发布了哪些内容
- 修改了哪些试看规则
- 发布前后的版本差异
- 是否触发首页推荐更新

### 8.4 推荐与排序规则
首页支持：
- 最新发布
- 热门内容
- 编辑推荐
- 分类推荐
- 会员专享
- 即将更新

---

## 9. 推荐技术架构

## 9.1 总体建议
推荐采用：
- **前端**：Next.js
- **后台管理**：Next.js Admin 或独立 React Admin
- **后端 API**：NestJS
- **数据库**：PostgreSQL
- **缓存**：Redis
- **对象存储**：Cloudflare R2 / S3
- **视频处理**：FFmpeg + 队列任务
- **鉴权**：JWT + Refresh Token + RBAC
- **支付**：Stripe（海外）/ 国内通道后续接入
- **部署**：Docker + VPS / Kubernetes（后续）

### 9.2 为什么这样选
- Next.js 适合 SEO、内容展示、订阅页、登录页
- NestJS 更适合做复杂内容平台的领域模型、权限和后台 API
- PostgreSQL 适合复杂内容关系、检索、审计
- Redis 适合缓存首页、会话、限流和权限判定
- R2 / S3 适合存储封面、漫画图、视频源文件、转码产物

---

## 10. 模块拆分

### 10.1 前台站点模块
- 首页
- 分类浏览
- 搜索
- 作品详情页
- 阅读器（漫画 / 小说）
- 播放器（视频 / 短剧）
- 登录注册
- 订阅支付
- 个人中心
- 收藏历史

### 10.2 管理后台模块
- 仪表盘
- 作品管理
- 章节管理
- 媒资管理
- 发布中心
- 推荐位管理
- 订阅计划管理
- 用户与权限管理
- 数据分析中心

### 10.3 后端服务模块
- Auth Service
- User Service
- Catalog Service
- Content Ingestion Service
- Publishing Service
- Subscription / Billing Service
- Asset / Media Service
- Analytics Service
- Search Service
- Notification Service

---

## 11. 数据表建议（MVP）

核心表：
- users
- roles
- user_roles
- works
- seasons
- episodes
- assets
- tags
- work_tags
- categories
- work_categories
- subscription_plans
- user_subscriptions
- payment_orders
- publish_logs
- favorites
- watch_history
- reading_history
- banners
- audit_logs

---

## 12. API 设计建议

### 前台 API
- GET /api/works
- GET /api/works/:slug
- GET /api/works/:slug/episodes
- GET /api/episodes/:id/access
- GET /api/episodes/:id/content
- POST /api/auth/register
- POST /api/auth/login
- GET /api/me/subscription
- POST /api/billing/checkout
- POST /api/billing/webhook

### 后台 API
- POST /admin/works
- PUT /admin/works/:id
- POST /admin/works/:id/episodes
- POST /admin/assets/upload
- POST /admin/publish/submit-review
- POST /admin/publish/approve
- POST /admin/publish/release
- POST /admin/publish/unpublish
- GET /admin/analytics/overview

---

## 13. 阅读器 / 播放器要求

### 漫画阅读器
- 懒加载图片
- 自动续读
- 试看页遮罩
- 章节跳转

### 小说阅读器
- 字号调整
- 背景模式
- 自动记录阅读位置
- 试看截断提示

### 视频播放器
- 试看倒计时提示
- 到点锁定并引导订阅
- HLS 播放
- 自动续播
- 字幕支持

---

## 14. 支付与订阅建议

### MVP 支付策略
第一阶段建议先接一个稳定支付：
- 海外优先：Stripe Subscription
- 如果主要做国内，再补：微信 / 支付宝

### 订阅状态设计
- active
- trialing
- past_due
- canceled
- expired

### 关键规则
- 权限由服务端判定，不可信任前端
- 支付成功必须通过 webhook 最终确认
- 订阅到期后自动降权
- 记录所有账单变动

---

## 15. 后台发布工作流（建议重点做强）

运营后台建议重点强化以下能力：

### 15.1 批量导入
- 漫画 zip 批量拆页上传
- 小说 markdown 批量导入章节
- 视频批量上传 + 自动转码排队

### 15.2 内容模板
- 创建作品模板
- 重复栏目复用默认配置
- 默认试看规则快速套用

### 15.3 发布校验器
在点击发布前，系统应给出：
- 缺少封面
- 缺少分类
- 缺少试看设置
- 视频转码未完成
- 章节排序不连续
- 定价 / 权限未配置

### 15.4 定时发布
- 指定时间自动上架
- 与首页推荐位联动
- 上架后自动触发缓存刷新

---

## 16. 非功能需求

### 性能
- 首页首屏快
- 图片与视频走 CDN
- 作品详情缓存
- 热门章节缓存

### 可靠性
- 上传失败可重试
- 发布动作幂等
- webhook 幂等处理
- 审计日志完整

### 安全
- 后台 RBAC
- 资源访问签名
- 防盗链
- 限流
- 支付 webhook 验签

### 可维护性
- 内容模型统一
- 媒资与内容解耦
- 发布系统与展示系统解耦

---

## 17. 推荐开发阶段

### Phase 1：产品方案与原型
产出：
- PRD
- 信息架构
- 页面流程图
- 数据模型草案
- 权限矩阵

### Phase 2：技术基础设施
产出：
- monorepo 初始化
- 用户系统
- 后端骨架
- 数据库 schema
- 对象存储接入
- Admin 骨架

### Phase 3：内容发布闭环
产出：
- 作品创建
- 章节录入
- 媒资上传
- 发布审核
- 前台展示
- 免费试看

### Phase 4：订阅支付闭环
产出：
- 月 / 年订阅
- 权限联动
- 会员内容解锁
- Webhook 同步

### Phase 5：运营增强
产出：
- 数据面板
- 推荐位
- 搜索
- 收藏 / 历史
- SEO 优化

---

## 18. 建议给 Codex 的开发要求

你可以让 Codex 按下面目标输出：

### 第一批交付物
1. 完整技术架构设计
2. 数据库 ER 图
3. API 设计文档
4. 后台信息架构
5. 内容发布流程图
6. MVP 页面列表
7. Monorepo 脚手架建议
8. 首期迭代开发排期（按周）

### 第二批交付物
1. 项目初始化代码结构
2. 前后端基础骨架
3. 数据库 schema
4. Auth + Subscription 基础模块
5. Work / Episode / Asset 基础模块

---

## 19. 推荐 Monorepo 结构

```txt
zolveta/
  apps/
    web/                # 用户前台
    admin/              # 管理后台
    api/                # NestJS API
    worker/             # 转码/异步任务
  packages/
    ui/
    config/
    database/
    auth/
    content-domain/
    billing/
    media/
    analytics/
  docs/
    prd/
    architecture/
    api/
    workflows/
```

---

## 20. 最终建议

这个项目最重要的不是先把前台页面做漂亮，而是先把以下 4 个底层能力设计好：

1. **统一内容模型**
2. **可靠的接收与发布流程**
3. **清晰的试看 / 订阅权限系统**
4. **可运营的后台系统**

如果这 4 个设计得好，前台只是表现层；如果这 4 个没做好，网站再漂亮也只是空壳。

---

## 21. 我建议的下一步

立刻进入以下顺序：
1. 输出系统架构文档
2. 输出数据库设计文档
3. 输出 API 文档
4. 输出后台发布工作流文档
5. 让 Codex 开始搭建 monorepo 骨架

