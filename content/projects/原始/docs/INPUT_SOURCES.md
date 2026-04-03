# Input Sources - 原始

## 必须采集的对话来源

### 1. OpenClaw
- `~/.openclaw/logs/`
- `~/.openclaw/logs/autonomous/`
- `~/.openclaw/logs/ignite/`
- `~/.openclaw/cron/runs/*.jsonl`
- `~/.openclaw/workspace/memory/*.md`
- `~/.openclaw/learning/experiences.json`

用途：采集 OpenClaw 主循环、自主任务、agent 产出、反思和经验。

### 2. Claude Code
- `~/.claude/projects/**/*.jsonl`
- `~/.claude/todos/*.json`
- `~/.claude/config.json`

用途：采集 Claude Code 会话消息、工具调用轨迹、任务待办与项目上下文。

### 3. VS Code / Cursor
- `~/Library/Application Support/Code/User/workspaceStorage/*/chatSessions/*.jsonl`
- `~/Library/Application Support/Code/User/workspaceStorage/*/chatEditingSessions/*/state.json`
- `~/Library/Application Support/Cursor/User/workspaceStorage/*/chatSessions/*.jsonl`
- `~/Library/Application Support/Cursor/User/workspaceStorage/*/chatEditingSessions/*/state.json`

用途：采集 IDE 内聊天、编辑会话、模型选择、补全上下文。

### 4. Codex / OpenAI 本地历史
- `~/.codex/history.jsonl`
- `~/.codex/log/codex-tui.log`

用途：补充当前终端对话历史和操作轨迹。

## 当前已确认格式
- Claude Code：JSONL，含 `type=user/assistant`、`message.content`、`tool_use`、`timestamp`
- VS Code chatSessions：JSONL，含 session 元数据、模型信息、请求与响应状态
- VS Code chatEditingSessions：JSON 状态文件，偏编辑轨迹，不一定含完整消息
- Codex history：JSONL，至少含 `session_id`、`ts`、`text`

## 采集原则
1. 原始文件只读，不原地修改。
2. 先做 source adapter，再统一转成 Event schema。
3. 每个来源保留 `source_path` 和 `source_type`。
4. 注释和复盘层不得覆盖原始内容。


### 5. Other Development Tools
- Cursor logs and chat state
- Gemini local conversation trackers
- Future tools: Windsurf, Continue, Aider, Roo, Qodo, browser-based coding copilots

用途：只要本地存在稳定文件轨迹，就可以通过新增 adapter 纳入 `原始`。


- Windsurf local state and future chat/history exports

### Windsurf Note
当前已发现 Windsurf 扩展与本地资源目录，但尚未定位到明确的会话历史文件。后续一旦确认格式，直接新增 Windsurf adapter。
## Adapter Rule
新增开发工具时，先做三件事：
1. 找到本地落盘路径
2. 抽样确认文件格式
3. 写 `SourceAdapter`，统一转成 Event schema
