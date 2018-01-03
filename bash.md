## 帮助手册
man RTFM
marks

## linux command
```
whoami
```

## shell编程注意事项：
(1)一定要有头文件
`#!/bin/bash`
(2)使用bashdb进行单步调试时，一定要让脚本先运行到这一句，可以通过n （表示next line）来运行到该行，再从终端输入交互的参数信息，才可以进一步调试，
否则，程序还没有运行到这一步，必然提示输入的参数不是有效的命令

## basic concept

### bash pre-defined varibels 预定义的参数含义
```
$10 不能获取第十个参数，获取第十个参数需要${10}。当n>=10时，需要使用${n}来获取参数。
$#	传递到脚本的参数个数
$*	以一个单字符串显示所有向脚本传递的参数
$$	脚本运行的当前进程ID号
$!	后台运行的最后一个进程的ID号
$@	与$*相同，但是使用时加引号，并在引号中返回每个参数。
$-	显示Shell使用的当前选项，与set命令功能相同。
$?	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
```

```
what is mean by :- this symbol in Unix shell scripting
${runq:-$SLOTS}
This is a simple way to provide a default value using an expansion.
```

### &符号的含义
If you use an ampersand (&) instead of a semicolon,the shell runs the preceding command in the background,which simply means that it doesn’t wait for the command to finish before continuing to the next command.


### stty - change and print terminal line settings
		-g, --save
              print all current settings in a stty-readable form


```
stty -g
# result:
# 4500:5:bf:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
```


Local settings:

[-]icanon
              enable special characters: erase, kill, werase, rprnt

min N  with -icanon, set N characters minimum for a completed read

time N with -icanon, set read timeout of N tenths of a second



### bash set
set -o options
eg:
```
set -o nounset
# treat unset varible as an error
# this is the same as set -u
```
set -u
> Treat unset variables and parameters other than the special parameters ‘@’ or ‘*’ as an error when performing. parameter expansion. An error message will be written to the standard error, and a non-interactive shell will exit.

set -e
Exit immediately if a command exits with a non-zero status.


查看 set -e 的含义的具体方法为:

注意, -e 中的 - 在grep 命令中需要转义

```
help set | grep '\-e'
```

### /dev/null
The null device is typically used for disposing of unwanted output streams of a process, or as a convenient empty file for input streams. This is usually done by redirection.


### array 数组相关操作
```
my_array=(A B "C" D)
echo "the elements in myarray are:${my_array[*]}"
echo "the elements in myarray are:${my_array[@]}"
echo "数组元素个数为: ${#my_array[*]}"
echo "数组元素个数为: ${#my_array[@]}"
```


> 关联数组
```
mab_WRITABLE=(REPLACE:7 INSERT:6 UPDATE:6 CREATE:6 ALTER:5 MODIFY:6 \
		replace:7 insert:6 update:6 create:6 alter:6 modify:6)
```

### 字符串

shell脚本对字符串切片
```
${mypath:5:5}    #偏移5个字符，取5个字符
```



