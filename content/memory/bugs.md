# Bugs - 已知问题和解决方案

> 自动分类：代码 bug、系统 bug、配置问题
> 置信度：每次避免 +1，每月衰减 -0.1
> TTL: 90 天未触发自动归档

---

## [P0] 网络服务启动三大陷阱
<!-- confidence: 1.0, last_hit: 2026-03-07 -->
<!-- 来源: MEMORY.md [P0] 血泪教训 -->

### 问题 1：端口占用未检查
**症状**：服务启动失败，报错 "Address already in use"
**根因**：未检查端口是否被占用
**解决**：
```bash
lsof -i :端口  # 启动前必查
```

### 问题 2：IP 地址假设错误
**症状**：局域网无法访问服务
**根因**：假设本机 IP，未实际查询
**解决**：
```bash
ifconfig | grep 'inet '  # 获取真实 IP
```

### 问题 3：绑定地址错误
**症状**：只能 localhost 访问，局域网无法访问
**根因**：绑定到 127.0.0.1 而非 0.0.0.0
**解决**：
```bash
--bind 0.0.0.0  # 绑定所有网卡
```

### 强制验证流程
```bash
lsof -i :端口        # 1. 检查占用
ifconfig | grep inet # 2. 获取 IP
lsof -i :新端口      # 3. 验证启动
curl -I http://...   # 4. 测试访问
```

---

## [P1] JSON 解析空值问题
<!-- confidence: 0.8, last_hit: 2026-03-06 -->

**症状**：`jq` 解析失败，返回 null
**根因**：JSON 字段不存在或格式错误
**解决**：
```bash
# 错误
value=$(jq '.field' file.json)

# 正确
value=$(jq -r '.field // "default"' file.json)
```

---

## [P2] Git 提交信息格式错误
<!-- confidence: 0.7, last_hit: 2026-03-05 -->

**症状**：CI 检查失败，提交信息不符合规范
**根因**：未遵循 Conventional Commits
**解决**：
```
格式：<type>(<scope>): <subject>

type: feat, fix, docs, style, refactor, test, chore
scope: 可选，影响范围
subject: 简短描述，不超过 50 字符
```

---

_自动维护：每月清理已修复且未再触发的 bug_
