
## 安装（然后等待完成，可能会报错，但忽略，如果还不行，再装一次）
```shell
npm install -g openclaw@latest
```
## 第一次执行

初始化配置
```shell
openclaw onboard
```

参考：
https://docs.bigmodel.cn/cn/guide/develop/openclaw


下载启动脚本
```shell
curl -fSSLo openclaw-boot.sh https://raw.githubusercontent.com/l00jj/termux-helper/refs/heads/main/openclaw/openclaw-boot.sh && chmod +x openclaw-boot.sh
```

穿透
```shell
ssh -N -L 18789:127.0.0.1:18789 root@192.168.31.183 -p 55522
```

## 日常启动

执行
```shell
bash openclaw-boot.sh
```