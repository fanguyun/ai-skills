# ai-skills

一个用于集中维护可复用 AI skills 的仓库，适用于 OpenAI Codex CLI、Claude Code 以及其他支持本地 skill 目录的 agent 工作流。

## 目标

- 统一维护 skills 源码，避免在多个工具目录里重复编辑。
- 用仓库作为唯一源码，便于版本管理、打包、安装和回滚。
- 通过公共 skill 池或软链接连接不同工具链。
- 保持 `SKILL.md` 同时兼容 Codex CLI 与 Claude Code。

## 仓库结构

```text
ai-skills/
├── AGENTS.md                 # Codex 工作准则
├── CLAUDE.md                 # Claude Code 工作准则
├── CONTRIBUTING.md           # 贡献规范
├── LICENSE                   # 仓库许可证
├── README.md                 # 仓库说明
├── package.json              # 管理脚本入口
├── .github/
│   ├── ISSUE_TEMPLATE/
│   └── pull_request_template.md
├── scripts/                  # 仓库管理脚本
├── templates/
│   └── skill-template/       # 新 skill 模板
├── base-guidelines/          # 以下为 skill 源码目录，共 13 个
├── cardio-training/
├── daily-habits/
├── dca-strategy/
├── gen-i18n/
├── git-commit-message/
├── h5-compat-audit/
├── learning-mentor/
├── million-dollar-weekend-research/
├── multi-mental-models/
├── project-security-scan/
├── reading-assistant/
├── skill-builder/
└── <skill-name>.skill       # 打包产物，随源码提交
```

约定说明：

- 每个 skill 使用独立目录，目录名采用小写字母和连字符。
- `SKILL.md` 是两平台共用的 skill 主体文件。
- `agents/openai.yaml` 用于 Codex UI 展示和隐式触发策略。
- `references/` 存放按需加载的参考资料。
- `scripts/`、`assets/` 仅在 skill 需要可执行脚本或模板资源时添加。
- 根目录下的 `.skill` 文件是打包产物，不是源码入口。
- 每个 skill 都有一份同名打包产物，便于直接分发；skill 内容变更后重新执行 `npm run pack <name>`，保持产物与源码一致。

## 单个 Skill 结构

```text
<skill-name>/
├── SKILL.md                  # 必须，两平台共用
├── README.md                 # 可选，面向人类的使用说明
├── agents/
│   └── openai.yaml           # 推荐，Codex UI 配置
├── references/               # 可选，详细参考资料
├── scripts/                  # 可选，可执行脚本
└── assets/                   # 可选，模板和静态资源
```

## 当前 Skills

| Skill | 触发方式 | 用途 | 当前资源 |
|-------|----------|------|----------|
| `base-guidelines` | `$base-guidelines` | 中文全局编码基准，约束最小变更、显式假设和验证闭环。 | `SKILL.md`、`agents/openai.yaml`、`base-guidelines.skill` |
| `cardio-training` | `$cardio-training` | 有氧与心肺训练处方：心率区间估算、Zone 2 打底、周训练量渐进、与力量训练的搭配和恢复信号。 | `SKILL.md`、`README.md`、`agents/openai.yaml`、`references/`、`cardio-training.skill` |
| `daily-habits` | `$daily-habits` | 设计并复盘睡眠作息、久坐打断、进食节律、烟酒减断与体检节奏等日常生活习惯。 | `SKILL.md`、`README.md`、`agents/openai.yaml`、`references/`、`daily-habits.skill` |
| `dca-strategy` | `$dca-strategy` | 长期复利定投系统，结合家庭资产负债和现金流，按月输出美股成长、A 股宽基、黄金和现金缓冲的核心+卫星组合规则。 | `SKILL.md`、`README.md`、`agents/openai.yaml`、`references/`、`dca-strategy.skill` |
| `gen-i18n` | `$gen-i18n` | 从 Excel 翻译表生成多语言 JSON 文件，适用于整理、修复和自动化 i18n 资源生成流程。 | `SKILL.md`、`agents/openai.yaml`、`scripts/gen-i18n.js`、`gen-i18n.skill` |
| `git-commit-message` | `$git-commit-message` | 基于当前暂存 diff 生成 Git CZ（Conventional Commits）规范提交内容。 | `SKILL.md`、`README.md`、`agents/openai.yaml`、`git-commit-message.skill` |
| `h5-compat-audit` | `$h5-compat-audit` | 审查 H5 页面和前端代码在安卓 6+、旧 iPhone、微信内浏览器和现代桌面浏览器中的兼容性风险。 | `SKILL.md`、`README.md`、`agents/openai.yaml`、`references/`、`h5-compat-audit.skill` |
| `learning-mentor` | `$learning-mentor` | 个性化学习导师，用于制定学习计划、快速入门陌生领域和规划学习路径。 | `SKILL.md`、`agents/openai.yaml`、`learning-mentor.skill` |
| `million-dollar-weekend-research` | `$million-dollar-weekend-research` | 基于快速市场验证理念调研项目或创业点子，输出可执行的 Go/调整/停止决策与访谈、外联、预售数据表。 | `SKILL.md`、`README.md`、`agents/openai.yaml`、`references/`、`million-dollar-weekend-research.skill` |
| `multi-mental-models` | `$multi-mental-models` | 多元思维模型分析助手，用多学科、多维度模型分析问题并给出结构化建议、风险提醒和行动方案。 | `SKILL.md`、`README.md`、`agents/openai.yaml`、`references/`、`multi-mental-models.skill` |
| `project-security-scan` | `$project-security-scan` | 对 Node.js/TypeScript 仓库执行只读的项目安全审计，覆盖生产依赖、业务代码与交付配置风险，并输出含证据与修复建议的报告。 | `SKILL.md`、`README.md`、`agents/openai.yaml`、`references/`、`project-security-scan.skill` |
| `reading-assistant` | `$reading-assistant` | 分析书籍核心价值、局限与观点，并输出结构化读书报告和精读或分形阅读建议。 | `SKILL.md`、`agents/openai.yaml`、`reading-assistant.skill` |
| `skill-builder` | `$skill-builder` | 补全同时兼容 Claude Code 和 Codex CLI 的跨平台 skill，整理 `SKILL.md`、`README.md` 和 Codex UI 配置。 | `SKILL.md`、`assets/openai.yaml`、`skill-builder.skill` |

