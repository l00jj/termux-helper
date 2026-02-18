
## 安装（然后等待完成，可能会报错，但忽略，如果还不行，再装一次）
```shell
npm install -g openclaw@latest
```
## 初始化配置

```shell
openclaw onboard
```
可能要等很久

参考：
https://docs.bigmodel.cn/cn/guide/develop/openclaw


修改局域网访问
```shell
nano ~/.openclaw/openclaw.json
```

修改 gateway 的设置
```json
"gateway": {
  "mode": "local",
  "bind": "lan",
  "controlUi": {
    "enabled": true,
    "allowInsecureAuth": true,
  },
}
```
openssl rand -hex 24
openclaw config get gateway.auth.token

# 更新 token
openclaw config set gateway.auth.token "你的新token"
openclaw config set gateway.bind "lan"
openclaw config set gateway.controlUi.allowInsecureAuth "true"

获取 IP 脚本
```shell
curl -fSSLo openclaw-ip.sh https://raw.githubusercontent.com/l00jj/termux-helper/refs/heads/main/openclaw/openclaw-ip.sh && chmod +x openclaw-ip.sh
```



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

openclaw dashboard --no-open && openclaw gateway --verbose