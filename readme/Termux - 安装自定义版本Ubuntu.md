# 指定版本安装 Ubuntu / Debian

> 需要去官网查看最新的使用方法
> https://github.com/termux/proot-distro

## 1. 默认下载找到地址

首先下载文件到 `~/`
```shell
wget https://github.com/termux/proot-distro/releases/download/v4.11.0/ubuntu-jammy-aarch64-pd-v4.11.0.tar.xz
```
或者电脑下载后传到手机
```shell
scp -P 3399 /Volumes/Room/app/dev/aitouch/install/ubuntu-noble-aarch64-pd-v4.18.0.tar.xz root@192.168.31.109:/data/data/com.termux/files/home
```

计算得出 SHA256
```shell
sha256sum ubuntu-jammy-aarch64-pd-v4.11.0.tar.xz
```

进入目录并新建文件 `<alias>.sh`，安装后会以文件名作为代称
```shell
cd $PREFIX/etc/proot-distro
```

```shell
#!/bin/bash

DISTRO_NAME="Ubuntu 24.04 LTS"

# 这里填写网址或者本地地址
TARBALL_URL['aarch64']="~/ubuntu-jammy-aarch64-pd-v4.11.0.tar.xz"

# 使用计算出来sha值
TARBALL_SHA256['aarch64']="caddd5b6d4dc48fd028e369a9ecb101f96e01ad3957b46e77f637252612ec628"
```


## 2. 安装

```shell
proot-distro install <alias> # 例如 ubuntu24.sh 就就填写 ubuntu24
```



# 启动

```shell
proot-distro login ubuntu # debian or ubuntu
```