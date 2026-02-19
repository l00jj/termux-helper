#!/bin/bash

echo -e "\n\n↓↓↓↓↓↓↓ Remote-SSH ↓↓↓↓↓↓↓\n"

# 停止存在的服务
etc/init.d/ssh stop

SSH_PORT=55599
USER_NAME=$(whoami)

# 获取 IP
IP_ADDRESS=$(ifconfig 2>/dev/null | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)

# PermitRootLogin yes         # 允许 Root 登录
# PubkeyAuthentication no     # 不必配置秘钥
# PasswordAuthentication yes  # 允许密码登录
/usr/sbin/sshd -p ${SSH_PORT} \
  -o PermitRootLogin=yes \
  -o PubkeyAuthentication=no \
  -o PasswordAuthentication=yes \


# 显示信息
echo "SSH       : ssh ${USER_NAME}@${IP_ADDRESS} -p ${SSH_PORT}"
echo "Password  : ${PASS}
echo -e "\n - - - - - - - - - - - - - - - - - - -\n\n"