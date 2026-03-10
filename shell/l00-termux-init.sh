#!/bin/bash

###############################################################################
# 修改须知
# 1. 通过屏蔽 cat 整行获得提示注释，但记得修改后释放
# 2. 内容上防止与文本已有内容粘连，追加内容 echo -e "\n" >> "$TARGET_CONFIG"
###############################################################################


###############################################################################
#
# 自启动环节
#
###############################################################################
echo "正在修改 ~/.bashrc"

# 1. 定义路径变量
TEMP_CONFIG="$HOME/termux_new_config"
TARGET_CONFIG="$HOME/.bashrc"

# 2. 准备新配置的临时文件内容
cat << 'EOF' > "$TEMP_CONFIG"
# >>> l00 Config Start >>>
echo -e "\n - - - - - - - - - - - - - - - - - - - - - \n"
echo "查询进程    : top"
echo "终止相关进程 : pkill sshd"
echo "终止PID进程 : kill <PID>"
echo "启用 SSH   : bash boot-ssh.sh"
echo " * 启用 SSH 也可以长按导航栏“菜单”二级“SSH”
echo -e "\n - - - - - - - - - - - - - - - - - - - - - \n"

echo -e "\n - - - - - - - Login Ubuntu  - - - - - - - \n"
proot-distro login ubuntu
# <<< l00 Config End <<<
EOF

# 3. 检查文件是否存在，且如果存在旧块，则整块删除
if [ ! -f "$TARGET_CONFIG" ]; then
    touch "$TARGET_CONFIG"
fi
if grep -q "# >>> l00 Config Start >>>" "$TARGET_CONFIG"; then
    sed -i '/# >>> l00 Config Start >>>/,/# <<< l00 Config End <<</d' "$TARGET_CONFIG"
fi

# 4. 将新配置追加到文件末尾
cat "$TEMP_CONFIG" >> "$TARGET_CONFIG"

# 5. 清理临时文件
[ -f "$TEMP_CONFIG" ] && rm "$TEMP_CONFIG"
# source ~/.bashrc

echo "✅ ~/.bashrc"
















###############################################################################
#
# 修改 Termux 的导航栏
#
###############################################################################
echo "正在修改 ~/.termux/termux.properties"

# 1. 定义路径变量
TEMP_CONFIG="$HOME/termux_new_config"
TARGET_CONFIG="$HOME/.termux/termux.properties"

# 2. 准备新配置的临时文件内容
cat << 'EOF' > "$TEMP_CONFIG"
# >>> l00 Config Start >>>
# 开启这个可以进入 temrux 时不默认开启键盘
hide-soft-keyboard-on-startup = true
# 自定义双层按钮
extra-keys = [[ \
    {macro: "CTRL c", display: "⌃C"}, \
    {key: DRAWER, popup: {macro: "bash\ ~/boot-ssh.sh\n", display: "SSH"}}, \
    'HOME', 'UP', 'END', \
    {key: ENTER, popup: {macro: "y ENTER", display: "y↲"}} \
],[ \
    {macro: "CTRL d", display: "⌃D"}, \
    'CTRL', 'LEFT', 'DOWN', 'RIGHT', 'ALT' \
]]
# <<< l00 Config End <<<
EOF

# 3. 如果存在旧块，则整块删除
if grep -q "# >>> l00 Config Start >>>" "$TARGET_CONFIG"; then
    sed -i '/# >>> l00 Config Start >>>/,/# <<< l00 Config End <<</d' "$TARGET_CONFIG"
fi

# 4. 将新配置追加到文件末尾
cat "$TEMP_CONFIG" >> "$TARGET_CONFIG"

# 清理临时文件并重载配置
[ -f "$TEMP_CONFIG" ] && rm "$TEMP_CONFIG"
termux-reload-settings


echo "✅ ~/.termux/termux.properties"
















###############################################################################
#
# 创建 SSH 启动脚本 boot-ssh.sh
#
###############################################################################
echo "创建 SSH 启动脚本 ~/boot-ssh.sh"

## 1. 定义路径变量
TARGET_CONFIG="$HOME/boot-ssh.sh"

## 2. 写入脚本
cat << 'EOF' > "$TEMP_CONFIG"
#!/bin/bash

SSH_PORT=10022
USER_NAME=$(whoami)
PASS_FILE=~/l00-termux-start-pw

# 获取 IP
IP_ADDRESS=$(ifconfig 2>/dev/null | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)

# 检查 sshd -p [SSH_PORT] 端口是否已经启用
if pgrep -a sshd | grep -q "\-p ${SSH_PORT}"; then
    echo "sshd already running on port ${SSH_PORT}"
    # （暂时不需要验证）检查密码文件是否存在 if [ -f "$PASS_FILE" ]; then
    PASS=$(cat "$PASS_FILE")
    PASS_STATUS=""
else
    # 如需修改长度 "%04d" 与 9999 都要修改
    PASS=$(printf "%04d" $(shuf -i 0-9999 -n 1))
    # 设置新密码
    expect -c "spawn passwd; expect \"*password*\"; send \"$PASS\r\"; expect \"*password*\"; send \"$PASS\r\"; expect eof" >/dev/null 2>&1
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
echo -e "\n - - - - - - - - Termux SSH - - - - - - - - \n"
echo "Username  : ${USER_NAME}"
echo "IP Address: ${IP_ADDRESS}"
echo "SSH PORT  : ${SSH_PORT}"
echo "Password  : ${PASS}  ${PASS_STATUS}"
echo "终端接入命令 : ssh ${USER_NAME}@${IP_ADDRESS} -p ${SSH_PORT}"
echo -e "\n - - - - - - - - - - - - - - - - - - - - - \n\n"
EOF

echo "✅ 成功创建 SSH 启动脚本 ~/boot-ssh.sh"
