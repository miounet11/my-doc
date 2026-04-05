# 中国版 AI Edge Gallery 复刻方案

状态：`implemented`
日期：2026-04-06
项目：china-edge-gallery

## 1. 原始目标
用户要的是：**直接开始做一个“中国版 Google AI Edge Gallery”的复刻文档/原型方案，并发到 mydoc。**

本次交付物不是 APK 成品，而是一个可执行的**复刻方案文档**，用于后续产品、技术和开发推进。

## 2. 对标对象是什么
根据 Google AI Edge Gallery 官方仓库与说明：
- 官方仓库：<https://github.com/google-ai-edge/gallery>
- Google Play：<https://play.google.com/store/apps/details?id=com.google.ai.edge.gallery>
- 官方说明提到：没有 Google Play 的用户，可从 **GitHub latest release** 安装 APK：<https://github.com/google-ai-edge/gallery/releases/latest/>

官方项目公开描述的核心能力包括：
- 本地对话（on-device LLM chat）
- Thinking / reasoning 可视化
- 图像问答（Ask Image）
- 语音转写（Audio Scribe）
- Prompt Lab
- Agent Skills
- Mobile Actions
- 模型管理与 benchmark
- 全离线、本地隐私处理

> 证据来源：官方 GitHub README / Wiki（2026-04-06 检索）

## 3. 中国版产品定义

### 产品定位
做一个 **面向中文生态、端侧优先、可离线、可扩展的移动端 AI 模型体验与工具画廊**。

它不是简单抄 UI，而是把 Google AI Edge Gallery 的思想，换成更适合中国场景的实现：
- 中文优先
- 国内模型优先
- 国产 Android 设备适配优先
- 文档 / OCR / 助手工作流优先
- 可私有分发、企业内部分发、镜像下载

### 一句话定义
**一个中国版的本地 AI 应用市场 + 模型实验场 + 端侧助手容器。**

## 4. 核心功能架构（中国版 MVP）

### 4.1 首页 / Gallery
作用：展示可用能力卡片。

建议模块：
- 对话 Chat
- 图像理解 Vision
- OCR 文档理解
- Prompt Lab
- 语音转写
- 模型管理
- Benchmark
- 自动化动作 / 工具技能

### 4.2 本地对话 Chat
能力：
- 多轮中文对话
- system / user prompt 模板
- 本地历史会话
- 上下文长度设置
- Thinking 模式（可选显示）

建议首批模型：
- Qwen2.5 系列轻量版
- MiniCPM 系列
- GLM 开源轻量版
- DeepSeek 蒸馏小模型

### 4.3 图像理解 Vision
能力：
- 相册选图
- 拍照后提问
- 中文场景问答
- 截图解释 / UI 理解
- 商品 / 文档 / 票据 / 白板内容理解

### 4.4 OCR / 文档理解
这部分建议作为中国版增强点。

能力：
- 拍照 OCR
- PDF / 图片抽取文字
- 表格识别
- 文档摘要
- 合同 / 发票 / 报表问答

### 4.5 Prompt Lab
能力：
- 单轮 prompt 测试
- temperature / top-k / top-p 参数控制
- 结果对比
- prompt 模板保存
- 中文任务模板库

### 4.6 模型管理
能力：
- 查看本地模型
- 模型下载 / 导入
- 模型来源标注
- 模型大小、量化类型、上下文长度
- 模型适配设备说明

模型来源建议：
- Hugging Face 镜像
- ModelScope
- 自建下载源
- 局域网导入
- 手动导入 GGUF / ONNX / MNN / LiteRT 兼容包

### 4.7 Benchmark
能力：
- 启动速度
- 首 token 延迟
- tokens/s
- 峰值内存
- 发热情况
- 电量消耗
- 不同模型 / 不同量化对比

注意：
- benchmark 页面必须严格区分：
  - live measured
  - cached historical
  - mock / static
- 绝对不能用假精确数字冒充实测

### 4.8 Agent Skills / 工具扩展
能力：
- 本地 function calling
- skills 插件卡片化
- 工具权限控制
- URL / 文件 / 相机 / 麦克风 / 本地自动化能力接入

中国版可以扩展：
- 微信读图 / 文档导入
- 飞书文档摘要
- 本地文件问答
- 本地知识库检索

## 5. 技术路线

### 5.1 Android 客户端
建议：
- Kotlin + Jetpack Compose
- MVVM / MVI
- Room 保存本地会话与模型元信息
- WorkManager 做后台下载与模型准备

### 5.2 端侧推理引擎（候选）
按模型类型与设备适配层选择：
- LiteRT / MediaPipe（贴近 Google 体系）
- llama.cpp Android bindings
- MNN
- ncnn
- ONNX Runtime Mobile

建议策略：
- MVP 不要一次接太多引擎
- 先做 **1 主 + 1 备**
- 推荐首版：
  - 主：llama.cpp / GGUF 路线（开源模型兼容度高）
  - 备：ONNX Runtime Mobile 或 MNN（适合视觉/OCR链路）

