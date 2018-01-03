* 我个人的理解，待进一步验证
```
location /{
        # 如果所请求的文件不存在
        if (!-e $request_filename) {
		    #对于renovation web目录下的所有文件，请求转发到renovation/web目录下的index文件，并附加之前捕获的参数
            rewrite ^/renovation/web/(.*)$ /renovation/web/index.php?$1 last; 
			#将0个或多个任以非换行符的请求转发到根目录下名为index.php的文件下
            rewrite  ^(.*)$  /index.php?s=$1  last;
            #其他情况，直接终止查找			
            break;
        }
}
```


nginx 源码安装:

登录nginx 管网 https://nginx.org/en/docs/install.html,在 Building from Sources 部分点击
[Building nginx from Sources](https://nginx.org/en/docs/configure.html)
[ngix 的源码包](http://hg.nginx.org/nginx/)在这个网址下载,在右侧选择对应版本的连接进去,在左侧 选择 zip 或者 gz 进行下载.
以 `gz` 格式的压缩包为例:

总体过程为 用 configure 方式生成对应的 makefile, 然后执行 makefile 进行编译

注意所有的配置选项都必须写在一行内

Example of parameters usage (all of this needs to be typed in one line):

解压,我所下载的安装包的名称为: `nginx-08b443b6b59d.tar.gz`
所以解压命令如下:

tar -zxvf nginx-08b443b6b59d.tar.gz

执行 `./auto/configure --sbin-path=/usr/local/nginx/nginx  --conf-path=/usr/local/nginx/nginx.conf --pid-path=/usr/local/nginx/nginx.pid --with-http_ssl_module --with-pcre=../pcre-8.41  --with-zlib=../zlib-1.2.11`,
这些示例配置管网上有,各个配置项的含义管网上也有:

[按照管网教程,遇到一个问题,解决方案如下](https://github.com/cuber/ngx_http_google_filter_module/issues/67)



按照官方文档, 在 make 之前,要先分别下载好  `pcre` 和 `zlib`,
记住,配置文件写的 `pcre` 是在 `ngix` 工作目录的同一级别目录,因此将下载和解压后的 pcre 安装包放到 nignx 目录父目录下,也即和nginx 是同一级别目录.

```
zlib 地址: http://zlib.net/zlib-1.2.11.tar.gz
pcre 地址: https://jaist.dl.sourceforge.net/project/pcre/pcre/8.41/pcre-8.41.tar.gz
```

config 之后的结构如下:
```
  nginx path prefix: "/usr/local/nginx"
  nginx binary file: "/usr/local/nginx/nginx"
  nginx modules path: "/usr/local/nginx/modules"
  nginx configuration prefix: "/usr/local/nginx"
  nginx configuration file: "/usr/local/nginx/nginx.conf"
  nginx pid file: "/usr/local/nginx/nginx.pid"
  nginx error log file: "/usr/local/nginx/logs/error.log"
  nginx http access log file: "/usr/local/nginx/logs/access.log"
  nginx http client request body temporary files: "client_body_temp"
  nginx http proxy temporary files: "proxy_temp"
  nginx http fastcgi temporary files: "fastcgi_temp"
  nginx http uwsgi temporary files: "uwsgi_temp"
  nginx http scgi temporary files: "scgi_temp"
```

从生成的 makefile,所以来运行 `make` 命令 ,

trouble shooting
[but when execute 'nginx -s reload', this error occur:nginx: [error] invalid PID number "" in "/run/nginx.pid"](http://www.fatalerrors.org/a/nginx-error-invalid-pid-number-in-run-nginx.pid.html)



### 使用
This guide describes how to start and stop nginx, and reload its configuration, explains the structure of the configuration file and describes how to set up nginx to serve out static content, how to configure nginx as a proxy server, and how to connect it with a FastCGI application.


For getting the list of all running nginx processes, the ps utility may be used, for example, in the following way:

ps -ax | grep nginx


[ngix 升级](http://zhaoxijun.iteye.com/blog/2330277)

### systemctl 命令
systemctl stop apache2.service
/etc/init.d/apache2 stop



----------------------------------------------------

location 后边跟的都是对 uri 的配置,格式如下:

```
location [ = | ~ | ~* | ^~ ] path { ... }

location @name { ... }
```

匹配优先级  = > ^~ > ~ 或 ~* >  > prefix

If the longest matching prefix location has the “^~” modifier then regular expressions are not checked.

参考:

uri = path + query_string

http://www.nginx.cn/115.html

https://www.digitalocean.com/community/questions/the-404-pages-doesnt-work-when-i-write-an-unexisting-url-in-my-server

https://serverfault.com/questions/465607/nginx-document-rootfastcgi-script-name-vs-request-filename



```
主体配置实例:


user nanxiaoning nanxiaoning;
worker_processes 4;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

worker_rlimit_nofile 51200;

events {
    use   epoll;
    worker_connections  51200;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format main '$remote_addr | $http_x_forwarded_for | $time_local | $request |'
                    '$status | $body_bytes_sent | $bytes_sent | $http_referer |'
                    '$http_user_agent | $msec | $request_time | $gzip_ratio';

    access_log  /var/log/nginx/access.log  main;

    server_tokens off;

    sendfile        on;
    tcp_nopush     on;
    tcp_nodelay on;


    keepalive_timeout  65;

    server_names_hash_bucket_size 128;
    client_header_buffer_size 32k;
    large_client_header_buffers 4 32k;
    client_max_body_size 50m;
	include /etc/nginx/conf.d/*.conf;
}



server {
    listen 10498;
    server_name localhost;

    root /var/www/deploy/test;
    index index.php index.html;

	location / {
	    try_files $uri $uri/ /index.php$is_args$query_string;
	}

    location ~ \.php$ {
	    # first attempt to serve request as file, then fail back to display a 404
        try_files $uri =404;
        # 这种方式需要通过 tcp 链接 php-fpm
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

}
```











The most important things to note are that locations, with the exception of named locations, works on the URI without any query parameters and only one location block will ever be run.

nginx: 讲的非常好
https://blog.martinfjordvald.com/2010/07/nginx-primer/



官网对优先级的描述

 > A location can either be defined by a prefix string, or by a regular expression. Regular expressions are specified with the preceding “~*” modifier (for case-insensitive matching), or the “~” modifier (for case-sensitive matching). To find location matching a given request, nginx first checks locations defined using the prefix strings (prefix locations). Among them, the location with the longest matching prefix is selected and remembered. Then regular expressions are checked, in the order of their appearance in the configuration file. The search of regular expressions terminates on the first match, and the corresponding configuration is used. If no match with a regular expression is found then the configuration of the prefix location remembered earlier is used.



参考:
https://nginx.org/en/docs/http/ngx_http_core_module.html#location




nginx 里边的一个重要的陷阱

https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/


### nginx return 语句
```
# return 200 $uri; http://localhost:8588       /                                                                                          
# return 200 $uri; http://localhost:8588/test /test

http://localhost:8588/test.py.hello/php.php/test  /test.py.hello/php.php
```
$document_root:/var/www/deploy/beeper_develper_platform/current/public/index.php
$fastcgi_script_name: /test.py.hello/php.php
/var/www/deploy/beeper_develper_platform/current/public/index.php/test.py.hello/php.php
#return 200 $document_root$fastcgi_script_name; 
 return 200 $fastcgi_script_name; 
 return 200 $document_root$fastcgi_script_name;


nginx 使用注意的pitfall:

https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/#root-inside-location-block

这个问题可能的原因:

https://serverfault.com/questions/517190/nginx-1-fastcgi-sent-in-stderr-primary-script-unknown


强制重启 nginx

sudo nginx -q -s reopen