### $(command)
> Usage of the $ like ${HOME} gives the value of HOME. Usage of the $ like $(echo foo) means run whatever is inside the parentheses in a subshell and return that as the value.
[what is $(command) supposed to return](http://stackoverflow.com/questions/17984958/what-does-it-mean-in-shell-when-we-put-a-command-inside-dollar-sign-and-parenthe)


## commands

### shift (an important shell bult in command)
Say you have a command that takes 10 arguments, and N is 4, then $4 becomes $1, $5 becomes $2 and so on.
[The shift built-in](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_07.html)

```
#multicat count filename(s)
multicat() {
        local count=$1
        shift
        for((i=0;i < $count; i++)) {
                cat "$@"
        }
}

multicat 3 abc          # outputs the "abc" file 3 times
```

### xargs
```
### 文件内容多次输出
seq 2 | xargs -Inone cat file
//文件批量该后缀名(理解该命令的使用场景再用)
ls  *.md | mv {} {}.bak
```


### unlink

### w
w - Show who is logged on and what they are doing
```
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
ffz      tty7     :0               08:47    8:05m  9:39   0.46s /sbin/upstart --user
```



### 系统负载查看 uptime w top
如何评估性能需求中合理的Load Average？
一般来说，Load Average是与机器内核数有关的。以一个单核的机器为例，load=0.5表示CPU还有一半的资源可以处理其他的线程请求，load=1表示CPU所有的资源都在处理请求，没有剩余的资源可以利用了，而load=2则表示CPU已经超负荷运作，另外还有一倍的线程正在等待处理。所以，对于单核机器来说，理想状态下，Load Average要小于1。同理，对于双核处理器来说，Load Average要小于2。结论是：多核处理器中，你的Load Average不应该高于处理器核心的总数量。

### netstat -anp (查看端口最频繁的命令)

常见参数
```
-a (all)显示所有选项，默认不显示LISTEN相关
-t (tcp)仅显示tcp相关选项
-u (udp)仅显示udp相关选项
-n 拒绝显示别名，能显示数字的全部转化成数字。
-l 仅列出有在 Listen (监听) 的服務状态

-p 显示建立相关链接的程序名(Show the PID and name of the program to which each socket belongs.)
-r 显示路由信息，路由表
-e 显示扩展信息，例如uid等
-s 按各个协议进行统计
-c 每隔一个固定时间，执行该netstat命令。
```

* 常用的网络服务端口

```
80：www
22：shh
21:tcp
25:mail
443:https
3306:mysql
```

(udp协议)[http://www.cnblogs.com/ggjucheng/archive/2012/01/08/2316661.html]

所有占用的端口好查看
[netstat -an](https://www.cyberciti.biz/faq/how-do-i-find-out-what-ports-are-listeningopen-on-my-linuxfreebsd-server/)


### groups - search for which groups a use in]
```
groups [usrname]
```


### lsof

To display the list of open ports, enter:

```
lsof : list open files。在 Linux 中一切皆文件，你启动的一个进程、监听的一个端口，都以文件的形式存在于系统中，端口被哪个进程占用的，文件被哪个进程打开的，通过 lsof 命令都可以查的到。甚至，对于一些被误删除的文件，通过lsof 也可以进行恢复；
```

### echo print
```
> echo, print 不同系统,表现不一样
```

### declare
* read and deal as arrays  by a while loop (数组声明和赋值)
```
declare infilename=""                           # input filename
declare -a part                                 # make part an array
IFS=':'                                         # set input field separator

while read -a part ; do                         # read and split into fields
  # use ${part[i]}
done < "$infilename"
```
### join
```
join [-ti12] file1 file2
选项与参数：
-t  ：join 默认以空格符分隔数据，并且比对第一个字段的数据，
      如果两个文件相同，则将两笔数据联成一行，且第一个字段放在第一个！
-i  ：忽略大小写的差异；
-1  ：这个是数字的 1 ，代表『第一个文件要用那个字段来分析』的意思；
-2  ：代表『第二个文件要用那个字段来分析』的意思。
join -t ':' -1 4 /etc/passwd -2 3 /etc/group
```


### sort
```
sort命令是帮我们依据不同的数据类型进行排序，其语法及常用参数格式：
　　sort [-bcfMnrtk][源文件][-o 输出文件]
补充说明：sort可针对文本文件的内容，以行为单位来排序。

参数：
  -b   忽略每行前面开始出的空格字符。
  -c   检查文件是否已经按照顺序排序。
  -f   排序时，忽略大小写字母。
  -M   将前面3个字母依照月份的缩写进行排序。
  -n   依照数值的大小排序。
  -o<输出文件>   将排序后的结果存入指定的文件。
  -r   以相反的顺序来排序。
  -t<分隔字符>   指定排序时所用的栏位分隔字符。
  -k  选择以哪个区间进行排序。
```

```
# 按照数字顺序排序
sort -t: -k3nr /etc/passwd Sort by descending UID
sort -t: -k4n -k3n /etc/passwd Sort by GID and UID
```

[linux之sort用法](http://www.cnblogs.com/dong008259/archive/2011/12/08/2281214.html)


### uniq
```
sort latin-numbers | uniq -c Count unique sorted records
sort latin-numbers | uniq -d Show only duplicate records
sort latin-numbers | uniq -u Show only nonduplicate records
```
### wc 统计
```
wc -c count bytes
wc -l count line
wc -w count words
```

### cut
eg:
```
cut -d : -f 1,5 /etc/passwd
```

### tail
```
# Watch the growth of the system message log
tail -n 25 -f /var/log/messages
```

### mktemp
```
tmpfile=$(mktemp) || { echo "$0: creation of temporary file failed!"; exit 1; }
# remove tmpfile
rm --force $tmpfile
#-----------------------------------------------------------------------
#  cleanup temporary file in case of a keyboard interrupt (SIGINT)
#  or a termination signal (SIGTERM)
#-----------------------------------------------------------------------
function cleanup_temp
{
  [ -e $tmpfile ] && rm --force $tmpfile
  exit 0
}
```
#### difference between mktemp and touch
Ok actually it is written clearly in man pages.

> mktemp - create a temporary file or directory.

> Create a temporary file or directory, safely, and print its name.

It create a file or directory safely means no other user can access it, that's why its permission is 600

> touch - change file timestamps


It simply change the timestamps of a file if already created and create a file if does not exist. But file permission is still 644 by default.

 * 新创建的文件的默认权限是644

For more detail check following man pages:

[http://linux.die.net/man/1/mktemp][1]

[http://linux.die.net/man/1/touch][2]


  [1]: http://linux.die.net/man/1/mktemp
  [2]: http://linux.die.net/man/1/touch

### cat - concatenate files and print on the standard output
cat主要有三大功能：
1.一次显示整个文件。$ cat filename
2.从键盘创建一个文件。$ cat > filename
   只能创建新文件,不能编辑已有文件.
3.将几个文件合并为一个文件： $cat file1 file2 > file

[linux下cat命令详解](http://www.cnblogs.com/perfy/archive/2012/07/23/2605550.html)

```
# 创建新文件，并向其中写入内容(<<EOF 同php,以<<开头表示字符串,后边可接任意字符，其他形式无效)
cat >create_file_by_cat.php<<EOF
test
helloword
me
EOF
```

```
for i in {1..2}; do
  cat file
done

```


### date timestamp 日期
```
timestamp=$(date +"%Y%m%d-%H%M%S")
```


### watch
```
# 这里是单引号，而不是`
watch -n 1 'ps aux | grep httpd'
```


### id
id - print real and effective user and group IDs

-u, --user
              print only the effective user ID


```
id
#uid=0(root) gid=0(root) groups=0(root)

id -u
0
# the id of user "root" is 0
```



### test
     -s FILE
              FILE exists and has a size greater than zero

eg:
```
# 注意事项： pwd 必须作先执行才能比较
[ `pwd` == /usr/local/nginx/conf/vhost ]
```

##### difference between -eq and == in bash scripting
[difference between -eq and == in bash scripting](http://stackoverflow.com/questions/20449543/bash-equality-operators-eq#comment30553051_20449556)



### chmod
赋予文件所有可执行权限
```
chmod u+x file.sh
# vhost 权限设置
echo "set permissions of Virtual Host directory......"
chmod -R 755 ${vhostdir}
chown -R www:www ${vhostdir}
```



## process
### pgrep (进程正则匹配查看)

### jobs (进程监听)
> an alternate way of listing your own processes


### trap
eg:
```
synopsis:
trap  action or fuction    signal or signal list
trap  cleanup_temp         SIGHUP SIGINT SIGPIPE SIGTERM
```
常用的signal
Name | Value | Default | Event|
---  |  ---  |  ---   |  --- |
|SIGHUP |1   | Exit   | Hangup (see termio(7I))
SIGINT  |2   | Exit   | Interrupt (see termio(7I))
SIGQUIT |3   | Core   | Quit (see termio(7I))
SIGABRT |6   | Core   | Abort
SIGFPE  |8   | Core   |Arithmetic Exception
SIGPIPE |13  | Exit   |Broken Pipe
SIGCHLD | -  |  -    | -

> A child process is the result of a fork()-exec() call. The child gets a parent pid of the process that executed the fork() call. This is the context of the SIGCHLD signal, the parent pid receives the SIGCHLD signal.

### wait

### kill (man kill)
触发特定signal
options
```
Specify  the  signal to be sent.
-<signal>
       -s <signal>
       --signal <signal>
              Specify  the  signal to be sent.  The signal can be specified by
              using name or number.  The behavior of signals is  explained  in
              signal(7) manual page.
```


### pkill
> Probably the easiest way of killing a running job is by selecting it trought the process name as in the following example using pkill command as
pkill -f test.py


### sleep  fg bg
[Jobs and Processes](http://stackoverflow.com/documentation/bash/398/jobs-and-processes#t=201703041456109675429)
[程序后台运行及唤醒](http://blog.csdn.net/foryouslgme/article/details/52699608)
```
sleep 10 &
# The sleep process runs in the background with process id (pid) 20024 and job number 1.
# In order to reference the process, you can use either the pid or the job number.
# If you use the job number, you must prefix it with %.
kill %1

# to bring the Process to the foreground
^Z
[1]+  Stopped              sleep 10

## bg lg jobs
$ bg %1
[1]+ sleep 10 &

-- jobs 查看后台运行的程序及运行状态
```



## other parts
### bash mysql
eg:
```
firefox `mysql -u root -p1111111 test -e "select url  from man where name='$command';" | grep http`
```


### uname -s
Linux
__________________________________________________________________________________________________________


### rm
// 删除文件夹 "home
// 注意文件夹中有单引号,上引号都需要转义
rmdir \"home



shell写俄罗斯方块:
[shell编程](http://blog.chinaunix.net/uid-26833883-id-3153839.html)



nice nice - run a program with modified scheduling priority
renice  - alter priority of running processes
uptime  - Tell how long the system has been running.
ps process status command
ps -efl
ps aux
who show who is login

expr命令一般用于整数值，但也可用于字符串。一般格式为：
expr argument operator argument

(注意运算符左右都有空格 ，如果没有空格表示是字符串连接)
使用乘号时，必须用反斜线屏蔽其特定含义。因为 shell 可能会误解显示星号的意义。

### readlink
读取一个快捷键实际指向的文件:
readlink russia.sh


bash 字符串截取函数

[How do ${0##*/} and ${0%/*} work?](https://unix.stackexchange.com/questions/22387/how-do-0-and-0-work)


shell 脚本

$0 所运行的脚本