### 5.3 模型策略
先从 **能跑起来 + 中文体验尚可** 的小模型开始：
- 1B ~ 4B 参数量优先
- 优先 int4 / int8 量化
- 首版目标是“稳可用”，不是追最大模型

### 5.4 设备支持建议
首版 Android 目标：
- Android 12+
- 骁龙 8 Gen 2 / 8 Gen 3 优先
- 部分天玑高端机型测试
- 至少 8GB RAM，建议 12GB+

## 6. 中国版差异化设计

相对 Google 原版，中国版更应该强化：

### 6.1 中文优先体验
- 中文 prompt 模板库
- 中文 OCR
- 中文 UI/语义优化
- 中文 benchmark 描述
- 中文帮助中心

### 6.2 工作流导向
不只做 demo gallery，而是做可用工具：
- 文档问答
- 会议录音转写
- 截图理解
- 海报/商品识别
- 本地知识库问答

### 6.3 分发适配
考虑中国环境：
- GitHub release 不一定稳定可达
- Google Play 不一定可用

所以需要：
- 自建下载页
- mydoc 文档页
- 私有分发页
- 内网/企业签发渠道
- 国内镜像源说明

## 7. MVP 页面清单

首版建议页面：
1. 启动页 / 设备检查
2. 首页 Gallery
3. Chat 对话页
4. Ask Image / OCR 页
5. Prompt Lab 页
6. 模型管理页
7. Benchmark 页
8. 设置页
9. 技能 / 工具页

## 8. 数据结构建议

### 模型元信息
- id
- name
- provider
- model_format
- quantization
- size_mb
- context_length
- modality
- local_path
- checksum
- source_url
- install_status

### benchmark 记录
- device_model
- soc
- model_id
- test_case_id
- first_token_ms
- tokens_per_sec
- peak_mem_mb
- temp_delta
- battery_delta
- run_at
- evidence_type (`live` / `cached` / `mock`)

## 9. 风险与难点

### 9.1 真正难点不在 UI，而在端侧推理与机型适配
主要问题：
- Android 不同芯片兼容性
- 模型格式碎片化
- 下载与存储压力
- 发热与内存爆炸
- benchmark 指标定义不一致

### 9.2 中国版最容易踩坑的地方
- 把 demo 做得很花，但模型实际很卡
- benchmark 页面展示假精确数字
- 模型下载链路不稳定
- OCR / 中文文档效果不稳定
- 插件能力过早做重

## 10. 开发建议：三阶段推进

### Phase 1：MVP 骨架（1~2 周）
目标：先形成最小可演示产品
- Compose UI 骨架
- Chat 页面
- 模型列表页
- 本地模型接入 1 条链路
- Prompt Lab
- 基础 benchmark 记录结构

### Phase 2：中文增强（2~4 周）
- OCR
- 中文模板库
- 图像理解
- 模型下载/导入
- 设备兼容层优化

### Phase 3：工具化与生态化
- Skills 插件
- 文档问答
- 本地知识库
- 企业场景能力
- 发布页 / 管理后台 / 私有分发

## 11. 这次我已经完成的内容
本次已完成：
- 检索并确认 Google AI Edge Gallery 官方公开来源
- 提取对标产品的主要功能面
- 形成一份中国版复刻方案文档
- 准备把该文档发布到 mydoc

## 12. 这次还没有完成的内容
本次尚未完成：
- 没有生成真正可安装的中国版 APK
- 没有验证 mydoc 远端发布是否 200 成功
- 没有建立 Android 工程骨架
- 没有做 UI 设计稿或仓库初始化

## 13. 下一步最小可执行动作
如果继续推进，建议下一步直接做其中一个：

### 路线 A：产品/文档先行
- 输出 PRD
- 输出页面流程图
- 输出技术选型表
- 输出中国版命名方案

### 路线 B：工程先行
- 创建 Android 项目骨架
- 搭建首页 / Chat / 模型管理三页
- 接入一个本地模型运行链路

### 路线 C：mydoc 项目页完善
- 增加竞品分析
- 增加模块图
- 增加 roadmap
- 增加下载/分发页设计

## 14. 证据与来源
- Google AI Edge Gallery GitHub：<https://github.com/google-ai-edge/gallery>
- 官方 Wiki：<https://github.com/google-ai-edge/gallery/wiki>
- Google Play：<https://play.google.com/store/apps/details?id=com.google.ai.edge.gallery>
- GitHub latest release（官方 README 提到可用于无 Play 用户）：<https://github.com/google-ai-edge/gallery/releases/latest/>

## 15. 当前诚实完成等级
- 对“开始做中国版复刻文档并准备发到 mydoc”这件事：`implemented`
- 若 mydoc 远端 URL 返回 200：可升级到 `full-chain verified`
- 在远端发布未验证前：**不能说已经成功发到 mydoc**
