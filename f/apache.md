
### 服务器预定义变量
%{HTTP_HOST} is the host requested by the browser and
%{REQUEST_URI} is the URI requested by the browser (everything after the domain).
REQUEST_URI
The path component of the requested URI, such as "/index.html". This notably excludes the query string which is available as its own variable named QUERY_STRING.

REQUEST_FILENAME
The full local filesystem path to the file or script matching the request, if this has already been determined by the server at the time REQUEST_FILENAME is referenced. Otherwise, such as when used in virtual host context, the same value as REQUEST_URI. Depending on the value of AcceptPathInfo, the server may have only used some leading components of the REQUEST_URI to map the request to a file.
### RewriteRule Flags
short| long
...|...
L  | last 表示当前规则为最后一条规则,停止分析以后的规则重写
PT|passthrough
N | 重新从第一条规则开始运行重写过程
C  | 与下一条规则关联
OR | ornext (or next condition)
NV | novary  (no vary)

```
RewriteCond "%{REMOTE_HOST}"  "^host1"  [OR]
RewriteCond "%{REMOTE_HOST}"  "^host2"  [OR]
RewriteCond "%{REMOTE_HOST}"  "^host3"
```



如果规则匹配则正常处理,一下修饰符无效
short| long
...|...
NC | nocase 忽略大小写
QSA|qsappend query string append 追加请求字符串
NE | 不在输出转义特殊字符
# apache .htaccess
> 不推荐使用.htacess文件的四个理由：
频繁请求、多级查找.htaccess、正则不缓存、安全问题


eg:
```
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [END]
</IfModule>
```
> The above rules will rewrite PHP files to no longer show their extension, and so that index.php will just show as a naked domain (similar to the behavior normally seen in index.html). The above rule ships with WordPress.

> Note that in Apache httpd 2.2.16 and later, this entire block can be replaced with a single line using the FallbackResource directive:
```
FallbackResource /index.php
```


'novary|NV' (no vary)
If a HTTP header is used in the condition, this flag prevents this header from being added to the Vary header of the response. Using this flag might break proper caching of the response if the representation of this response varies on the value of this header. So this flag should be only used if the meaning of the Vary header is well understood.




### rewrite基本概念
CondPattern is the condition pattern, a regular expression which is applied to the current instance of the TestString. TestString is first evaluated, before being matched against CondPattern.

CondPattern is usually a perl compatible regular expression, but there is additional syntax available to perform other useful tests against the Teststring:

You can prefix the pattern string with a '!' character (exclamation mark) to negate the result of the condition, no matter what kind of CondPattern is used.

防止目录浏览

### 常用配置
#### disable directory browsing
```
Options All -Indexes
```

### strmatch
RewriteCond expr "! %{HTTP_REFERER} -strmatch '*://%{HTTP_HOST}/*'"
