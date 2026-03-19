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

- `h5-compat-audit` - H5 compatibility audit for Android 6+, older iPhones, WeChat in-app browsers, and desktop browsers

## Local management scripts / 本地管理脚本

仓库内置了几个常用脚本：

### Create a new skill / 创建新 skill

```bash
./scripts/create-skill.sh <skill-name> <skills-repo>
```

示例：

```bash
./scripts/create-skill.sh image-audit .
```

### Install a skill / 安装 skill

```bash
./scripts/install-skill.sh <skill-name> <skills-repo>
```

这个脚本会自动接到：

- `~/.agents/skills`
- `~/.codex/skills`
- `~/.claude/skills`

### Uninstall a skill / 卸载 skill

```bash
./scripts/uninstall-skill.sh <skill-name>
```

这个脚本只移除本地软链接，不删除源码目录。

### List installed skills / 查看当前 skill 状态

```bash
./scripts/list-skills.sh
```

会分别列出：

- 源码目录中的 skill
- 公共池中的 skill
- Codex 已接入的 skill
- Claude 已接入的 skill

## Adding a new skill / 新增 skill

1. Run `./scripts/create-skill.sh <skill-name> <skills-repo>`
2. Edit `SKILL.md`
3. Add `references/`, `scripts/`, or `assets/` if needed
4. Run `./scripts/install-skill.sh <skill-name> <skills-repo>`
5. Validate with a real task
6. Commit and push

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
