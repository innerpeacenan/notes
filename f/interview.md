check is valid ip ,最优解



一面（男）：
1.简单写几个自己工作当中php常用的数组和字符串函数，围绕你写的函数会问一些关联问题。
```
array_pop — Pop the element off the end of array
array_push — Push one or more elements onto the end of array
array_shift() - Shift an element off the beginning of array
array_unshift() - Prepend one or more elements to the beginning of an array
array_keys — Return all the keys or a subset of the keys of an array
array_values — Return all the values of an array
array_key_exists — Checks if the given key or index exists in the array
array_merge — Merge one or more arrays
array array_filter ( array $array [, callable $callback [, int $flag = 0 ]] )
array_map — Applies the callback to the elements of the given arrays
str_replace — Replace all occurrences of the search string with the replacement string
trim ltrim rtrim
substr — Return part of a string
strcmp — Binary safe string comparison
implode — Join array elements with a string
join — Alias of implode()
strtolower — Make a string lowercase
strtoupper() - Make a string uppercase
ucfirst() - Make a string's first character uppercase
ucwords() - Uppercase the first character of each word in a string
preg_grep — Return array entries that match the pattern
```
2.有没有用到过单例设计模式，简单些一下。
简单的设计模式



3.linux的nginx.conf配置文件大致结构，通常搭建一个网站需要修改哪些地方，


linux查看文件命令，搜索某个文件中某个字符串并输出对应的行数命令。



二面（男）：
1.写一个函数判断一个字符串是否是ip，是返回true，不是返回false。
正则匹配
2.写一个函数判断一个字符串是否是回文字符串，是返回true，不是返回false。
“回文串”是一个正读和反读都一样的字符串，比如“level”或者“noon”等等就是回文串。
算法考察


本文实例讲述了PHP判断一个字符串是否是回文字符串的方法。分享给大家供大家参考。具体实现方法如下：
<?php
 function ishuiwen($str){
  $len=strlen($str);
  $l=1;
  $k=intval($len/2)+1;
   for($j=0;$j<$k;$j++){
    if (substr($str,$j,1)!=substr($str,$len-$j-1,1))
     {
  $l=0;
  break;
   }
 }
 if ($l==1)
 {
 return 1;
 }
 else
 {
 return -1;
  }
 }
 $str=12321;
 echo ishuiwen($str);
?>


3.有一张user表，字段大致有id，name，sex，createtime......等字段，写一个sql取出表中前50个人，name不能有重复，写一个sql统计一下sex男女人数。
4.Linux一些常用命令，搜索某个文件中某个字符串命令，检查httpd是否启动的命令，检查3306端口是否开启的命令。
```
ls,pwd,cd,mv,cp,mkdir,ps,kill,chmod,chgrp.chown,cat,vi,vim,more,less,grep,|,locate,find,history等
“netstat -an | grep 3306”即可查看是否开启
可以调用/etc/init.d/httpd status查看，或者ps aux | grep httpd，或者pidof httpd去获取进程号
bash: /etc/init.d/httpd: No such file or directory
```
5.如果让你设计一个发短信的服务器，你有什么思路。


7.$_POST，$HTTP_RAW_POST_DATA 和 php://input 的区别？
答案：
$_POST：
是获取表单POST过来数据，MIME类型是“application/x-www-form-urlencoded”。可参考《什么是 MIME TYPE？》
意思就是字段名和值都编码了，每个 key-value 对使用 ‘&’ 字符分隔开，key 和 value 使用 ‘=’ 分开，其他特殊字符都会被使用 urlencode 方式进行编码。
$HTTP_RAW_POST_DATA：
可以获取原始的POST数据，但需要在 php.ini 中设置开启，并且不支持 enctype="multipart/form-data"方式传递的数据
php://input：
可以获取原始的 POST 数据，并且比$HTTP_RAW_POST_DATA更少消耗内存，也不支持"multipart/form-data"，
可以使用 file_get_contents() 函数去获取它的内容

