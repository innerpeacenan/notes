[xdebug]
zend_extension = "d:/wamp/bin/php/php5.4.12/ext/php_xdebug-2.3.3-5.4-vc9-x86_64.dll"

xdebug 自动开启调试, 不需要在请求中传递 IDE key
xdebug.remote_autostart=1

auto-remote-xdebug
https://www.theaveragedev.com/xdebug-and-php-fpm-configuration/






#zend_extension = "d:/wamp/bin/php/php5.4.12/zend_ext/php_xdebug-2.2.3-5.4-vc9-x86_64.dll"
;加载xdebug模块。这里不能用extension=php_xdebug.dll的方式加载，必须要以zend的方式加载，否则安装上后，phpinfo是显示不出xdebug这个项的。

xdebug.remote_handler = dbgp  一种协议，2.1以后只能是这个协议
xdebug.remote_enable=1             开启远程调试
xdebug.remote_host=127.0.0.1  调试的客户端，默认localhost，可以是ip也可以是域名
#xdebug.remote_connect_back = 1
;xdebug.remote_connect_back启用时xdebug.remote_host就无效，表示接收任意ip的调试请求，也就是可以同时多人调试，主要用于远程调试，由xdebug自己去获取ip，这行开启可以不用任何插件，ps自己就可以调试；  如果此值无效，则只能是xdebug.remote_host指定的ip才可以调试
有一种想法，在同事的电脑上装有xdebug，然后在我的电脑上调试他的代码，有空测试一下

xdebug.remote_port=9000
xdebug.remote_autostart=1
;简单的讲就是这个值为0时，只能由某个特殊的get或post参数来触发调试，比如url里面一个ss什么id的参数，为1时则可以随意触发
xdebug.idekey=phpstorm
;设置默认的调用xdebug的程序，如果不设置，就会去环境变量中找

一些不常用的
xdebug.profiler_enable = 0
xdebug.profiler_enable_trigger = 0
;这两个配合使用，大概意思是收集运行日志，很占空间的（wamp的php，php设置里面最上面关于xdebug的地方可以修改）

xdebug.profiler_output_name = cachegrind.out.%t.%p
xdebug.profiler_output_dir = "d:/wamp/tmp"
;日志输出目录和名字

xdebug.auto_trace=off
;自动打开“监测函数调用过程”的功模。该功能可以在你指定的目录中将函数调用的监测信息以文件的形式输出。此配置项的默认值为off。
xdebug.collect_params=off
;打开收集“函数参数”的功能。将函数调用的参数值列入函数过程调用的监测信息中。此配置项的默认值为off。
xdebug.collect_return=off
;打开收集“函数返回值”的功能。将函数的返回值列入函数过程调用的监测信息中。此配置项的默认值为off。
xdebug.trace_output_dir=”c:\Temp\xdebug”
;设定函数调用监测信息的输出文件的路径。

xdebug.collect_params=0
;将调用过程中传递的参数写入文件，是写入文件，不是内存，会产生很大的日志文件，并且会很卡
