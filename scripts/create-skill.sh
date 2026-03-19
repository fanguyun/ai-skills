#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "用法: $0 <skill-name> [repo-root]" >&2
  echo "示例: $0 image-audit \$HOME/ai-skills" >&2
  exit 1
fi

SKILL_NAME="$1"
REPO_ROOT="${2:-$HOME/ai-skills}"
TEMPLATE_DIR="$REPO_ROOT/templates/skill-template"
TARGET_DIR="$REPO_ROOT/$SKILL_NAME"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "未找到模板目录: $TEMPLATE_DIR" >&2
  exit 1
fi

if [ -e "$TARGET_DIR" ]; then
  echo "目标目录已存在: $TARGET_DIR" >&2
  exit 1
fi

cp -R "$TEMPLATE_DIR" "$TARGET_DIR"
find "$TARGET_DIR" -type f \( -name 'SKILL.md' -o -name 'README.md' -o -name 'openai.yaml' \) -print0 | \
  while IFS= read -r -d '' file; do
    perl -0pi -e 's/your-skill-name/'"$SKILL_NAME"'/g' "$file"
  done

echo "已创建 skill 模板: $TARGET_DIR"
echo "下一步:"
echo "  1. 编辑 $TARGET_DIR/SKILL.md"
echo "  2. 补充 references/、scripts/ 或 assets/"
echo "  3. 运行 $REPO_ROOT/scripts/install-skill.sh $SKILL_NAME $REPO_ROOT"