9.请介绍Session的原理
答案：
因为HTTP是无状态的，所以一次请求完成后客户端和服务端就不再有任何关系了，谁也不认识谁。
但由于一些需要（如保持登录状态等），必须让服务端和客户端保持联系，session ID就成了这种联系的媒介了。
当用户第一次访问站点时，PHP会用session_start()函数为用户创建一个session ID，这就是针对这个用户的唯一标识，
每一个访问的用户都会得到一个自己独有的session ID，这个session ID会存放在响应头里的cookie中，之后发送给客户端。
这样客户端就会拥有一个该站点给他的session ID。
当用户第二次访问该站点时，浏览器会带着本地存放的cookie(里面存有上次得到的session ID)随着请求一起发送到服务器，
服务端接到请求后会检测是否有session ID，如果有就会找到响应的session文件，把其中的信息读取出来；如果没有就跟第一次一样再创建个新的。


13.session共享问题解决方案
答案：
a. 客户端Cookie保存，以cookie加密的方式保存在客户端，每次session信息被写在客户端，然后经浏览器再次提交到服务器。
b. 服务器间Session同步，使用主-从服务器的架构，当用户在主服务器上登录后，通过脚本或者守护进程的方式，将session信息传递到各个从服务器中
c. 使用集群统一管理Session，当应用系统需要session信息的时候直接到session群集服务器上读取，目前大多都是使用Memcache来对Session进行存储。
d. 把Session持久化到数据库，目前采用这种方案时所使用的数据库一般为mysql。



14.测试php性能性能的工具，和找出瓶颈的方法。
答案：
XHProf（windows安装方法参照这里）是一个分层PHP性能分析工具。它报告函数级别的请求次数和各种指标，包
括阻塞时间，CPU时间和内存使用情况。
它有一个简单的HTML的用户界面，基于浏览器的性能分析用户界面能更容易查看，也能绘制调用关系图。参数值
查看。


15.介绍一下常见的SSO(单点登陆)的原理。
答案：SSO是一种统一认证和授权机制，通过一个应用中的安全验证后，再访问其他应用中的受保护资源时，不再需要重新登录验证。
解决了用户只需要登录一次就可以访问所有相互信任的应用系统，而不用重复登录。
统一的认证系统是SSO的前提之一。认证系统的主要功能是将用户的登录信息和用户信息库相比较，对用户进行登录认证；
认证成功后，认证系统应该生成统一的认证标志（ticket），返还给用户。另外，认证系统还应该对ticket进行效验，判断其有效性。


16.禁掉cookie的session使用方案
答案：
a. 通过 url 传值，把session id附加到url上（缺点：整个站点中不能有纯静态页面，因为纯静态页面session id 将无法继续传到下一页面）
b. 通过隐藏表单，把session id 放到表单的隐藏文本框中同表单一块提交过去（缺点：不适用<a>标签这种直接跳转的非表单的情况）
c. 直接配置php.ini文件,将php.ini文件里的session.use_trans_sid= 0设为1（好像在win上不支持）
d. 用文件、数据库等形式保存Session ID，在跨页过程中手动调用


19.HTTP协议header头域包含哪些
答案：
（1）通用头域
　　通用头域包含请求和响应消息都支持的头域，通用头域包含Cache-Control、Connection、Date、Pragma、Transfer-Encoding、Upgrade、Via。对通用头域的扩展要求通讯双方都支持此扩展，如果存在不支持的通用头域，一般将会作为实体头域处理。下面简单介绍几个在UPnP消息中使用的通用头域。
（2）Cache-Control头域
（3）Date头域
（4）Pragma头域
（5）请求消息
（6）Host头域
（7）Referer头域
（8）Range头域
（9）User-Agent头域
（10）Location响应头
（11）Server响应头
（12）实体
（13）Content-Type实体头
（14）Content-Range实体头
（15）Last-modified实体头









邮箱验证:
[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+




























