# ai-skills — Claude Code 工作指南

这个仓库是所有 skill 的唯一源码仓库，同时兼容 **Claude Code** 和 **OpenAI Codex CLI**。

## 仓库结构

```
ai-skills/
├── <skill-name>/           # skill 源码目录
│   ├── SKILL.md            # 必须，两平台共用
│   ├── agents/
│   │   └── openai.yaml     # Codex UI 配置（推荐）
│   ├── references/         # 按需加载的参考文档
│   ├── scripts/            # 可执行脚本
│   └── assets/             # 模板、静态文件
├── <skill-name>.skill      # 打包产物，放根目录
└── scripts/                # 仓库管理脚本
```

## 创建新 Skill

官方入口：

```bash
npm run new <name>
```

`/base-guidelines` 是默认的全局编码基准；处理写代码、review、重构类任务时，优先遵循它。`/skill-builder` 仍用于指导 agent 按仓库规范补全跨平台 skill；它不再作为底层脚手架入口。

```bash
# 1. 初始化
npm run new <name>

# 2. 编写 SKILL.md、README.md（见下方规范）

# 3. 按需补充 references/、scripts/、assets/

# 4. 验证
npm run validate <name>

# 5. 打包（输出到仓库根目录）
npm run pack <name>

# 6. 安装到本地工具链
npm run install <name>
```

## SKILL.md 规范

```yaml
---
name: skill-name           # 小写字母 + 连字符
description: 一句话说明做什么、何时触发（中英文均可，影响隐式触发匹配）
---
```

- 500 行以内，细节放 `references/`
- 写给另一个 AI agent 看，不是给人看
- 用祈使句，不说废话

## agents/openai.yaml 规范

使用模板自带的 `agents/openai.yaml`，至少填写：
- `display_name`、`short_description`
- `policy.allow_implicit_invocation`（默认 true）

## 命名规范

- 目录名：`小写字母-连字符`，如 `h5-compat-audit`
- `.skill` 包名与目录名一致

## 已有 Skill

| Skill | 用途 |
|-------|------|
| `base-guidelines` | 中文全局编码基准，约束最小变更、显式假设和验证闭环。 |
| `cardio-training` | 有氧与心肺训练处方：心率区间估算、Zone 2 打底、周训练量渐进、与力量训练的搭配和恢复信号。 |
| `daily-habits` | 设计并复盘睡眠作息、久坐打断、进食节律、烟酒减断与体检节奏等日常生活习惯。 |
| `dca-strategy` | 长期复利定投系统，结合家庭资产负债和现金流，按月输出美股成长、A 股宽基、黄金和现金缓冲的核心+卫星组合规则。 |
| `gen-i18n` | 从 Excel 翻译表生成多语言 JSON 文件，适用于整理、修复和自动化 i18n 资源生成流程。 |
| `git-commit-message` | 基于当前暂存 diff 生成 Git CZ（Conventional Commits）规范提交内容。 |
| `h5-compat-audit` | 审查 H5 页面和前端代码在安卓 6+、旧 iPhone、微信内浏览器和现代桌面浏览器中的兼容性风险。 |
| `learning-mentor` | 个性化学习导师，用于制定学习计划、快速入门陌生领域和规划学习路径。 |
| `million-dollar-weekend-research` | 基于快速市场验证理念调研项目或创业点子，输出可执行的 Go/调整/停止决策与访谈、外联、预售数据表。 |
| `multi-mental-models` | 多元思维模型分析助手，用多学科、多维度模型分析问题并给出结构化建议、风险提醒和行动方案。 |
| `project-security-scan` | 对 Node.js/TypeScript 仓库执行只读的项目安全审计，覆盖生产依赖、业务代码与交付配置风险，并输出含证据与修复建议的报告。 |
| `reading-assistant` | 分析书籍核心价值、局限与观点，并输出结构化读书报告和精读或分形阅读建议。 |
| `skill-builder` | 补全同时兼容 Claude Code 和 Codex CLI 的跨平台 skill，整理 `SKILL.md`、`README.md` 和 Codex UI 配置。 |
