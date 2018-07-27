运行方式(备忘)  ffz@ubuntu:~/opt/elasticsearch-6.0.0$ ./bin/elasticsearch
过程参考官方指南:(整体过程比较简单)

https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html

[阮一峰也写了一个教程, 过程与官方类似](http://www.ruanyifeng.com/blog/2017/08/elasticsearch.html)

[安装中文分词插件](https://github.com/medcl/elasticsearch-analysis-ik)

遇到的主要问题是:

(1) 以 root 身份运行的过程中, 发现提示不允许以root身份运行. 查找 github 资料发现 elasicsearch 确实不允许以 root 身份运行.

(2) 切换回普通用户身份(用户名为ffz), 一运行,报错.起初的关注点放到这里:

```
Exception in thread "main" 2017-12-03 15:37:26,373 main ERROR No log4j2 configuration file found. Using default configuration: logging only errors to the console. Set system property 'log4j2.debug' to show Log4j2 internal initialization logging.
2017-12-03 15:37:26,499 main ERROR Could not register mbeans java.security.AccessControlException: access denied ("javax.management.MBeanTrustPermission" "register")
```

然后网上一同搜索解决方案后, 无果. 有人提到出现这个问题可能是没有权限读取 elesticsearch 的配置文件. 让还没有意思到问什么没有读取到配置文件.直到回头再看宝座结果, 发现第一句就给出了非常明确的提示:

```
grep: /home/ffz/Downloads/elasticsearch-6.0.0/config/jvm.options: Permission denied
```
查看该文件的缺陷, 发现:

```
-rw-rw----
```

说明不是这个群组的用户, 连什么都做不了. 这个再熟悉不过了, 马上意识到了自己下载项目的时候, 是以root身份下载的,文件的所有者也是root, 而已ffz这个用户的身份读取和运行, 因此不具有权限.

解决方法: 

```
chown -R ffz:ffz  elasticsearch-6.0.0/
```

然后依据官方提供的方式运行, 成功启动.

(3) 安装了分词插件后重新启动, 暴露了新的问题. 信息如下:
```
Elasticsearch init scripts set max open files to 65535, but expects 65536
```

在ffz用户的环境下查看:

```
ffz@ubuntu:~$ulimit -n
65535
```

接下来要做的是修改 ulimit 配置, ulimit 有 sort 和 hard 两种, 并且是用户相关的, 不同的用户可以设置不同的值.打开ulimit的文件 /etc/security/limits.conf (部分发行版可能直接放在  /etc/limits.conf 下), 由于目前所在的用户为:ffz, 所以添加:

```
ffz  soft nofile 65539
ffz hard nofile 65539
```

有了这个设置, 重启后生效. 这样配置后, 重启后, 可以直接用命令 ulimit -n 65540 修改为更高值, 这个根据需要.

参考:

https://github.com/elastic/elasticsearch/issues/17468

https://stackoverflow.com/questions/34588/how-do-i-change-the-number-of-open-files-limit-in-linux

https://askubuntu.com/questions/162229/how-do-i-increase-the-open-files-limit-for-a-non-root-user

如果用 docker 部署的话,参考

https://github.com/docker-library/elasticsearch/issues/140


(4) 提示: max virtual memory areas vm.maxmapcount [65530] is too low

解决方法: 

打开 /etc/sysctl.conf 文件, 加入:

```
vm.max_map_count=262144
```
通过命令:

```
sysctl -p
```

让配置立刻生效.

如果通过一下命令运行的话,只能让当前shell生效.

```
sudo sysctl -w vm.max_map_count=262144
```


参考: 

https://zhidao.baidu.com/question/1883112082595974908.html



https://github.com/elastic/elasticsearch/issues/17430


(4) curl 发请求时候,提示 {"error":"Content-Type header [application/x-www-form-urlencoded] is not supported","status":406}

请求头中将 Content-type设置为: application/json

参考:
https://stackoverflow.com/questions/44453495/send-json-xml-txt-csv-files-to-elasticsearch


(5) Elasticsearch init scripts set max open files to 65535, but expects 65536
参考:
https://github.com/elastic/elasticsearch/issues/17430