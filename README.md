# ai-skills

一个用于集中维护可复用 AI skills 的仓库，适用于 Codex、Claude Code 以及其他基于本地 skill 目录的 agent 工作流。

This repository is a personal collection of reusable AI skills for Codex, Claude Code, and other agent workflows that support local skill directories.

## Goals / 目标

- 统一维护 skills 源码，而不是在多个工具目录里重复编辑
- 用 GitHub 托管自研 skills，便于版本管理和分享
- 用公共 skill 池连接不同工具，而不是复制同一份内容
- Keep one source of truth for skills and connect multiple tools through links

## Repository layout / 仓库结构

```text
ai-skills/
├── README.md
├── CONTRIBUTING.md
├── LICENSE
├── .gitignore
├── .github/
│   ├── ISSUE_TEMPLATE/
│   └── pull_request_template.md
├── scripts/
├── templates/
├── h5-compat-audit/
└── <another-skill>/
```

约定说明 / Notes:

- 每个子目录代表一个独立 skill
- `SKILL.md` 是 skill 主体
- `references/` 用于存放按需加载的参考资料
- `scripts/`、`assets/` 按需添加
- `agents/openai.yaml` 主要服务 Codex / OpenAI 侧，不是所有工具都需要

## Skill layout / 单个 skill 结构

```text
<skill-name>/
├── README.md
├── SKILL.md
├── agents/
│   └── openai.yaml
├── references/
├── scripts/
└── assets/
```

## Local installation flow / 本地安装链路

推荐链路：

```text
<skills-repo>/<skill>
  -> ~/.agents/skills/<skill>
    -> ~/.codex/skills/<skill>
    -> ~/.claude/skills/<skill>
```

This keeps one source copy while allowing multiple tools to consume the same skill.

说明：

- `<skills-repo>` 表示你自己的 skill 源码仓库路径
- `~/.agents/skills` 可以作为本机公共 skill 池
- Codex、Claude Code 等工具再从公共池接入
- 如果你不使用公共池，也可以直接把 skill 链接到工具目录

## Current skills / 当前 skills

| Skill | 用途 |
|-------|------|
| `learning-mentor` | 个性化学习方案，学习策略专家角色 |
| `skill-builder` | 补全兼容 Claude Code + Codex 的跨平台 skill |
| `h5-compat-audit` | H5 页面兼容性审查（Android 6+、旧 iPhone、微信内浏览器） |

## Scripts / 常用命令

| 命令 | 作用 |
|------|------|
| `npm run new <name>` | 创建新 skill 目录（含模板文件） |
| `npm run install <name>` | 安装 skill 到本地工具链（`~/.agents/skills`、`~/.codex/skills`、`~/.claude/skills`） |
| `npm run uninstall <name>` | 卸载 skill（只移除软链接，不删源码） |
| `npm run list` | 查看所有 skill 的安装状态 |
| `npm run pack <name>` | 将 skill 打包为 `.skill` 文件（输出到仓库根目录） |
| `npm run validate <name>` | 验证 skill 目录结构是否合规 |

## Adding a new skill / 新增 skill

官方入口是 `npm run new <skill-name>`。

1. `npm run new <skill-name>`
2. 编写 `SKILL.md`、`README.md`，按需补充 `references/`、`scripts/`、`assets/`
3. 检查 `agents/openai.yaml` 中的 `display_name`、`short_description`、`policy.allow_implicit_invocation`
4. `npm run validate <skill-name>` 检查结构
5. `npm run pack <skill-name>` 打包
6. `npm run install <skill-name>` 安装到本地
7. 用真实任务验证，然后提交

更详细的规范见 `CONTRIBUTING.md`。

## Publishing / 发布

```bash
git add .
git commit -m "feat: add or update AI skills"
git remote add origin <your-github-repo>
git push -u origin main
```

## Notes / 备注

- There is usually no single system-wide skill directory shared automatically by every tool
- This repository acts as the source-of-truth for your skills
- Tool-specific installation still happens through symlinks or each tool's own discovery mechanism
- 如果你要公开发布单个 skill，也可以把某个 skill 目录单独提取成独立仓库

## Contributing / 贡献

If you want to add or modify a skill, read `CONTRIBUTING.md` first.
