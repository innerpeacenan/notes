# 主要目的  
这个页面主要记录自己学习 javascript, python, bash, Java, PHP, c 等语言的一些轨迹和经验教训.  
待日后进一步完善.  

## mysql错误的解决方法:  

错误信息: The server quit without updating PID file (/usr/local/mysql/var/ubuntu.pid) 

触发背景: 在重新启动mysql过程中,遇到一次重启失败, 提示信息如下:

> Starting mysql (via systemctl): mysql.serviceJob for mysql.service failed because the control process exited with error code. See "systemctl status mysql.service" and "journalctl -xe" for details.
 failed!

问题排查过程: 

(1) 按照提示信息,运行 `journalctl -xe`, 提示信息中包含以下内容:

> -- Unit mysql.service has begun starting up.  
Nov 01 13:09:07 ubuntu mysql[42837]: Starting MySQL  
Nov 01 13:09:08 ubuntu mysql[42837]: . * The server quit without updating PID file (/usr/local/mysql/var/ubuntu.pid).  
Nov 01 13:09:08 ubuntu systemd[1]: mysql.service: Control process exited, code=exited status=1  
Nov 01 13:09:08 ubuntu systemd[1]: Failed to start LSB: start and stop MySQL.  

解决方案:

```
touch /usr/local/mysql/var/ubuntu.pid
```
在文件中写入下面这行(42837 为 `journalctl -xe` 中 `mysql[42837]` 部分中的pid):

```
42837
```
然后修改文件所有属性, 我的mysql 用户为 root群组下的mysql用户,

```
chown root:mysql /usr/local/mysql/var/ubuntu.pid
```

然后重新启用mysql,可正常启用.
