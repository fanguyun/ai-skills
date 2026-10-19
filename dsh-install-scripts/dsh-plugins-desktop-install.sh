#!/bin/bash
set -euo pipefail

# DSH 插件跨设备同步脚本（基于本机 desktop profile 配置）
# 用法：chmod +x dsh-plugins-desktop-install.sh && ./dsh-plugins-desktop-install.sh
# 前提：已安装 DSH CLI，登录同一 DeepSeek 账号

PROFILE=desktop

echo "=== DSH 插件跨设备同步脚本 ==="
echo "目标 profile: $PROFILE"
echo "当前时间：$(date)"
echo ""

# 显示本机已验证的配置清单（从 ~/.dsh/profiles/desktop/package.json）
echo "计划安装的插件清单："
echo "  - @linxin666/dsh-web-all@0.4.6"
echo "  - dsh-better-sidebar@0.26.1"
echo "  - dsh-claude-style@0.16.3"
echo "  - dsh-context@0.73.0"
echo "  - dsh-our-free-model@2.1.0"
echo "  - dsh-whale-widget@0.4.2"
echo "  - dshmarket@1.66.21"
echo "  - personal-digital-team (GitHub: fanguyun/ai-digital-team#main)"
echo ""

read -p "是否继续安装？(y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "已取消"
    exit 0
fi

echo "开始安装到 --profile $PROFILE..."
echo ""

# 逐条安装插件
dsh plugin --profile "$PROFILE" add @linxin666/dsh-web-all@0.4.6 || echo "⚠️ FAILED: @linxin666/dsh-web-all@0.4.6"
dsh plugin --profile "$PROFILE" add dsh-better-sidebar@0.26.1 || echo "⚠️ FAILED: dsh-better-sidebar@0.26.1"
dsh plugin --profile "$PROFILE" add dsh-claude-style@0.16.3 || echo "⚠️ FAILED: dsh-claude-style@0.16.3"
dsh plugin --profile "$PROFILE" add dsh-context@0.73.0 || echo "⚠️ FAILED: dsh-context@0.73.0"
dsh plugin --profile "$PROFILE" add dsh-our-free-model@2.1.0 || echo "⚠️ FAILED: dsh-our-free-model@2.1.0"
dsh plugin --profile "$PROFILE" add dsh-whale-widget@0.4.2 || echo "⚠️ FAILED: dsh-whale-widget@0.4.2"
dsh plugin --profile "$PROFILE" add dshmarket@1.66.21 || echo "⚠️ FAILED: dshmarket@1.66.21"
dsh plugin --profile "$PROFILE" add github:fanguyun/ai-digital-team#main || echo "⚠️ FAILED: personal-digital-team (GitHub)"

echo ""
echo "验证 bundle 加载状态..."
dsh --profile "$PROFILE" --dump-config 2>&1 | grep -E "@deepseek|dshmarket|better-sidebar|claude-style|our-free-model|whale-widget|linxin666|personal-digital-team" || echo "未找到对应 bundles（可能尚未加载完成，请重启会话）"

echo ""
echo "=== 安装完成 ==="
echo "提示：建议重启 DSH 或开新会话以重新加载所有 plugins"
