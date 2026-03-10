#!/bin/bash
# Depend: expect

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
    {key: DRAWER, popup: {macro: "bash ~/boot-ssh.sh", display: "SSH"}}, \
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









