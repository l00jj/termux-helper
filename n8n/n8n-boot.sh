#!/bin/bash
# ~/start-n8n.sh

LOCAL_IP=$(hostname -I | awk '{print $1}')

# 核心配置
export N8N_HOST=0.0.0.0
export N8N_PORT=5678
export N8N_PROTOCOL=http
export N8N_SECURE_COOKIE=false
export N8N_EDITOR_BASE_URL=http://${LOCAL_IP}:5678
export TZ=Asia/Shanghai

# 设置环境变量禁用 Python Task Runner
export N8N_RUNNERS_ENABLED=false
export N8N_TASK_RUNNERS_ENABLED=false

# 禁用诊断数据上报
export N8N_DIAGNOSTICS_ENABLED=false
# 禁用版本检查通知
export N8N_VERSION_NOTIFICATIONS_ENABLED=false
# 禁用遥测数据
export N8N_TELEMETRY_ENABLED=false


echo "============================================"
echo "  n8n 启动"
echo "  访问地址：http://${LOCAL_IP}:5678"
echo "============================================"

npx n8n start