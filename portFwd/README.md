# 原理介绍

C (user) ---------ssh---------> B (中转服务) <-----------ssh----------- A (内网服务器)

           本地端口转发(-L)                        远程(反向)端口转发(-R)
           
 C:XX(端口) -------------> B:YY(端口)    B:YY(端口)  --------------> A:ZZ(端口)

# 注意点

需要配置连接保活, 避免连接异常中断卡主

方法1：ssh 参数 -o ServerAliveInterval=30 -o ServerAliveCountMax=1

ServerAliveInterval：这个选项让客户端定时发送消息给服务器，以保持连接活跃。

ServerAliveCountMax：如果服务器没有响应客户端的保活消息，这个选项定义了在考虑连接死亡之前，客户端尝试发送保活消息的最大次数。

方法2：配置文件生效 ~/.ssh/config

```shell
Host B-IP
    ServerAliveInterval 30
    ServerAliveCountMax 1
```

# 配置方法

## A 服务器:

ssh -N -R YY:localhost:ZZ 用户名@B的IP地址

-N告诉SSH这个连接不用执行任何远程命令

## B 服务器:

一般不需要配置，保证 ssh 服务可访问。如果端口不能转发，需要检查 /etc/ssh/sshd_config 文件中）允许端口转发

AllowTcpForwarding yes    (默认为 yes)

## C 服务器:

ssh -N -L XX:localhost:YY 用户名@B的IP地址

# 更加友好的方案

## A 服务器:

使用 `systemd` 服务,

修改 ssh-tunnel.service 脚本中 username，用户名，服务器 B ip，以及所需要的端口号

执行 sh in.sh 即可

systemctl status 服务名称.service  确认生效成功

# 注意事项

注意添加 A 服务器的免密登录。
