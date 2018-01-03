apache 安装目录: /usr/local/apache

bin 目录下的工具介绍:

ab apache 压力测试工具

apachectl is a front end to the Apache HyperText Transfer Protocol (HTTP) server. It is designed to help the administrator control the functioning of the Apache httpd daemon.



mod_status is an Apache module which helps to monitor web server load and current httpd connections with an HTML interface which can be accessible via a web browser.


envvars shell 文件, 设置 LD_LIBRARY_PATH


APR
The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.


ServerRoot:
The top of the directory tree under which the server's configuration, error, and log files are kept.


显示核心工作模块, 不用配置

httpd -l


[apache 各模块介绍]( https://httpd.apache.org/docs/2.4/mod/mod_authn_file.html)

一些重要模块:

mpm_common

A collection of directives that are implemented by more than one multi-processing module (MPM)

worker
Multi-Processing Module implementing a hybrid multi-threaded multi-process web server

prefork
Implements a non-threaded, pre-forking web server

event
A variant of the worker MPM with the goal of consuming threads only for connections with active processing.


mod_authz_groupfile
Group authorization using plaintext files

mod_authz_host
Group authorizations based on host (name or IP address)

mod_access_compat
Group authorizations based on host (name or IP address)


mod_reqtimeout
Set timeout and minimum data rate for receiving requests


mod_deflate
Compress content before it is delivered to the client

mod_mime
Associates the requested filename's extensions with the file's behavior (handlers and filters) and content (mime-type, language, character set and encoding)

mod_proxy_* 这类模块

可用于做负载均衡


环境所使用的 mpm_prefork 方式

LoadModule mpm_prefork_module modules/mod_mpm_prefork.so


url 重写模块

LoadModule rewrite_module modules/mod_rewrite.so

php 内嵌模块

LoadModule php7_module        modules/libphp7.so


apache 配置文件所声明的用户和组名

User www
Group www



[指令介绍:](https://httpd.apache.org/docs/2.4/mod/core.html#includeoptional)


> This directive allows inclusion of other configuration files from within the server configuration files. It works identically to the Include directive, with the exception that if wildcards do not match any file or directory, the IncludeOptional directive will be silently ignored instead of causing an error.

各个扩展的配置放置在: /etc/php/7.1/mods-available
网络接口的配置文件放置在 /etc/php/7.1/apache2
cli 配置文件放置在  /etc/php/7.1/cli




