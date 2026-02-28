# Termux - 标准开发环境

> macOS 环境下，终端需要设置 option 为 mate 键才能在 nano 中使用set mark 功能

# APP 安装

https://github.com/termux/termux-app/releases/

# 本体安装 SSH

本体环境与 proot 环境是两个独立的环境，对应的 ssh 实际也是分开的，所以实际需要本题装一次 ssh 在 proot 环境再装一次

1. 安装 OpenSSH
	1. 安装：输入 `pkg install openssh -y`
	2. 设置密码：输入 `passwd` ，设置如 `12345`
	3. 查询账户：输入 `whoami` ，显示如 `u0_a232`
	4. 查询 IP： 输入 `ifconfig | grep inet` ，找到 IP（注意不是网关）
	5. 启动 SSH：输入 `sshd -p 10022` 
2. 电脑接入 Termux 的 SSH 
	1. 终端输入`ssh u0_a232@192.168.31.109 -p 10022`
	2. 输入密码

*使用 top 查看会发现单端接入也会有两个 session，属于正常情况

# 本体环境配置

## 换源（按界面提示，空格选择-回车确认）

```shell
termux-change-repo
```

## 安装必要工具

```shell
pkg update && pkg install -y proot-distro expect
```

## 设置快捷栏

打开配置文件
```shell
nano ~/.termux/termux.properties
```

修改和填入，修改后 ctrl + x 退出与保存，y + 回车
```shell
# 开启这个可以进入 temrux 时不默认开启键盘
hide-soft-keyboard-on-startup = true

# 注意JSON格式中空格与TAB单符并不一致，正确需使用“空格”
# 自定义双层按钮
extra-keys = [[ \
    {macro: "CTRL c", display: "⌃C"}, \
    {key: DRAWER, popup: ESC}, \
    'HOME', 'UP', 'END', \
    {key: ENTER, popup: {macro: "y ENTER", display: "y↲"}} \
],[ \
    {macro: "CTRL d", display: "⌃D"}, \
    'CTRL', 'LEFT', 'DOWN', 'RIGHT', 'ALT' \
]]
```

修改后可以重启或直接命令刷新
```shell
termux-reload-settings
```

## 登录自启 SSH 与开屏信息

下载 SSH 自启动脚本
```shell
curl -o ~/l00-termux-start.sh "https://raw.githubusercontent.com/l00jj/termux-helper/refs/heads/main/shell/l00-termux-start.sh?new"
```

修改自启配置文件 `~/.bashrc` ，自启刚刚下载的文件
```shell
grep -q "# >>> l00 Init Start >>>" ~/.bashrc && \
sed -i '/# >>> l00 Init Start >>>/,/# <<< l00 Init End <<</c\# >>> l00 Init Start >>>\nbash ~/l00-termux-start.sh\n# <<< l00 Init End <<<' ~/.bashrc || \
echo -e '\n# >>> l00 Init Start >>>\nbash ~/l00-termux-start.sh\n# <<< l00 Init End <<<\n' >> ~/.bashrc
```
（可选）确认是否正确写入 `nano ~/.bashrc`


# 安装 Ubuntu （proot-distro）

> 确认已安装  proot-distro 再进行后面步骤

安装 Ubuntu
```shell
proot-distro install ubuntu
```
> 如果速度过慢或需要指定版本安装，当前为25，参考 [[Termux - Ubuntu]]
  
启动 Ubuntu
```shell
proot-distro login ubuntu
```
  
*查看当前 Ubuntu 版本
```shell
lsb_release -a
```
  
# 配置基础环境

## 换源
https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
> 较为复杂，如果不是很慢可以不换

## 开发环境
```shell
apt update && apt install -y make build-essential git curl 
```


# 安装 Nodejs

https://nodejs.org/en/download

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

```shell
\. "$HOME/.nvm/nvm.sh"
```

```
nvm install 24
```

*验证*
```shell
node -v && npm -v && node -e "console.log(process.platform, process.platform === 'linux' ? '正常' : '错误')"
```

# 安装 Python

如果不需要指定版本可以直接安装
```shell
apt install -y python3 python3-pip python-is-python3
```

*验证*
```shell
python -V
```






# 部署 OpenCV

必要图形库
```shell
apt install -y libgl1 libx11-6 libglib2.0-0 libsm6 libxrender1 libxext6 libgomp1 ccache
```

*安装 opencv-python-headless 如使用 venv也不全局安装*
```shell
pip install opencv-python-headless --break-system-packages -i https://pypi.tuna.tsinghua.edu.cn/simple
```





# 远程开发环境部署搭建

主要针对远程直接控制 ubuntu 环境，使用 vscode 的 Remote-ssh 插件，在左下角 >< 符号

由于需要用到 nodejs 而且 ssh 进入的是 termux 本体，并不是 ubuntu ，所以需要在 ubuntu 内在建立一个 ssh 服务进行接入。
### 安装与配置 OpenSSH
```shell
apt update && apt install -y openssh-server psmisc
```

### 启动器下载与创建必要文件夹
```shell
curl -fSSLo remote-ssh-boot.sh https://raw.githubusercontent.com/l00jj/termux-helper/refs/heads/main/remote-ssh/remote-ssh-boot.sh && chmod +x remote-ssh-boot.sh && mkdir -p /run/sshd
```

### 日常启动
```shell
bash remote-ssh-boot.sh
```

### 配置 Remote-SSH
```
# p20 termux 远程
Host MyTermuxPhone
	HostName 192.168.31.183
	User root
	Port 10066
```