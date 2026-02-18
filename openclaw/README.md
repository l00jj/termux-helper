
## 安装（然后等待完成，可能会报错，但忽略，如果还不行，再装一次）
```shell
npm install -g openclaw@latest
```

## 初始化配置
```shell
openclaw onboard
```

参考：
https://docs.bigmodel.cn/cn/guide/develop/openclaw


## 日常启动

下载
```shell
curl -fSSLo openclaw-boot.sh https://raw.githubusercontent.com/l00jj/termux-helper/refs/heads/main/openclaw/openclaw-boot.sh && chmod +x openclaw-boot.sh
```

执行
```shell
bash openclaw-boot.sh
```