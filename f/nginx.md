## Nginx location的匹配规则

匹配符号 | 匹配规则
---|---
=  |    进行普通字符精确匹配
^~ |   ^~表示普通字符匹配，如果该选项匹配，只匹配该选项，不匹配别的选项，一般用来匹配目录
~  |    波浪线表示执行一个正则匹配，区分大小写
~* |   表示执行一个正则匹配，不区分大小写
@  |  #"@" 定义一个命名的 location，使用在内部定向时，例如 error_page, try_files


```
Syntax:location [ = | ~ | ~* | ^~ ] uri { ... }
location @name { ... }
Default:	—
Context:	server, location
```

```
        location /
        {
            try_files $uri @apache;
        }

        location @apache
        {
            internal;
            proxy_pass http://127.0.0.1:88;
            include proxy.conf;
        }

        location ~ [^/]\.php(/|$)
        {
            proxy_pass http://127.0.0.1:88;
            include proxy.conf;
        }
```

location 匹配优先级

> = 精确匹配会第一个被处理。如果发现精确匹配，nginx停止搜索其他匹配。

> “普通 location ”的匹配规则是“最大前缀”，因此“普通 location ”的确与 location 编辑顺序无关；但是“正则 location ”的匹配规则是“顺序匹配，且只要匹配到第一个就停止后面的匹配”；“普通location ”与“正则 location ”之间的匹配顺序是？先匹配普通 location ，再“考虑”匹配正则 location 。注意这里的“考虑”是“可能”的意思，也就是说匹配完“普通 location ”后，有的时候需要继续匹配“正则 location ”，有的时候则不需要继续匹配“正则 location ”。两种情况下，不需要继续匹配正则 location ：（ 1 ）当普通 location 前面指定了“ ^~ ”，特别告诉 Nginx 本条普通 location 一旦匹配上，则不需要继续正则匹配；（ 2 ）当普通location 恰好严格匹配上，不是最大前缀匹配，则不再继续匹配正则。

> 最后匹配带有"~"和"~*"的指令，如果找到相应的匹配，则nginx停止搜索其他匹配；当没有正则表达式或者没有正则表达式被匹配的情况下，那么匹配程度最高的逐字匹配指令会被使用。


eg:
```
location  = / {
  # 只匹配"/".
}
location  / {
  # 匹配任何请求，因为所有请求都是以"/"开始
  # 但是更长字符匹配或者正则表达式匹配会优先匹配
}
location ^~ /images/ {
  # 匹配任何以 /images/ 开始的请求，并停止匹配其它location
}
location ~* \.(gif|jpg|jpeg)$ {
  # 匹配以 gif, jpg, or jpeg结尾的请求.
}
```

## 指令
### try_files

[nginx中的try_files指令解释](http://www.cnblogs.com/wawahaha/p/4641691.html)

> 按顺序检查文件是否存在，返回第一个找到的文件。结尾的斜线表示为文件夹 -$uri/。如果所有的文件都找不到，会进行一个内部重定向到最后一个参数
务必确认只有最后一个参数可以引起一个内部重定向，之前的参数只设置内部URI的指向。 最后一个参数是回退URI且必须存在，否则将会出现内部500错误。
> try_files /app/cache/ $uri @fallback; 和  index index.php index.html;
 它将检测$document_root/app/cache/index.php,$document_root/app/cache/index.html 和 $document_root$uri是否存在，如果不存在着内部重定向到 @fallback 。
> 需要明确的是出最后一个参数外 try_files 本身不会因为任何原因产生内部重定向。


### 设置选项
### timeout
[What is the difference between connection and read timeout for sockets?](http://stackoverflow.com/questions/3069382/what-is-the-difference-between-connection-and-read-timeout-for-sockets)

> 1) What is the difference between connection and read  timeout for sockets?

The connection timeout is the timeout in making the initial connection; i.e. completing the TCP connection handshake.  The read timeout is the timeout on waiting to read data. Specifically, if the server fails to send a byte &lt;timeout> seconds after the last byte, a read timeout error will be raised.

> 2) What does connection timeout set to "infinity" mean? In what situation can it remain in an infinitive loop? and what can trigger that the infinity-loop dies?

It means that the connection attempt can potentially block for ever.  There is no infinite loop, but the attempt to connect can be unblocked by another thread closing the socket.  (A `Thread.interrupt()` call may also do the trick ... not sure.)

> 3) What does read timeout set to "infinity" mean? In what situation can it remain in an infinitive loop? and what can trigger that the infinity-loop dies?

It means that a call to `read` on the socket stream may block for ever.  Once again there is no infinite loop, but the `read` can be unblocked by a `Thread.interrupt()` call, closing the socket, and (of course) the other end sending data or closing the connection.


### 测试ngix工作状态测试
nginx -t
```
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful
```

```
# thinkphp
location / { // …..省略部分代码
   if (!-e $request_filename) {
   rewrite  ^(.*)$  /index.php?s=$1  last;
   break;
    }
 }



```


        location ~ \.php$ {
            root           html;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
            include        fastcgi_params;
        }