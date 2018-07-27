前端单页面, 只显示一个路由, 路由形式设置为 hash 方式. 
配置过程中遇到一个问题.

```
location ^~ /webstatic/ {
     root /project/web;
     break;
}
```

/project/web 下目录结构如下:

```
webstatic/
index.html
```

这样导致写规则的时候, `webstatic` 目录下index.html 无法被访问. 因为任务路径, `nginx` 在查找文件的时候, 匹配 path `/webstatic/` 的时候, 回到  /project/web/webstatic/ 下找相应的文件, 如 uri: /webstatic/index.html, 则 nginx 会找 /project/web/webstatic/index.html 文件, 而事实上该文件是不存在的.

因此, 采取的方法为, 推动前端将编译后的 `index.html` 放置到 `/project/web/open` 下面, 然后配置修改如下:

```
location ^~ /webstatic/ {
     root /project/web;
     break;
}

location ^~ /open/ {
     root /project/web;
     break;
}
```
然后以 `/open/index.html` 的为 uri 访问前端页面, 而其他静态资源, 则以 如 `/webstatic/js/index.js` 的形式访问.
至此, 问题得以解决.

文档在准备上前前, 与运维做了初步沟通, 运维关系式的意见是, 让域名主页近来后, 用户边进入前端页面, 然后通过各种方式调用后端的服务. 这样就要求 nginx 的规则中去掉 open 这一层目录, 这样带来一个问题是,  根路径 "/" 也满足转发关系 php 的要求, 因此会走fastcgi 的处理流程.最后采取的解决方式如下:

``` 
    root /var/www/deploy/beeper_develper_platform/current/web;
    index open/index.html;
    location ^~ /  {
        try_files $uri $uri/  @php;
    }   
                                                                                                                                                  
    location @php {
        root /var/www/deploy/beeper_develper_platform/current/public/index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_index  index.php;
        fastcgi_pass 127.0.0.1:9000;
    }   
 ```

location 中的 @ 代表别名, 以上配置的意思是, 做 web 根目录下, 如果请求的路径不是文件或者目录的所有 paht , 都交给 @php 这部分处理. 接下来对 @php 部分做进一步解释. 

* include fastcgi_params; 的作用是 引入在nginx.conf 同一级目录中的fastcgi_params.conf,作用为引入 需要的 fastcgi 参数. 这个文件的作用是定义 fastcgi 程序需要的入参 与 nginx 中的一些预定义常量的关系,如:

```
fastcgi_param  REQUEST_SCHEME   $scheme;
```

将协议名称, 如 https或 http 作为 fastcig 的参数 REQEST_SHCEME 传递给 fastcgi .
该文件中都是这类型的语句.

* fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; 这句的作用是为 fastcgi 引入参数 SCRIPT_FILENAME,我们知道 $document_root 是我们定义的 /var/www/deploy/beeper_develper_platform/current/public/index.php, 这个位置,那么fastcgi_script_name 这个参数是怎么来的呢? 该参数是根据 uri 中的正则匹配 ^(.+\.php)(/.+)$; 拆分而来的第二部分.

* fastcgi_pass 127.0.0.1:9000; 作为执行转发的的执行语句, 如 fastcgi 的入参转发到本地的 9000 这个端口, 而在另一侧, php-fpm 正在监听 9000 端口, 至此, nginx 与 php-fpm 进一步衔接到了一起.




