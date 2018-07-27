php 默认安装路径一般为 /usr/local, 可执行文件一般放在/usr/local/bin, 编译 `php-config` 一般放在 /usr/local/lib 目录下, `.so` 文件一般也在这个目录下, 主体文件放在 `/usr/local/include/` 下,  php 配置文件位置则放在:  `/usr/local/lib/php.ini`

php 编译好后,如果需要单独安装扩展, 则基本步骤如下:

* 先进入php 源码包中测扩展目录

> cd ext/

以安装 yaml 扩展为例,首先去php 官网上推荐的下载地址下载 yaml源码,并且解压, 解压后进入解压的目录

> wget http://pecl.php.net/get/yaml-1.2.0.tgz  
> tar -zxvf yaml-1.2.0.tgz  
> cd yaml-1.2.0  

运行命令:

> phpize

注意,可能会找不到这个文件, 可以用 find 命令查找一下, 如果不在环境变量里边的话,写完成路径,如果不具有可执行的权限的话,加上可执行的权限. phpize 其实就是一个 shell 脚本,会做以下工作:

* 检查 config.m4 这个编译文件是否存在并且可读.

* 从 php 的安装头文件里边,查找当前的版本,扩展存放位置,zend扩展存放位置等信息, 并输出到标准输出中.

* 把 `"mkdep.awk scan_makefile_in.awk shtool libtool.m4"` 等构建需要的文件拷贝到当前扩展的目录的 build 目录下, 然后用新路径生成一个
名称为 aclocal.m4 的编译文件,  把模板配置文件中的安装路径用编译的 `prefix` 替换, 形成新的配置文件 `configure.in`, 这里由于我们 prefix 是默认的 `/usr/local/`, 实际上替换后还是一样的.

*  建立 install-sh 文件,  检查 `shtool` 和 `autoconf` 文件 等工作, 最终生产 configure 文件

通过配置, 生成相应的Makefile 

> sudo ./configure --with-php-config=/usr/local/bin/php-config  --with-yaml=/usr/local/yaml/

`/usr/local/bin/php-config` 是一个辅助安装扩展的 shell 脚本,该工具会查找 php 有哪些 SERVER_API 类型和对应存放配置文件的路径,方便在后续编译时候,将配置文件拷贝到相应的目录中去

`--with-yaml` 是配置需要的额外的依赖基础库安装位置, 注意由于我们 安装 yaml 的时候, 是放置到 `/usr/local/yaml` 下, 而配置文件默认是在 `/usr/local` 的相应位置去查找,因此需要专门指定依赖的库的位置. 编译的选项可通过 `./configure -h` 命令查看. php 的很多扩展,都是针对基础库实现的访问接口, 因此很多扩展都有所依赖的基础库. 

配置完后后, 执行编译

> sudo make

如果发生问题, 则根据提示安装相应的依赖库,并手动解决依赖关系.

安装

> make install

> 每一次 安装扩展, 除了存放 动态链接库外, 有些扩展还会存放 header file  
> [nanxiaoning@yn-vm-204-72 gd 08:51:45]$ sudo make install  
> Installing shared extensions:     /usr/local/lib/php/extensions/no-debug-non-zts-20131226/  
> 许多扩展没有对应的 header files  
> Installing header files:           /usr/local/include/php/  

修改配置文件,在配制文件中添加相应的扩展.

参考文件:
https://phperzh.com/articles/5419



中途可能遇到的问题及排查和解决方案:

* 安装后, 重新启动了 php-fpm, 但是依然无法找到扩展.

可能原因: 在配置的时, php-config 文件没找对,你可能存在多个这种文件,一般为多次编译 PHP, 并且前后编译的指定安装路径不同.

如, 第一次默认安装扩展存放位置为:

> /usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/

而第二次默认存放扩展的位置为:

>  /usr/local/lib/php/extensions/no-debug-non-zts-20131226/

, 而在第二次配置时,使用了第一次的配置文件, 可执行:

> sudo cp /usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/yaml.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/yaml.so

拷贝的相应的位置即可.后续编写扩展 使用正确的 php-config 文件,就不会遇到这个问题了.


* 配置时候, 提示找不到 config.m4 文件

> Cannot find config.m4. 
Make sure that you run '/usr/local/bin/phpize' in the top level source directory of the module

解决方式: 将 config0.m4 重命名为 config.m4

* 提示问题:
PHP Warning:  PHP Startup: Invalid library (maybe not a PHP library) 'bz2.so' in Unknown on line 0

原因: 扩展编译的过程有问题,试着重新编译, 以扩展  bz2 为例,

尝试过程:

```
> cd /home/nanxiaoning/Downloads/php-5.6/ext/bz2    
> sudo make clean

参考:

https://stackoverflow.com/questions/33347108/php-warning-php-startup-invalid-library-maybe-not-a-php-library-in-unknown-o

* PHP Warning: Module 'modulename' already loaded in Unknown on line 0

原因: 同一个扩展, 写了两次

参考:

http://www.somacon.com/p520.php

* imap 扩展安装比较曲折, 但总体思想,手动编译依赖,并解决兼容和依赖问题

安装 imap 时候遇到的问题:

问题:
configure: error: utf8_mime2text() has new signature, but U8T_CANONICAL is missing. This should not happen. Check config.log for additional information.

原因:libc有问题:
解决过程:

> wget ftp://195.220.108.108/linux/centos/6.9/os/x86_64/Packages/libc-client-2007e-11.el6.x86_64.rpm
> wget ftp://rpmfind.net/linux/centos/6.9/os/x86_64/Packages/libc-client-devel-2007e-11.el6.x86_64.rpm
> sudo rpm -is libc-client-2007e-11.el6.x86_64.rpm
> sudo rpm -is libc-client-devel-2007e-11.el6.x86_64.rpm
> sudo ./configure --with-php-config=/usr/local/bin/php-config --with-openssl --with-libdir=lib64 --with-kerberos --with-imap-ssl

参考:

https://stackoverflow.com/questions/34617253/centos-7-cannot-find-imap-library-libc-client-a-when-compiling-php-7

https://www.rpmfind.net/linux/rpm2html/search.php?query=libc-client

https://forum.directadmin.com/archive/index.php/t-49707.html


gd 库安装问题:

问题: 依赖  libpng,

> wget https://sourceforge.net/projects/libpng/files/libpng16/1.6.34/libpng-1.6.34.tar.gz/download

依赖 webp,

webp

参考:

https://github.com/libgd/libgd/issues/254




* debug

\Symfony\Component\VarDumper\VarDumper::dump($this->customProviderCreators[$name]);die();


just index by collect_time
$points = array_column($points, null, 'collect_time');


laravel 不同项目不能部署到同一台机器上
laravel env 

To clear things up; this is a known issue. It's just not documented.

You must run ´php artisan config:cache` in both Laravel projects to generate a cached configuration. This is a requirement for Apache on Windows (and many other setups).

Dotenv will set process-wide environment variables, and only if they don't already exists. This means that the first Laravel app is executed, sets the first environment variables, then it calls the same webserver (in your case) where the second Laravel app sees that the environment variables are already set, and wont set the correct ones.


php artisan bigscreenStatisticsSnapshot:date '2018-08-17'



Carbon 使用样例
```
$params['work_time_start'] = Carbon::parse($date)->startOfDay()->format('Y-m-d H:i:s');
$params['work_time_end'] = Carbon::parse($date)->addDay(1)->startOfDay()->format('Y-m-d H:i:s');
```



