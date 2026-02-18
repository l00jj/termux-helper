#!/bin/bash

# ============================================
# OpenClaw Dashboard 启动脚本（局域网版）
# ============================================

# 获取局域网 IP
IP_ADDRESS=$(ifconfig 2>/dev/null | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)

# 启动 dashboard 并捕获输出
OUTPUT=$(openclaw dashboard --no-open 2>&1)

# 提取 Token
TOKEN=$(echo "$OUTPUT" | grep -oP 'token=\K[a-f0-9]+' | head -1)

# 显示最终链接
echo "════════════════════════════════════════"
echo "🦞 OpenClaw Dashboard"
echo "════════════════════════════════════════"
echo "http://${IP_ADDRESS}:18789/#token=${TOKEN}"