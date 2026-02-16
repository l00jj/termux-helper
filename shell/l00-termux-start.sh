#!/bin/bash

# 定义端口号变量
SSH_PORT=3399

# 使用 ifconfig 获取 IP 地址
IP_ADDRESS=$(ifconfig 2>/dev/null | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)

# 显示基本信息
echo -e "\n\n↓↓↓↓↓↓↓ Termux SSH Information ↓↓↓↓↓↓↓\n"
echo "Username  : $(whoami)"
echo "IP Address: ${IP_ADDRESS}"
echo "SSH PORT  : ${SSH_PORT}"
# 启动临时 sshd 服务（确保配置正确或使用合适的方式启动）
sshd -p ${SSH_PORT}
# 输出连接提示
echo "终端接入命令: ssh $(whoami)@${IP_ADDRESS} -p ${SSH_PORT}"
echo -e "\n\n - - - - - - - - - - - - - - - - - - -\n"


#test