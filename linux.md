linux 文件查找命令
## 常用快捷键
### 打开终端
By default in Ubuntu and Linux Mint the terminal shortcut key is mapped to Ctrl+Alt+T.

## 命令
### 历史命令查找 history

```
  history | grep ""
  R 为shift键和r同时按下
> 命令行中输入<ctr>+R，然后输入过往命令的key word，你就很容易找到以前执行过的命令了
```
[history 中非常实用和有趣的功能](https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps)
shell 历史命令追加模式
shopt -s histappend

> To do this correctly, we need to do a bit of a hack. We need to append to the history file immediately with history -a, clear the current history in our session with history -c, and then read the history file that we've appended to, back into our session history with history -r.

> We can also execute commands relative to our current position. We can do this by using the !-n syntax, where "n" is replaced by the number of commands ago we want to recall.

> To re-execute the previous command, bash provides a shortcut that we can use instead of !-1. The shortcut is !!, which will substitute the most recent command and execute:

> We can execute the last "ssh" command by typing something like:

> !ssh


> Another trick that you can try is a variation on the !! last history command. You can do a quick search and replace by typing:

> ^original^replacement^

> tar xzvf long-project-name.tar.gz


> cd !!:$:r:r



### find 命令
* 查找某一路径下所有存在某一字符串的文件

```
-name 按照文件名称查找
-and 条件与 -or 条件或
-perm 按照文件权限查找
-user    username             #按文件属主来查找
-group groupname            #按组来查找
-type    b/d/c/p/l/f         #查是块设备、目录、字符设备、管道、符号链接、普通文件
-size n[cwbkMG] File uses n units of space. The following suffixes can be used:

`b’ for 512-byte blocks (this is the default if no suffix is used)
`c’ for bytes
`w’ for two-byte words
`k’ for Kilobytes (units of 1024 bytes)
`M’ for Megabytes (units of 1048576 bytes)
`G’ for Gigabytes (units of 1073741824 bytes)
-mtime n File’s data was last modified n*24 hours ago.
mmin  以分钟为单位
例子:
// 找出所有以非md结尾的文件
find . -regextype sed -regex ".*\.[^m][^d]"
find  [PATH] -name "2013-12-*.txt"
find  . -type d -and -name "we*"
find  ./ -type f -and -name 'Mock*'
find -type f -name "*.{sh,ksh,csh}" > output.txt;
find . -type f -exec ls -l {} \;

在/ l o g s目录中查找更改时间在5日以前的文件并删除它们：
find logs -type f -mtime +5 -exec   -ok   rm {} \;

查询当天修改过的文件
find   ./   -mtime   -1   -type f   -exec   ls -l   {} \;

#看是否存在cnscn用户
find    /etc -name "passwd*"    -exec grep    "cnscn"    {}    \;

find    . -name "PubCustom*"    |    xargs    echo     ""

在/home下查60分钟前改动过的文件
find /home -mmin     +60
```

### grep 命令

```
grep [OPTIONS] PATTERN [FILE...]
```

查看 shell 脚本中, php_invoke 的位置

```
grep -rn   --include="*.phpt" 'php_invoke'  .
```

