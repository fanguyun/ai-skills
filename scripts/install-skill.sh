#!/usr/bin/env bash
set -euo pipefail

# 把 skill 接入本机工具链。
#
# 链路：
#   <source-root>/<skill>                  # 唯一源码
#     -> ~/.skills-manager/skills/<skill>  # 公共池
#       -> ~/.codex/skills/<skill>         # 由 skills-manager 部署
#       -> ~/.claude/skills/<skill>
#
# 池内容与部署记录统一由 skills-manager-cli 维护，本脚本不再自己建软链接。

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "用法: $0 <skill-name> [source-root]" >&2
  echo "示例: $0 h5-compat-audit \$HOME/ai-skills" >&2
  exit 1
fi

SKILL_NAME="$1"
SOURCE_ROOT="${2:-$HOME/ai-skills}"
SOURCE_DIR="$SOURCE_ROOT/$SKILL_NAME"

CLI="${SKILLS_MANAGER_CLI:-$HOME/.skills-manager/bin/skills-manager-cli}"
POOL_DIR="$HOME/.skills-manager/skills"
CODEX_DIR="$HOME/.codex/skills"
CLAUDE_DIR="$HOME/.claude/skills"
TARGET_AGENTS=("codex" "claude_code")

if [ ! -f "$SOURCE_DIR/SKILL.md" ]; then
  echo "未找到 skill 源码目录: $SOURCE_DIR" >&2
  exit 1
fi

if [ ! -x "$CLI" ]; then
  echo "未找到 skills-manager-cli: $CLI" >&2
  echo "可通过环境变量 SKILLS_MANAGER_CLI 指定可执行文件路径。" >&2
  exit 1
fi

read_source_type() {
  "$CLI" skills show "$SKILL_NAME" --json 2>/dev/null |
    python3 -c 'import json, sys; print(json.load(sys.stdin).get("source_type") or "")' 2>/dev/null ||
    true
}

SOURCE_TYPE="$(read_source_type)"

if [ -z "$SOURCE_TYPE" ]; then
  echo "公共池中未登记，按本机源码安装: $SKILL_NAME"
  "$CLI" skills install "$SOURCE_DIR" --local >/dev/null
elif [ "$SOURCE_TYPE" = "local" ]; then
  echo "公共池中已登记（local 源），刷新池内副本: $SKILL_NAME"
  "$CLI" skills install "$SOURCE_DIR" --local >/dev/null
else
  echo "公共池中已登记（$SOURCE_TYPE 源），跳过安装: $SKILL_NAME"
  echo "  更新该 skill 请执行: $CLI skills update $SKILL_NAME"
fi

for agent in "${TARGET_AGENTS[@]}"; do
  echo "部署到 $agent"
  "$CLI" skills deploy --agent "$agent" "$SKILL_NAME" >/dev/null
done

echo "已安装 $SKILL_NAME"
echo "  源码: $SOURCE_DIR"
for path in "$POOL_DIR/$SKILL_NAME" "$CODEX_DIR/$SKILL_NAME" "$CLAUDE_DIR/$SKILL_NAME"; do
  if [ -e "$path" ]; then
    echo "  ✓ $path"
  else
    echo "  ✗ $path（未接入，请检查 skills-manager 的 agent 配置）"
  fi
done
