### 安装 PHP-fpm 方式, 适用于unbantu,并且要有相应的源

* 通过 apt-get 安装 php-fpm, 可能存在找不到源的问题

> apt-get install php7-fpm

* 查看PHP 所加载的配置文件有哪些

> php --ini |grep Loaded

* 停止 apache 服务器, service 是 /etc/init.d/apache2 的快捷方式,如果该目录下不存在该shell可执行脚本,则该命令无效

> service apache2 stop 

* 检查php-fpm 的配置是否正确

> php-fpm7.1 --test

#### 期间遇到的问题:

An another FPM instance seems to already listen on /run/php/php7.1-fpm.sock

解决方案:
杀死 php-fpm 进程, 然后重新启动  php-fpm


### PHP 与 nginx 的协作原理

[php-fpm 与 nginx 协作原理](http://blog.csdn.net/u013474436/article/details/52972699)

[php-fpm master-slave 架构处理请求的流程](php-fpm支持三种运行模式，分别为static、ondemand、dynamic，默认为dynamic)。

 
