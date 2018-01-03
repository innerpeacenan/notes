

SOCK_STREAM 流式套接字 面向tcp协议
SOCK_DGRAM 数字报套接字
SOCK_RAW  原始套接字 ,直接面向网络层

tcp:可靠,面向连接,字节流传输,点对点
udp:不可靠,无连接,数据报传输


### 套接字
> 源IP地址和目的IP地址以及源端口号和目的端口号,连接使用的协议的组合称为套接字。其用于标识客户端请求的服务器和服务。

> 它是网络通信过程中端点的抽象表示，包含进行网络通信必需的五种信息：连接使用的协议，本地主机的IP地址，本地进程的协议端口，远地主机的IP地址，远地进程的协议端口。

> 套接字，是支持TCP/IP的网络通信的基本操作单元，可以看做是不同主机之间的进程进行双向通信的端点，简单的说就是通信的两方的一种约定，用套接字中的相关函数来完成通信过程。
[Status Code Definitions](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)

```
301，302 都是HTTP状态的编码，都代表着某个URL发生了转移，不同之处在于：
301 redirect: 301 代表永久性转移(Moved Permanently)。
302 redirect: 302 代表暂时性转移(Moved Temporarily  ) The requested resource resides temporarily under a different URI
401 错误
403 Forbidden status
408 Request timeout
502 Bad Gateway (站点不存在时候发生)
503 Service Unavailable
504 Gateway Time-out 网关超时看
```


### request code
#### 400 Bad Request
```
The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications.
```

#### 401 Unauthorized 未授权
The request requires user authentication. The response MUST include a WWW-Authenticate header field (section 14.47) containing a challenge applicable to the requested resource. The client MAY repeat the request with a suitable Authorization header field (section 14.8). If the request already included Authorization credentials, then the 401 response indicates that authorization has been refused for those credentials. If the 401 response contains the same challenge as the prior response, and the user agent has already attempted authentication at least once, then the user SHOULD be presented the entity that was given in the response, since that entity might include relevant diagnostic information. HTTP access authentication is explained in "HTTP Authentication: Basic and Digest Access Authentication"

您的Web服务器认为，客户端（例如您的浏览器或我们的 CheckUpDown 机器人）发送的 HTTP 数据流是正确的，但进入网址 (URL) 资源 ， 需要用户身份验证 ， 而相关信息 1 ）尚未被提供, 或 2 ）已提供但没有通过授权测试。这就是通常所知的“ HTTP 基本验证 ”。 需客户端提供的验证请求在 HTTP 协议中被定义为 WWW – 验证标头字段 (WWW-Authenticate header field) 。

一般来说该错误消息表明您首先需要登录（输入有效的用户名和密码）。 如果你刚刚输入这些信息，立刻就看到一个 401 错误，就意味着，无论出于何种原因您的用户名和密码其中之一或两者都无效（输入有误，用户名暂时停用，等）

###  403 Forbidden status
> in response to a request from a client for a web page, or it may indicate that the server can be reached and process the request but refuses to take any further action. Status code 403 responses are the result of the web server being configured to deny access to the requested resource by the client.

#### 404 Not Found


