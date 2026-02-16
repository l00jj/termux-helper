#!/bin/bash

echo -e "\n------- l00 Init -------\n"

SSH_PORT=10099
USER_NAME=$(whoami)
PASS_FILE=~/l00-termux-start-pw

# 获取 IP
IP_ADDRESS=$(ifconfig 2>/dev/null | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)

# 检查 sshd 是否已经在运行，但当前无插件情况下不判断端口是否正确
if pgrep -x sshd > /dev/null; then
    echo "sshd already running on port ${SSH_PORT}"
    # （暂时不需要验证）检查密码文件是否存在 if [ -f "$PASS_FILE" ]; then
    PASS=$(cat "$PASS_FILE")
    PASS_STATUS=""
else
    PASS=$(printf "%06d" $(( $(od -An -N4 -tu4 < /dev/urandom) % 1000000 )))
    # 设置新密码
    expect -c "spawn passwd; expect \"*password*\"; send \"$PASS\r\"; expect \"*password*\"; send \"$PASS\r\"; expect eof"
    # 保存密码到文件
    echo "$PASS" > "$PASS_FILE"
    # 其他用户无法查看
    chmod 600 "$PASS_FILE"
    PASS_STATUS="[New PW]"
    # 启动 sshd
    echo "Starting sshd..."
    sshd -p ${SSH_PORT}
fi


# 显示信息
echo -e "\n\n↓↓↓↓↓↓↓ Termux SSH Information ↓↓↓↓↓↓↓\n"
echo "Username  : ${USER_NAME}"
echo "IP Address: ${IP_ADDRESS}"
echo "SSH PORT  : ${SSH_PORT}"
echo "Password  : ${PASS}  ${PASS_STATUS}"
echo "终端接入命令 : ssh ${USER_NAME}@${IP_ADDRESS} -p ${SSH_PORT}"
echo -e "\n - - - - - - - - - - - - - - - - - - -\n\n"

echo "查询进程    : top"
echo "终止相关进程 : pkill sshd"
echo "终止PID进程 : kill <PID>"
echo -e "\n - - - - - - - - - - - - - - - - - - -\n\n"

echo ">>> 当前环境是 ubuntu <<<"
proot-distro login ubuntu