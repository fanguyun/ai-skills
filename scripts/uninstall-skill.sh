#!/usr/bin/env bash
set -euo pipefail

# 卸载 skill：撤销 Codex / Claude Code 的部署，并从公共池移除库条目。
# 只清理安装痕迹，不会删除 <source-root>/<skill> 源码目录。

if [ "$#" -ne 1 ]; then
  echo "用法: $0 <skill-name>" >&2
  echo "示例: $0 h5-compat-audit" >&2
  exit 1
fi

SKILL_NAME="$1"
CLI="${SKILLS_MANAGER_CLI:-$HOME/.skills-manager/bin/skills-manager-cli}"
TARGET_AGENTS=("codex" "claude_code")

if [ ! -x "$CLI" ]; then
  echo "未找到 skills-manager-cli: $CLI" >&2
  echo "可通过环境变量 SKILLS_MANAGER_CLI 指定可执行文件路径。" >&2
  exit 1
fi

for agent in "${TARGET_AGENTS[@]}"; do
  if "$CLI" skills undeploy --agent "$agent" "$SKILL_NAME" >/dev/null 2>&1; then
    echo "已撤销部署: $agent"
  else
    echo "跳过（未部署或由 preset 管理）: $agent"
  fi
done

if "$CLI" skills show "$SKILL_NAME" >/dev/null 2>&1; then
  "$CLI" skills remove "$SKILL_NAME" --yes >/dev/null
  echo "已从公共池移除库条目: $SKILL_NAME"
else
  echo "公共池中不存在该 skill: $SKILL_NAME"
fi

echo "源码目录未改动；重新接入使用: npm run install $SKILL_NAME"