#### 408 错误 – 请求超时 (Request timeout)
您的 Web 服务器认为，在 1 ）建立客户端（如您的浏览器或我们的 CheckUpDown 机器人） 和服务器之间 IP 连接（套解字 - socket ）， 和 2 ）通过该套解字收到数据，之间的时间间隔太长， 所以服务器放弃该连接。 套接字连接实际上已失效 - 您的 Web 服务器已就对该特定套接字连接发出 ' 超时 ' 信号。客户端的请求必须及时重复。
[HTTP 408 错误 – 请求超时 (Request timeout)](http://blog.csdn.net/xanxng/article/details/12833463)


### 500 Internal Server Error

### 502 Bad Gateway
The server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.

### 504 Gateway Timeout
The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server specified by the URI
(e.g. HTTP, FTP, LDAP) or some other auxiliary server (e.g. DNS) it needed to access in attempting to complete the request.


### 邮件协议
[邮件协议](http://blog.csdn.net/alalalalalqp/article/details/8578681)

SMTP称为简单Mail传输协议（Simple Mail Transfer Protocal）

POP协议(管理个人邮箱，从服务器下载邮件)
POP的全称是 PostOffice Protocol ，即邮局协议，用于电子邮件的接收，它使用TCP的110端口，现在常用的是第三版 ，所以简称为 POP3。POP3仍采用Client/Server工作模式，。当客户机需要服务时，客户端的软件（OutlookExpress或FoxMail）将 与POP3服务器建立TCP连接，此后要经过POP3协议的三种工作状态，首先是认证过程，确认客户机提供的用户名和密码，在认证通过后便转入处理状态， 在此状态下用户可
　收取自己的邮件或做邮件的删除，在完成响应的操作后客户机便发出quit命令，此后便进入更新状态，将做删除标记的邮件从服务器端删除掉。到此为止整个POP过程完成。

　IMAP协议    （管理邮件，可以阅读摘要等信息后下载邮件）
　　 IMAP是Internet Message Access Protocol 的缩写，顾名思义， 主要提供的是通过Internet获取信息的一种协议。 IMAP象POP那样提供了方便的邮件下载服务， 让用户能进行 离线阅读，但IMAP能完成的却远远不只这些。IMAP提供的摘要浏览功能可以让你在阅读完所有的邮件到达时间、主题、发件人、大小等信息后才作出是否下 载的决定。

读者不禁要问，POP3也是接收邮件的协议，现在不是用得很好么，为何还要用IMAP协议呢？
POP3协议的不足
的确，POP作为Internet上邮件的第一个离线协议标准，允许用户从服务器上把邮件下载到本地主机上，同时删除保存在邮件服务器上的邮件，从而使用户不必长时间地与邮件服务器连接，很大程度上减少了服务器和网络的整体开销。
但 POP3有其天生的缺陷，即当用户接收电子邮件时，所有的信件都从服务器上清除并下载到客户机。在整个收信过程中，用户无法知道邮件的具体信息，只有照单 全收入硬盘后，才能慢慢浏览和删除。这使用户几乎没有对邮件接收的控制决定权。一旦碰上邮箱被轰炸，或有比较大的邮件，用户不能通过分析邮件的内容及发信 人地址来决定是否下载或删除，从而造成系统资源的浪费。而IMAP协议不但可以克服POP3的缺陷，而且还提供了更强大的功能。

### tcp协议笔记

每个TCP段都包含源端和目的端的端口号，用于寻找发端和收端应用进程。这两个值加上IP首部中的源端IP地址和目的端IP地址唯一确定一个TCP连接。一个IP地址和一个端口号也称为一个插口socket.

网络层（ IP）提供点到点的服务，而运输层（ T C P和U D P）提供端到端的服务。

### ip协议
IP协议是用于将多个包交换网络连接起来的，它在源地址和目的地址之间传送一种称之为数据包的东西，它还提供对数据大小的重新组装功能，以适应不同网络对包大小的要求。
IP的责任就是把数据从源传送到目的地。它不负责保证传送可靠性，流控制，包顺序和其它对于主机到主机协议来说很普通的服务。

IP不提供可靠的传输服务，它不提供端到端的或（路由）结点到（路由）结点的确认，对数据没有差错控制，它只使用报头的校验码，它不提供重发和流量控制。如果出错可以通过ICMP报告，ICMP在IP模块中实现。

### ARP 协议
地址解析协议，即ARP（Address Resolution Protocol）

### 端口号

端口号，不是说一个真正存在的实体，或者说在网卡上有个端口啥的。其实端口号就是一个简单的数字标识，用于区分不同的应用程序，有点类似于应用程序的ID，因为网络数据到达了一个主机上边，怎么知道这个数据是给哪个应用程序的呢，这时候端口号就起作用了。前面已经指出过，TCP和UDP采用16bit的端口号来识别应用程序。那么这些端口号是如何选择的呢？服务器一般都是通过知名端口号来识别的。例如，对于每个TCP/IP实现来说，FTP服务器的TCP端口号都是21，每个Telnet服务器的TCP端口号都是23，每个TFTP(简单文件传送)服务器的UDP端口号都是69。

### 一次http请求的粗略描述

同一个HTML页面，从服务器端发送到客户端浏览器，首先是根据HTTP协议，组装字符串，组装成一次请求回复，字符串包括header，body等。然后这个字符串会被转成二进制数据，然后给TCP层去分解，然后TCP层交给IP层，拆解成多个IP数据包。这时候这些包是无序的，不一定哪个包先到达。最终这些包再组成文件，如img,css,js文件。这就是为什么图片渲染出来的顺序不一样。

### 伪静态

伪静态就是浏览器和人识别起来是一个静态文件，实际上该文件是不存在，是动态生成的

### SAPI
SAPI:Server Application Programming Interface 服务器端应用编程端口。它就是PHP与其它应用交互的接口，PHP脚本要执行有很多种方式，通过Web服务器，或者直接在命令行下，也可以嵌入在其他程序中。
SAPI提供了一个和外部通信的接口，常见的SAPI有：cgi 、fast-cgi、cli、isapi、apache 模块的 DLL


地址:
inet_addr()
gethostbyname()

端口号:
服务名到端口号
getservbyname()

协议号:
协议名称映射到协议号
getprotobyname()

TCP客户端软件流程:
1. 确定服务器的ip地址和端口号
2. 创建套接字
3. 分配本地端点地址(IP地址+端口号)
4. 连接服务器
5. 遵循应用层协议通信
6. 关闭/释放连接


UDP客户端软件流程:
1. 确定服务器IP地址与端口号
2. 创建套接字
3. 分配本地端点地址(IP地址+端口号)
4. 指定服务器端点地址,构造UDP 数据报
5, 循序应用层协议进行通信(UDP客户端主动发消息)
6. 关闭/释放连接



在HTTP 中状态码含义：
302（临时移动）
301（永久移动）
400（错误请求）
401（未授权）
403（禁止）
404（未找到）
500（服务器内部错误）
504（网关超时）


ip addr

### request
GET /renovation/web/ffzbsns/supplier-money-summary/test.jsp HTTP/1.1
Host: erp.ty.com
Connection: keep-alive
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36
#用户端报文媒体类型
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4
为Cookie服务的首部字段
Cookie: _csrf=b04f03bb4f03e586ec9b7444d2f107fddf725633b1864776f4773c13c7446cc3a%3A2%3A%7Bi%3A0%3Bs%3A5%3A%22_csrf%22%3Bi%3A1%3Bs%3A32%3A%220RAJjsZiRFFbR7dTupX1f53qY68GFo-M%22%3B%7D; LEAD_CODE=TY; PHPSESSID=295j03h2qausenj4fim4nfqhi1


POST /renovation/web/ffzpub/pack/get-pack.jsp?depotid=19 HTTP/1.1
Host: erp.ty.com
X-Requested-With: XMLHttpRequest
Accept: */*
Accept-Encodeing: gzip,deflate
Cache-Control: no-cache
User-Agent: fiddle
Origin: http://erp.ty.com
Referer: http://erp.ty.com/renovation/web/ffzpub/pack/depot.jsp
Cookie:XDEBUG_SESSION=PHPSTORM;PHPSESSIONID=PHPSESSID=295j03h2qausenj4fim4nfqhi1;_csrf=b04f03bb4f03e586ec9b7444d2f107fddf725633b1864776f4773c13c7446cc3a%3A2%3A%7Bi%3A0%3Bs%3A5%3A%22_csrf%22%3Bi%3A1%3Bs%3A32%3A%220RAJjsZiRFFbR7dTupX1f53qY68GFo-M%22%3B%7D;LEAD_CODE=TY;


Ajax:
POST /renovation/web/ffzpub/pack/get-pack.jsp?depotid=19 HTTP/1.1
Host: erp.ty.com
Connection: keep-alive
X-Requested-with: XMLHttpRequest
Content-Length: 0
Pragma: no-cache
Cache-Control: no-cache
Accept: */*
Origin: http://erp.ty.com
User-Agent: fiddle
Referer: http://erp.ty.com/renovation/web/ffzpub/pack/depot.jsp
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4
Cookie: XDEBUG_SESSION=PHPSTORM;_csrf=b04f03bb4f03e586ec9b7444d2f107fddf725633b1864776f4773c13c7446cc3a%3A2%3A%7Bi%3A0%3Bs%3A5%3A%22_csrf%22%3Bi%3A1%3Bs%3A32%3A%220RAJjsZiRFFbR7dTupX1f53qY68GFo-M%22%3B%7D; LEAD_CODE=TY; PHPSESSID=295j03h2qausenj4fim4nfqhi1

curl 待发请求：
curl 'http://erp.ty.com/renovation/web/ffzpub/pack/print-pick-list.jsp' -H 'Pragma: no-cache' -H 'Origin: http://erp.ty.com' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: */*' -H 'Cache-Control: no-cache' -H 'X-Requested-With: XMLHttpRequest' -H 'Cookie: XDEBUG_SESSION=PHPSTORM;_csrf=b04f03bb4f03e586ec9b7444d2f107fddf725633b1864776f4773c13c7446cc3a%3A2%3A%7Bi%3A0%3Bs%3A5%3A%22_csrf%22%3Bi%3A1%3Bs%3A32%3A%220RAJjsZiRFFbR7dTupX1f53qY68GFo-M%22%3B%7D; LEAD_CODE=TY; PHPSESSID=295j03h2qausenj4fim4nfqhi1' -H 'Connection: keep-alive' -H 'Referer: http://erp.ty.com/FzErpPub/Seppack/index.jsp' --data 'id=13352%2C13351' --compressed


### response
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
Connection: keep-alive
Date: Thu, 04 May 2017 10:46:27 GMT
Server: nginx
Cache-Control: no-store, no-cache, must-revalidate
Transfer-Encoding: chunked
Vary: Accept-Encoding
X-Powered-By: PHP/7.0.7
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Pragma: no-cache
Content-Encoding: gzip

{"status":0,"msg":"\u6ca1\u6709\u53ef\u5206\u914d\u7684\u5206\u5305\u4efb\u52a1","data":"","dialog":""}


客户端：$_SERVER["REMOTE_ADDR"];或者getenv('REMOTE_ADDR')
ip2long进行转换
服务器端：gethostbyname('www.baidu.com')


URL不仅仅只是个地址那么简单，组件包括：方案、用户名、密码、主机名或IP、端口号、路径、参数、查询、片段。当然其中有些事可以省略的，有些在特定情况（协议）下是有默认值的。

Cross-Site Request Forgery (CSRF)


(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])) 匹配ip地址


跨站脚本攻击(Cross Site Scripting)


/**
 * Returns whether this is an AJAX (XMLHttpRequest) request.
 *
 * Note that jQuery doesn't set the header in case of cross domain
 * requests: https://stackoverflow.com/questions/8163703/cross-domain-ajax-doesnt-send-x-requested-with-header
 *
 * @return boolean whether this is an AJAX (XMLHttpRequest) request.
 */
public function getIsAjax()
{
	return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest';
}

------------------------------------------------------------------------------------------------------------------------
The server also sends Access-Control-Allow-Headers with a value of "X-PINGOTHER, Content-Type", confirming that these are permitted headers to be used with the actual request. Like Access-Control-Allow-Methods, Access-Control-Allow-Headers is a comma separated list of acceptable headers.


the server responds with a Access-Control-Allow-Origin: * which means that the resource can be accessed by any domain in a cross-site manner. If the resource owners at http://bar.other wished to restrict access to the resource to be only from http://foo.example, they would send back:

Access-Control-Allow-Origin: http://foo.example




### session cookie
`session.gc_maxlifetime`
session 相关函数
`session_set_cookie_params`
> Set cookie parameters defined in the php.ini file. The effect of this function only lasts for the duration of the script. Thus, you need to call session_set_cookie_params() for every request and before session_start() is called.



### apache 重写示例

```
RewriteRule ^product/p([0-9]*)\.html$    product.php?id=$1 [L]
```
[L] last


打印客户端IP:`echo $_SERVER[‘REMOTE_ADDR’]`; 或者: `getenv('REMOTE_ADDR')`;


ping 命令结果的ttl的含义;
指定数据报被路由器丢弃之前允许通过的网段数量。
TTL 是由发送主机设置的，以防止数据包不断在 IP 互联网络上永不终止地循环。转发 IP 数据包时，要求路由器至少将 TTL 减小 1。


[tcpdump listen mysql port](https://gist.github.com/gstark/10268260)


### ip table

```
iptables-save > /opt/iptables.backup
iptables-restore < /opt/iptables.backup

清空服务器上所有的规则。
iptables -F

设置 INPUT 方向所有的请求都拒绝。如果是线上业务请勿直接操作，会导致业务直接中断。
iptables -P INPUT DROP
```


### SSH(Secure Shell)
一种专为远程登录会话和其他网络服务提供安全性的协议。

通俗的说法就是：一台机器（client）需要访问另一台机器（server），如何实现免密码访问呢？那么就可以使用SSH协议啦。

[ssh 阿里出品的教程](https://yq.aliyun.com/articles/109824)
生成密钥:
ssh_keygen

例：从client访问server，client端用户是root，server端用户是francis,那么可以先在client端/root/.ssh目录下使用密钥生成命令

```
ssh_keygen
```

，然后将公钥拷贝到server端对应用户名

```
/home/francis/.ssh/authorized_keys
```

下，（使用服务器端哪个用户名登录就将公钥拷贝到该用户名下的/.ssh/authorized_keys内）。

这样操作完成之后，就可以在client端使用ssh username@ip命令登录到server端。

```
ssh francis@192.168.222.128
```

或者通过命令行将公钥拷贝的要访问的机器上
ssh-copy-id -i ~/.ssh/id_rsa.pub  nanxiaoning@192.168.203.11

Digital subscriber line (DSL; originally digital subscriber loop) is a family of technologies that are used to transmit digital data over telephone lines.


worker MPM
install PHP as an Apache module, as a worker MPM (multi-processing model).


array('Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8'));


### 查看网关

netstat -r




之前一直存在拼写错误的认识
`uri Uniform Resource Identifier (URI)`

tcp 三次握手介绍:

[tcp 三次握手](https://www.nowcoder.com/questionTerminal/2d5a65326a4c43ffa87ca7bf5ad1a632)


differece for uri and url


> So until something changes, URI is best used when you’re referring to a resource just by its name or some other fragment. And when you’re giving both the name of a resource and the method of accessing it (like a full URL), it’s best to call that a URL.


CSRF 攻击预防
[Cross-Origin Resource Sharing (CORS)](https://www.html5rocks.com/en/tutorials/cors/)
[详细阅读 维基百科上的Cross-Site Request Forgery (CSRF) (https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)_Prevention_Cheat_Sheet#Checking_the_Origin_Header)