[linux 下查看文件个数的方法](http://blog.csdn.net/sunshine_okey/article/details/7351601)

* 查找指定路径下某个字符串存在的情况
```
grep stock-history -r controllers/* models/* modules/*
grep -rn   --include="*.phpt" 'php_invoke'  .
grep  -P  '客户.信息' -rn  --include="*.php" current/ | more
```

* 查看文件夹下的文件个数(当前目录的文件数)
```
 ls -alF | grep "^-" | wc -l
```

* 查看mysql 3306端口是否启用
```
所有tcp协议的链接
netstat -t
所有链接
netstat -anp | grep 3306
```

* 历史命令查找的两种方法：
```
// -i ignore case
history | grep -i "xxx"
// -n line number
grep -in cgi_sapi_module cgi/*
```
### ls

ls -lt sort by modified time

t modified time

### 特殊符号
* ~/ 表示当前用户的默认目录，对root用户，为"/root",对ffz用户，为"/home/ffz";

### 常用目录
#### ubantu 16.04 开机的环境设置文件： .bashrc

#### /etc/profile

This file is meant for setting command aliases and functions used by bash shell users. Just like the /etc/profile is the system wide version of .bash_profile . The /etc/bashrc for Red Hat and /etc/bash.bashrc in Ubuntu is the system wide version of .bashrc
* eclise 在新版ubuntu中装eclipse，很多人会遇到eclipse打开之后没有菜单栏，
其实就是缺一个环境变量UBUNTU_MENUPROXY.
在/etc/profile 里面新建这个变量并且把值写成0

```
export UBUNTU_MENUPROXY=0
```



### linux 下部署要注意几个问题：
（1）大小写问题，linux的路径是区分大小写的
（2）\ ,linux路径中不要用\
（3）linux很多文件夹涉及权限问题，需要对各部分功能做更全面的了解

### firefox
* firefox
> You can use the program dbus-launch to get around this issue. So before you start Firefox type export $(dbus-launch). Now you can start Firefox. However there might another error message appear. If yes you can work around with export NSS_USE_SHARED_DB=ENABLED. Now Firefox should start without error messages or warnings.

> Can can put that alltogether in a shell script:
```
#!/bin/sh
export $(dbus-launch)
export NSS_USE_SHARED_DB=ENABLED
firefox
```




###  source 命令
```
新产生一个shell然后再执行scripts的方法是在scripts文件开头加入以下语句
　　#!/bin/sh
　　一般的script文件(.sh)即是这种用法。这种方法先启用新的sub-shell(新的子进程),然后在其下执行命令。
　　另外一种方法就是上面说过的source命令，不再产生新的shell，而在当前shell下执行一切命令。
　　source:
　　source命令即点(.)命令。
```

### exec 命令
```
exec:
　　在bash下输入man exec，找到exec命令解释处，可以看到有”No new process is created.”这样的解释，这就是说exec命
令不产生新的子进程。那么exec与source的区别是什么呢?
　　exec命令在执行时会把当前的shell process关闭，然后换到后面的命令继续执行。
```

### declare
命令行模式下的快捷键：
```
-i integer
-a array
-r read only
-f 函数
//这样将声明一个变量作为脚本的环境变量而被导出。
-x var=$value
```

### 终端标签切换 switch terminal tab
```
Alt+1:切换到标签页1

Alt+2:切换到标签页2

Alt+3:切换到标签页3
```

> Linux – cp: omitting directory 复制文件失败:

注意，如果执行时出现”cp: omitting directory”的提示信息，但使用mv则可以成功剪切粘贴，是由于该目录下含有子目录，这个时候需要使用 cp -r 参数来递归拷贝这些及其子文件夹下的文件。

//model层打印执行的错误
```
var_dump($info->getErrors());
```

* man 命令  根据关键词搜索手册
```
man -k
eg:
man -k printf
man -k "^printf"
```

* gunzip
```
gunzip是个使用广泛的解压缩程序，它用于解开被gzip压缩过的文件，这些压缩文件预设最后的扩展名为“.gz”。事实上，gunzip就是gzip的硬连接，因此不论是压缩或解压缩，都可通过gzip指令单独完成。
```

### dd
convert and copy a file

count=N
      copy only N input blocks
```
# 知乎上提问
dd count=1 2>/dev/null
```


### hostname
hostname - show or set the system's host name


### ab apache压力测试工具（非内建）
```
# 50 为并发量
# 1000 为总请求数目
ab -c 500 -n 1000 http://erp.ty.com/renovation/web/ffzpub/goods-associate/add.jsp
```


> 查看cpu内核数
```
grep 'model name' /proc/cpuinfo |  w -l
```

### linux ctime(attributes change time) mtime(modified time) atime(access time)
[Difference between mtime, ctime and atime](http://www.linux-faqs.info/general/difference-between-mtime-ctime-and-atime)



* 单双引号的区别

同php

* read 指令
```
IFS=":"
read -a myvar
1:2:3:4:5

echo ${myvar[*]}
1 2 3 4 5
echo ${myvar[@]}
1 2 3 4 5
echo ${#myvar[@]}
5
```



* man 7 signal
```
Signal     Value     Action   Comment
──────────────────────────────────────────────────────────────────────
SIGINT        2       Term    Interrupt from keyboard
SIGTERM      15       Term    Termination signal
```



### 多行文本处理
```
$ cat my-friends Show address file
# SORTKEY: Schloß, Hans Jürgen
Hans Jürgen Schloß
Unter den Linden 78
D-10117 Berlin
Germany
# SORTKEY: Jones, Adrian
Adrian Jones
371 Montgomery Park Road
Henley-on-Thames RG9 4AJ
UK
# SORTKEY: Brown, Kim
Kim Brown
1841 S Main Street
Westchester, NY 10502
```

```
# Pipe in address file
cat my-friends |
# Convert addresses to single lines
awk -v RS="" '{ gsub("\n", "^Z"); print }' |
# Sort address bundles, ignoring case
sort -f |
awk -v ORS="\n\n" '{ gsub("^Z", "\n"); print }' | Restore line structure
grep -v '# SORTKEY' Remove markup lines
````

```
nginx -t  测试nginx服务器
nginx -s sreload 启动nginx

echo "Test Apache configure file..."
/etc/init.d/httpd configtest

 echo "Restart Apache..."
/etc/init.d/httpd restart
```

### File descriptor
[File descriptor](https://en.wikipedia.org/wiki/File_descriptor)
In Unix and related computer operating systems, a file descriptor (FD, less frequently fildes) is an abstract indicator (handle) used to access a file or other input/output resource, such as a pipe or network socket. File descriptors form part of the POSIX application programming interface. A file descriptor is a non-negative integer, generally represented in the C programming language as the type int (negative values being reserved to indicate "no value" or an error condition).
```
Integer | value | Name | <unistd.h> symbolic constant[1]	<stdio.h> file stream[2]
---|---|---
0 | Standard input | STDIN_FILENO | stdin
1 | Standard output | STDOUT_FILENO	| stdout
2 | Standard error | STDERR_FILENO | stderr
```

Macro: int SIGIO
This signal is sent when a file descriptor is ready to perform input or output.
> On most operating systems, terminals and sockets are the only kinds of files that can generate SIGIO; other kinds, including ordinary files, never generate SIGIO even if you ask them to.
> On GNU systems SIGIO will always be generated properly if you successfully set asynchronous mode with fcntl.



### tcp端口流量监控
@todo 目前存在较严重的问题是,tcpdump 监听到的数据中文无法显示,这是一个挺严重的问题


not a built in command
```
tcpdump -i eth0 -s 0 -l -w - dst port 3306 | strings | perl -e '
while(<>) { chomp; next if /^[^ ]+[ ]*$/;
if(/^(SELECT|UPDATE|DELETE|INSERT|SET|COMMIT|ROLLBACK|CREATE|DROP|ALTER|CALL)/i) {
if (defined $q) { print "$q\n"; }
$q=$_;
} else {
$_ =~ s/^[ \t]+//; $q.=" $_";
}
}'
```

### ln -s
当前目录是/local，而我经常要访问/usr/local/linux/work

那么我就可以使用在local下建立一个文件linkwork，


ln -s absolutePathOfSourceFile  linkFile
然后`sudo ln -s /usr/local/linux/work  /local/linkwork `即建立两者之间的链接。




https://unix.stackexchange.com/questions/22713/executable-symbolic-link-results-in-command-not-found

检查是否是硬链接

```
ls -hli /usr/local/lib/libpng16.so.16.34.0   /usr/local/lib/libpng16.so
```

--------------------------------------------------------------------------------

管道:
限制管道的大小。实际上，管道是一个固定大小的缓冲区。在Linux中，该缓冲区的大小为1页，即4K字节，使得它的大小不像文件那样不加检验地增长。

linux终端快捷键
teminal 通过help菜单,按<C>F 搜索关键字"keyboard shortcut",查看快捷键设置
找到open a new window 的快捷键,我这里设置的为 <S><C>N


进程
```
nice nice - run a program with modified scheduling priority
renice
uptime
ps process status command
ps -efl
ps aux
who show who is login
whoami
// root
```





typedef


awk.md
[官方帮助手册](https://www.gnu.org/software/gawk/manual/gawk.html)
### last
st:
when I'm back from the function the head of the list is not null as it should be
```
awk 'pattern + {action}' {filenames}
#注意事项 pattern 和 action 整体在一个单引号语句中，不论存在多少模式和多少action
eg:
cat /etc/passwd | awk -F ':'  'BEGIN {print "name,shell"}  {print $1","$7;} END {print "blue,/bin/nosh"}'
```

* 搜索/etc/passwd有root关键字的所有行
```
#awk -F: '/root/' /etc/passwd
root:x:0:0:root:/root:/bin/bash
```

awk内置变量
```
ARGC               命令行参数个数
ARGV               命令行参数排列
ENVIRON            支持队列中系统环境变量的使用
FILENAME           awk浏览的文件名
FNR                浏览文件的记录数
FS                 设置输入域分隔符，等价于命令行 -F选项
NF                 浏览记录的域的个数
NR                 已读的记录数
OFS                输出域分隔符
ORS                输出记录分隔符
RS                 控制记录分隔符
```
##预定义变量不能放到双引号内，否则会被当做普通文本

```
awk  -F ':'  '{print "filename:"FILENAME ",linenumber:" NR ",columns:" NF ",linecontent:"$0}' /etc/passwd
#printf 格式与c语言类似
awk  -F ':'  '{printf("filename:%10s,linenumber:%s,columns:%s,linecontent:%s\n",FILENAME,NR,NF,$0)}' /etc/passwd
```

* 统计某个文件夹下的文件占用大小（不包括子目录占用大小）
```
ls -l |awk 'BEGIN {size=0;} {size=size+$5;} END{print "[end]size is ", size}'
[end]size is  8657198


如果以M为单位显示:

ls -l |awk 'BEGIN {size=0;} {size=size+$5;} END{print "[end]size is ", size/1024/1024,"M"}'
[end]size is  8.25889 M
```

* 条件语句 和C语言一样
```
ls -l |awk 'BEGIN {size=0;print "[start]size is ", size} {if($5!=4096){size=size+$5;}} END{print "[end]size is ", size/1024/1024,"M"}'
```
* 循环语句 和c语言一样
```
awk -F ':' 'BEGIN {count=0;} {name[count] = $1;count++;}; END{for (i = 0; i < NR; i++) print i, name[i]}' /etc/passwd
```

我们是怎么做到的
（借助工具） Google Hangout
持续的在线交流（自己开发的实时聊天系统）
邮件（非实时交流、状态和决定的更新、团队周报）
（项目、文档管理） Trello + Google Docs


bash
###quote
There is no way to embed a single quote within a single-quoted string. Even
backslash is not special within single quotes.


sed:
–e 'editing command'
Use editing command on the input data. –e must be used when there are multiple commands.
–f script-file
Read editing commands from script-file. This is useful when there are
many commands to execute.
–n
Suppress the normal printing of each final modified line. Instead,lines must
be printed explicitly with the p command.

BRE

```
The first step is to enclose a subexpression in \( and \).
```
backreference
一";"作为sed命令的分隔符
sed 's;\(/home\)/tolstoy/;\1/lt/;'
删除一到四行
sed -e 1,4d

cut:
Major options
–c list
Cut based on characters. list is a comma-separated list of character numbers
or ranges, such as 1,3,5-12,42.
–d delim
Use delim as the delimiter with the –f option. The default delimiter is the tab
character.
–f list
Cut based on fields. list is a comma-separated list of field numbers or ranges




ps -efl
ps aux


cut -d : -f 1,5 /etc/passwd





$ cat sales Show sales file
# sales data Explanatory comments
# salesperson amount
joe 100
jane 200
herman 150
chris 300


$ cat quotas Show quotas file
# quotas
# salesperson quota
joe 50
jane 75
herman 80
chris 95

有什么问题可以通过邮箱与我交流 liexusong@qq.com
如memcached，redis
memcached是比较简单的，看些早期的版本
c语言最好还是看书，c语言之父那本

sed "/^#/d" data/sale.txt | sort > data/temp_sale.txt

sed "/^#/d"
echo -e

需要进一步了解join命令

readarray 命令
# Newlines are stripped
$ readarray -t foo <<EOF
foo
bar
baz
EOF

$ printf '%s' "${foo[@]}"
foobarbaz

tail /var/log/syslog | grep "error"

cjava上安装了mailutils
apt install mailutils

Linux – cp: omitting directory 复制文件失败:
注意，如果执行时出现”cp: omitting directory”的提示信息，但使用mv则可以成功剪切粘贴，是由于该目录下含有子目录，这个时候需要使用 cp -r 参数来递归拷贝这些及其子文件夹下的文件。

apt-cache是linux下的一个apt软件包管理工具，它可查询apt的二进制软件包缓存文件。APT包管理的大多数信息查询功能都可以由apt-cache命令实现,通过apt-cache命令配合不同的子命令和参数的使用,可以实现查找,显示软件包信息及包依赖关系等功能.

1> apt-cache show package_name

显示指定软件包的信息，包括版本号，安装状态和包依赖关系等.

2> apt-cache search package_name
搜索软件包，可以按关键字查找软件包,通常用于查询的关键字会使用软件包的名字或软件包的一部分.
apt-cache search all | grep mysql

3> apt-cache showpkg package_name

显示软件包的依赖关系信息.

4> apt-cache policy package_name

显示软件包的安装状态和版本信息.

5> apt-cache depends package_name

显示指定软件包所依赖的软件包。当用户需要了解某个软件包依赖于其他哪些包时,可以使用apt-cache depends来查询包依赖关系.

压缩与解压缩:
（1）tar.gz 格式的文件解决，常用参数
tar zxpf
tar -zxf

（2）zip格式压缩包解压指令
unzip

.gz 文件解压
gzip -d request-2017-11-04.log.gz

（3）xz
xz压缩文件方法或命令
xz -z 要压缩的文件
如果要保留被压缩的文件加上参数 -k ，如果要设置压缩率加入参数 -0 到 -9调节压缩率。如果不设置，默认压缩等级是6.
xz解压文件方法或命令
xz -d 要解压的文件
同样使用 -k 参数来保留被解压缩的文件。

### 权限管理
查看一个路径的用户权限

```
namei -om /home/ffz
f: /home/ffz
drwxr-xr-x root root /
drwxr-xr-x root root home
drwxrwxrwx ffz  ffz  ffz
root@:/home/ffz$man namei
```

其他用户的当前权限

作为选择，我们多数用三位八进制数字的形式来表示权限，第一位指定属主的权限，第二位指定组权限，第三位指定其他用户的权限，每位通过4(读)、2(写)、1(执行)三种数值的和来确定权限。如6(4+2)代表有读写权，7(4+2+1)有读、写和执行的权限。

$ chmod u+x file                　　　   给file的属主增加执行权限
$ chmod 751 file                　　　   给file的属主分配读、写、执行(7)的权限，给file的所在组分配读、执行(5)的权限，给其他用户分配执行(1)的权限
$ chmod u=rwx,g=rx,o=x file      上例的另一种形式
$ chmod =r file                 　　　　为所有用户分配读权限
$ chmod 444 file              　　　　 同上例
$ chmod a-wx,a+r   file   　　 　   同上例
$ chmod -R u+r directory       　   递归地给directory目录下所有文件和子目录的属主分配读的权限
$ chmod 4755                          　　设置用ID，给属主分配读、写和执行权限，给组和其他用户分配读、执行的权限。

env  //可以查看环境变量

groupadd groupname

UID 用户身份证明(User Identification)的缩写
GID为GroupId，即组ID，用来标识用户组的唯一标识符

虚拟机初次密码修改:
http://jingyan.baidu.com/article/d45ad148ba9eb169552b8097.html

初次密码修改

新建文件的默认模式为 644


---------------------------------------------------------------------------------------------------------------------------------------------
cron
The software utility Cron is a time-based job scheduler in Unix-like computer operating systems.

crontab

To define the time you can provide concrete values for minute (m), hour (h), day of month (dom), month (mon), and day of week (dow) or use '*' in these fields (for 'any')

# m h  dom mon dow   command

# 31 13 * 6 *  ls

[crontab linux 做定时任务](https://www.computerhope.com/unix/ucrontab.htm)

### du
linux 下查看目录使用空间的大小
[du -sh file_path](https://unix.stackexchange.com/questions/185764/how-do-i-get-the-size-of-a-directory-on-the-command-line)

```
du -sh /home/wwwroot/www.note.git/
``

iostat 非内建命令

iostat -d -k 1 10         #查看TPS和吞吐量信息(磁盘读写速度单位为KB)

iostat -d -m 2            #查看TPS和吞吐量信息(磁盘读写速度单位为MB)

iostat -d -x -k 1 10      #查看设备使用率（%util）、响应时间（await） iostat -c 1 10 #查看cpu状态



free 命令：

[free 命令存在的问题和内容](http://hi.baidu.com/savagert/item/55d4111061e88f8d88a9563c)


[端口监听](https://serverfault.com/questions/309052/check-if-port-is-open-or-closed-on-a-linux-server)

netstat -an | grep PORTNUMBER | grep -i listen

查看 mysql 端口有没有处于监听状态

list open file
lsof -i:3306

id

print real and effective user and group IDs
```
uid=0(root) gid=0(root) groups=0(root)
```

kill process by name  `killall ngix`

查看 mysqld 服务有没有起来
ps -ef | grep mysqld

f show full process
e equivalent to option e

查看 nginx 的状态
```
/etc/init.d/nginx status
```


lsof -i 用以显示符合条件的进程情况
lsof -i[46] [protocol][@hostname|hostaddr][:service|port]
  46 --> IPv4 or IPv6
  protocol --> TCP or UDP
  hostname --> Internet host name
  hostaddr --> IPv4地址
  service --> /etc/service中的 service name (可以不止一个)
  port --> 端口号 (可以不止一个)

显示系统版本信息:

uname -a
Linux yn-vm-204-72.xhj.com 2.6.32-573.el6.x86_64 #1 SMP Thu Jul 23 15:44:03 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

cat /etc/issue

cat /etc/redhat-release


查看自动拨号上网功能:
sudo pppoeconf

PCI device
Peripheral Component Interconnect (PCI), as its name implies is a standard that describes how to connect the peripheral components of a system together in a structured and controlled way.

列出 pci 设备的状况,包括网卡(Ethernet controller 部分)
lspci -v

ls
ls -lhS sort by size, in human readable format


history 文件存放位置:

```
tail -f $HISTFILE or tail -f ~/.bash_history
```
### 查询网络
ifconfig:
ifconfig | grep cast


### ssh 远程登录相关问题

```
ssh-keygen -t rsa -C "ip@username"
把公钥拷贝框远程服务器上
ssh-copy-id -i ~/.ssh/id_rsa.pub  root@192.168.0.3
```

troube-shooting:
问题描述:

iptables 已经卸载了, 端口已经放开了, 没有sshd 配置

发原因:s现该机器根本没有安装ssh

### scp 远程拷贝文件

假设我现在在 192.168.203.72 这台服务器上面,

```
scp local.php  ffz@172.17.53.108:/tmp
```

```
/etc/ssh/sshd
apt-get install ssh
```

允许以root身份登录

https://askubuntu.com/questions/469143/how-to-enable-ssh-root-access-on-ubuntu-14-04

### scp not built in
scp <source> <destination>
To copy a file from B to A while logged into B:

scp /path/to/file username@a:/path/to/destination
To copy a file from B to A while logged into A:

scp username@b:/path/to/file /path/to/destination

显示到桌面底部
gsettings set com.canonical.Unity.Launcher launcher-position Bottom


重定向

[What does 2>&1 in this command mean?](https://unix.stackexchange.com/questions/99263/what-does-21-in-this-command-mean)



The first character is ESC, which has to be entered by pressing CTRL+V and then ESC on the Linux console or in xterm, konsole, kvt and so on.


bash shell 颜色对照表, 示例:  `echo -e "\033[1;31m%s\033[0m"`  \033 打开和关闭 [ 为样式起始编号 [0m 彻底关闭
    Black      0;30       Dark Gray    1;30
    Red        0;31       Bold Red     1;31
    Green      0;32       Bold Green   1;32
    Yellow     0;33       Bold Yellow  1;33
    Blue       0;34       Bold Blue    1;34
    Purple     0;35       Bold Purple  1;35
    Cyan       0;36       Bold Cyan    1;36
    Light Gray 0;37       White        1;37



[静态ip 查询](https://www.swiftstack.com/docs/install/configure_networking.html)


通过 ssh 克隆存在的一个问题

Cloning into 'shortNotes'...
The authenticity of host 'github.com (192.30.255.113)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,192.30.255.113' (RSA) to the list of known hosts.
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
build error


expect 代码示例

```
#!/usr/bin/expect
spawn ssh -t -p6120 nanxiaoning@blj.xunhuji.me
expect "Password:"
send "909312359@qq.com\r"
expect "Select group:"
send "2\r"
expect "hi,yunniaoer"
send  "cd beeper_tms_openapi\r"
interact
```

telnet 正常链接的表现

```
root@:/etc/network$telnet 192.168.20.81 80
Trying 192.168.20.81...
Connected to 192.168.20.81.
Escape character is '^]'

```


## 删除以 '-' 开头的文件


[删除含有特殊字符的文件](https://www.linux.com/blog/linux-shell-tip-remove-files-names-contains-spaces-and-special-characters-such)

```

Tip #3: Try a ./ at the beginning of the filename

The syntax is as follows to delete a file called '-file':

$ rm -v ./-file
removed `./-file'


apt-get 学习笔记

/etc/apt/sources.list.d 这里存放 source.list 的配置信息


监听当前网速:

sar -n DEV 2 2

关闭防火墙
sudo ufw disable
Firewall stopped and disabled on system startup

[允许防火墙](https://askubuntu.com/questions/724792/how-to-make-sure-that-firewall-is-off)
sudo ufw enable


### groups

groups  ffz

[See Which Groups Your Linux User Belongs To](https://www.howtogeek.com/howto/ubuntu/see-which-groups-your-linux-user-belongs-to/)


### zip

zip --password 1 dir.zip dir



### network 配置文件

dns 永久配置文件
/run/resolvconf/resolv.conf


### etc/shells

```
/bin/sh
/bin/dash
/bin/bash
/bin/rbash
/usr/bin/screen
```


72 机器是 centos, 这一点需要注意
sudo yum install man

useradd -r 创建系统用户

禁止用户登录 shell 

useradd -r -g mysql -s /bin/false mysql


### du 查看文件大小

```
du  | awk '{split($1,a,"[^0-9]");print a[1], $2;}' | uniq | sort -nr | head -n 20
```

### tar 命令

/etc 为需要打包的目录
```
[root@linux ~]# tar -cvf /tmp/etc.tar /etc  <==仅打包，不压缩！

[root@linux ~]# tar -czvf /tmp/etc.tar.gz /etc  <==打包后，以 gzip 压缩

[root@linux ~]# tar -cjvf /tmp/etc.tar.bz2 /etc  <==打包后，以 bzip2 压缩
```


linux PATH 变量在 /etc/environment 目录下存放


edit 检查端口连通性

nc -zv 127.0.0.1 9001

### linux

```
ls -alhF index

```




### iptables

SELINUX=disabled

http://www.revsys.com/writings/quicktips/turn-off-selinux.html

https://www.liquidweb.com/kb/how-to-stop-and-disable-firewalld-on-centos-7/


sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT


### alias 命令

```
alias allip='ifconfig -a | perl -nle'\''/(\d+\.\d+\.\d+\.\d+)/ && print '\'''
alias cmount='mount | column -t'
alias cputop10='ps auxw|head -1;ps auxw|sort -rn -k3|head -10'
alias dush='du -hsx * | sort -rh | head -10'
alias getip='curl ip.cn'
alias grep='grep --color=auto'
alias jiangsi='ps -A -o stat,ppid,pid,cmd | grep -e '\''^[Zz]'\'''
alias killjiangsi='ps -A -o stat,ppid,pid,cmd | grep -e '\''^[Zz]'\'' | awk '\''{print }'\'' | xargs kill -9'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lport='lport() { lsof -i:"$1"; };lport'
alias ls='ls --color=auto'
alias meminfo='free -m -l -t'
alias memtop10='ps auxw|head -1;ps auxw|sort -rn -k4|head -10 '
alias osage='tune2fs -l /dev/mapper/vg_yn_vm-LogVol01 | grep -i created'
alias rm='/bin/rmtrash.sh'
alias system='dstat -ta --top-bio'
alias tailf='tailf() { tail -f "$1"; };tailf'
alias tailff='tail -f  | ts '\''%H:%M:%.S'\'' '
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
```


### awk 日志分析

grep 'http://192.168.0.99:10799/waybill/v1/order/insert' base/base.20171113.log | grep -oP 'source_name=(.*?&)' | awk -F'=' '{print $2}' | awk -F'&' '{print $1}' | sort | uniq



