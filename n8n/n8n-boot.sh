#!/bin/bash
# ~/n8n-boot.sh

LOCAL_IP=$(hostname -I | awk '{print $1}')

# ===== 网络配置 =====
export N8N_HOST=0.0.0.0
export N8N_PORT=5678
export N8N_PROTOCOL=http
export N8N_SECURE_COOKIE=false
export N8N_EDITOR_BASE_URL=http://${LOCAL_IP}:5678
export WEBHOOK_URL=http://${LOCAL_IP}:5678/

# ===== Task Runner 配置（2.8+ 必需）=====
# 移除 N8N_RUNNERS_ENABLED（已废弃）
# 配置认证令牌，消除 403 错误
export N8N_RUNNERS_MODE=internal
export N8N_RUNNERS_AUTH_TOKEN="n8n-$(hostname | md5sum | cut -c1-32)"

# ===== 浏览器兼容性配置（关键！）=====
export N8N_COOKIE_SAME_SITE=lax
export N8N_COOKIE_SECURE=false

# ===== 隐私配置 =====
export N8N_DIAGNOSTICS_ENABLED=false            # 禁用诊断数据上报
export N8N_VERSION_NOTIFICATIONS_ENABLED=false  # 禁用版本检查通知
export N8N_TELEMETRY_ENABLED=false              # 禁用遥测数据

# ===== 时区 =====
export TZ=Asia/Shanghai

echo "============================================"
echo "  n8n 启动 - 多浏览器兼容配置"
echo "  访问地址：http://${LOCAL_IP}:5678"
echo "============================================"

npx n8n start