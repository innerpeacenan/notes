* 问题以: ssh 默认的端口是 22, 但要主要部分主机可能改了协议端口,登陆的时候需要指定端口.


* 问题: Bad owner or permissions on /home/nanxiaoning/.ssh/config

fatal: The remote end hung up unexpectedly


原因: 
ssh 的配置文件的权限必须只能为: `rw`

解决方式:

```
chmod 600 ~/.ssh/config
chown $USER ~/.ssh/config
```

* 问题: 用户 ffz 以 sudo 的方式运行的时候, public key 就失效了, 

原因: 这时其实登陆的身份为 root, 只是环境没有切换过来,因此需要root 对应的公钥


参考:

https://serverfault.com/questions/253313/ssh-returns-bad-owner-or-permissions-on-ssh-config
https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2