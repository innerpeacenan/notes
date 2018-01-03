# basic concept
svn command [options] [args]
## commands
#### svn  ls  版本库下的文件和目录列表
>  svn list path 显示path目录下的所有属于版本库的文件和目录简写：svn ls


* [svn仓库](http://LAPTOP-9TVI6PUM:8888/svn/MyRepository/)


### svn log 历史目录查看

* `--search`
>  If multiple --search options are provided, a log message is shown if it matches any of the provided search patterns. If the --search-and option is used, that option's argument is combined with the pattern from the previous --search or --search-and option, and a log message is shown only if it matches the combined search pattern. If --limit is used in combination with --search, --limit restricts the number of log messages searched, rather than restricting the output to a particular number of matching log messages.

```
-r 版本日期或者版本号
svn log --username nanxiaoning -v -r {2016-12-13}
--search ARG             : use ARG as search pattern (glob syntax)
--search-and ARG         : combine ARG with the previous search pattern
svn log --verbose --search nanxiaoning 查找某个用户提交明细
svn log -v -r {2011-02-02}:{2011-02-03}
#可以起别名,方便使用
alias svnlog='svn log -l 30 | less'
```
* using sed
```
svn log -v | sed -n '/nanxiaoning/,/-----$/ p' | head -n 50
```


### 查看指定文件的变更记录
>  Show the log messages for any incoming changes to foo.c during the next 'svn update':


```
svn log -r BASE:HEAD foo.c
svn log -r 20 touched.txt --diff
```

### 冲突相关
####  svn resolved: 移除工作副本的目录或文件的“冲突”状态。
> 用法: resolved PATH... 注意: 本子命令不会依语法来解决冲突或是移除冲突标记；它只是移除冲突的相关文件，然后让 PATH 可以再次提交。


* svn for erp(已废弃)
svn checkout svn://101.200.196.64/ffzerp2.0/  --username nanxiaoning

* sql数据库远程链接
```
mysql --auto-rehash -h 101.200.196.64 -P 3306 -u username -ppasswd dbname
```