## 本地安装链路

当前本机链路如下：

```text
~/ai-skills/<skill>                     # 唯一源码
  -> ~/.skills-manager/skills/<skill>   # 本机公共 skill 池
    -> ~/.codex/skills/<skill>
    -> ~/.claude/skills/<skill>
```

说明：

- `<skills-repo>` 表示当前 skill 源码仓库路径。
- `~/.skills-manager/skills` 是本机公共 skill 池；skill 先进入池中，再由各工具从池里软链接。
- 仓库自身的 skill 不再经 `~/.agents/skills` 中转，该目录只保留其他来源的 skill。
- 如果不使用公共池，也可以把单个 skill 直接链接到工具目录。
- 各项目仓库（如个人数字团队）再从 `~/.skills-manager/skills` 链接到自己的 `.agents/skills/`。
- `npm run install` 与 `npm run uninstall` 都经由 `skills-manager-cli` 操作公共池与部署记录；`git` 源 skill 更新用 `skills-manager-cli skills update <name>`，`local` 源重跑 `npm run install <name>` 即可刷新。

## 常用命令

| 命令 | 作用 |
|------|------|
| `npm run new <name>` | 创建新 skill 目录（含模板文件） |
| `npm run install <name>` | 安装 skill 到本地工具链（先入公共池 `~/.skills-manager/skills`，再部署到 `~/.codex/skills`、`~/.claude/skills`） |
| `npm run uninstall <name>` | 卸载 skill（只移除软链接，不删源码） |
| `npm run list` | 查看所有 skill 的安装状态 |
| `npm run pack <name>` | 将 skill 打包为 `.skill` 文件（输出到仓库根目录） |
| `npm run validate <name>` | 验证 skill 目录结构是否合规 |

## 新增 Skill

官方入口是 `npm run new <skill-name>`。

1. `npm run new <skill-name>`
2. 编写 `SKILL.md`、`README.md`，按需补充 `references/`、`scripts/`、`assets/`
3. 检查 `agents/openai.yaml` 中的 `display_name`、`short_description`、`policy.allow_implicit_invocation`
4. `npm run validate <skill-name>` 检查结构
5. `npm run pack <skill-name>` 打包
6. `npm run install <skill-name>` 安装到本地
7. 用真实任务验证，然后提交

更详细的规范见 `CONTRIBUTING.md`。

## 维护规则

- 修改 `SKILL.md` 时，保持 frontmatter 中的 `name` 与目录名一致。
- `description` 应写清楚触发场景，兼顾中文和必要英文关键词。
- `SKILL.md` 控制在 500 行以内，详细规则放入 `references/`。
- `agents/openai.yaml` 至少维护 `display_name` 和 `short_description`；如需控制隐式触发，再补充 `policy.allow_implicit_invocation`。
- JSON 配置必须保持严格合法 JSON，禁止末尾逗号。
- 更新 skill 后优先执行 `npm run validate <name>`；需要分发时再执行 `npm run pack <name>`。

## 发布

```bash
git add .
git commit -m "feat: add or update AI skills"
git remote add origin <your-github-repo>
git push -u origin main
```

## 备注

- 通常不存在所有工具自动共享的系统级 skill 目录，本仓库承担唯一源码职责。
- 工具侧安装仍依赖软链接或各工具自己的发现机制。
- 如果要公开发布单个 skill，可以把对应 skill 目录单独提取为独立仓库。

## 贡献

新增或修改 skill 前，先阅读 `CONTRIBUTING.md`，并按当前仓库结构完成验证。
