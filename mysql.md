
[TOC]
# 数据库基础知识


# 数据库权限

# 数据库备份

# 数据库语法
## 数据库字符集设置


## 创建表
### 创建表(根据查询结果创建)

## 全局变量



## 联合表更新数据

## 查询




## 数据库索引


## 函数

## 事务 mysql transaction


## 触发器

## 其他






-------------------------

//按照部门表的名称排序
order('convert(d.name using gbk)')

-- todo nxn
  `returnprice` decimal(8,2) NOT NULL COMMENT '退货金额(单个送货单的金额)',



SELECT *
FROM ffz_bsns_delivary AS d
WHERE exists(SELECT 1
             FROM ffz_bsns_delivary_info b
             WHERE d.id = b.delivarygid AND b.delivernum < 0)
LIMIT 2;



mysql 事务
[Chapter 15 The InnoDB Storage Engine](https://dev.mysql.com/doc/refman/5.7/en/innodb-storage-engine.html)
其中,锁和事务是最重要的内容:
15.5 InnoDB Locking and Transaction Model


```
from_unixtime(p.updatetime,"%Y-%m-%d %H:%i:%s") as updatetime')
```

### mysql 时区问题

show variables like '%time_zone%';
set time_zone = '+8:00'


// mysql 5.6之后才加入datetime的default value的
CREATE TABLE `friends` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1' COMMENT '用户id',
  `name` char(12) NOT NULL,
  `basic_information` text NOT NULL COMMENT '基本信息',
  `latest_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发表最新动态的时间',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `class` tinyint(4) NOT NULL DEFAULT '1',
  primary key (`id`),
  key `user_id` (`user_id`),
  key `latest_time` (`latest_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录头表';

### 修改外键
ALTER TABLE `friend_profile`
  ADD CONSTRAINT `friend_profile_ibfk_1` FOREIGN KEY (`id`) REFERENCES `friends` (`id`);


mysql
很多mysql日期函数直接接受特定格式的日期字符串
date_format()
date_add()
date_sub()//interval 1 day|month|year

select date_format(now(), "%Y年%c月%e日");
select date_format(now(),"%Y年%c月%e日 %H:%i:%S");
select date_sub(now(),interval 60 day);

mysql：（变量为第一个参数，月份从1开始计算）

select date_format( now(),"%W %M %D,%Y" );
select date_format( now(),"%Y-%m-%d" );//有前导符年月日
select date_format( now(),"%Y-%c-%e" );//无前导符年月日

now()，date()

事务：
原子性（Atomicity）
一致性（Consistency）
隔离性（Isolation）
持久性（Durability）

mysqld writes statements to the query log in the order that it receives them, which might differ from the order in which they are executed. This logging order is in contrast with that of the binary log, for which statements are written after they are executed but before any locks are released. In addition, the query log may contain statements that only select data while such statements are never written to the binary log.

insert into notes (item_id,content) value(1,"test");

insert into items (user_id,name,c_time,u_time,status) values(1,"name",now(),now(),2);

找了很久才找到,不容易呀:
[How to Enable MySQL logging?](https://support.plesk.com/hc/en-us/articles/213374189-How-to-Enable-MySQL-logging-)

## 回头查一下看如何错放的数据库里边
tail -f /usr/local/mysql/var/ubuntu.log



SET AUTOCOMMIT=0;
LOCK TABLES t1 WRITE, t2 READ, ...;
[do something with tables t1 and t2 here];
COMMIT;
UNLOCK TABLES;

通过设置锁等待超时参数 innodb_lock_wait_timeout来解决

在程序以批量方式处理数据的时候，如果事先对数据排序，保证每个线程按固定的顺序来处理记录，也可以大大降低出现死锁的可能。

在事务中，如果要更新记录，应该直接申请足够级别的锁，即排他锁，而不应先申请共享锁，更新时再申请排他锁，因为当用户申请排他锁时，其他事务可能又已经获得了相同记录的共享锁，从而造成锁冲突，甚至死锁。

如果出现死锁，可以用SHOW engine INNODB STATUS命令来确定最后一个死锁产生的原因。返回结果中包括死锁相关事务的详细信息，如引发死锁的SQL语句，事务已经获得的锁，正在等待什么锁，以及被回滚的事务等。据此可以分析死锁产生的原因和改进措施。下面是一段SHOW INNODB STATUS输出的样例：

SET autocommit = 0;
SELECT *
FROM tab_no_index
WHERE id = 2 FOR UPDATE;

SHOW ENGINE innodb STATUS;

SELECT left(`l`.`prepareplace`, 1) AS `delopre`
FROM `ffz_bsns_logistics_info` `l`
WHERE
  `l`.`logisticsid` = 1
GROUP BY left(`l`.`prepareplace`, 1);



show status like 'table%';

-- check if the total return money of return goods  is the same with return goods info
lock tables ffz_bsns_returngoods read local, ffz_bsns_returngoods_info read local;
select sum(returnprice) from ffz_bsns_returngoods;
SELECT sum(totalprice) from ffz_bsns_returngoods_info;
UNLOCK  TABLES ;

--  当使用LOCK TABLES时，不仅需要一次锁定用到的所有表，而且，同一个表在SQL语句中出现多少次，就要通过与SQL语句中相同的别名锁定多少次，否则也会出错
lock tables ffz_bsns_returngoods as a read,ffz_bsns_returngoods as b read;

-- Concurrent Inserts

-- 通过定期在系统空闲时段执行 OPTIMIZE TABLE语句来整理空间碎片，收回因删除记录而产生的中间空洞。


[mysql锁](http://blog.csdn.net/xifeijian/article/details/20313977)


我们可以通过一些设置来调节MyISAM 的调度行为。
¡  通过指定启动参数low-priority-updates，使MyISAM引擎默认给予读请求以优先的权利。
¡  通过执行命令SET LOW_PRIORITY_UPDATES=1，使该连接发出的更新请求优先级降低。
¡  通过指定INSERT、UPDATE、DELETE语句的LOW_PRIORITY属性，降低该语句的优先级。

# SHOW TABLE STATUS
# [{FROM | IN} db_name]
# [LIKE 'pattern' | WHERE expr]
-- show  tables status 语句不能针对一个表
show table STATUS;



查询事务隔离级别:
select @@tx_isolation;
innodb_locks_unsafe_for_binlog



因此，INSERT...SELECT...和 CREATE TABLE...SELECT...语句，可能会阻止对源表的并发更新，造成对源表锁的等待。如果查询比较复杂的话，会造成严重的性能问题，我们在应用中应尽量避免使用。实际上，MySQL将这种SQL叫作不确定（non-deterministic）的SQL，不推荐使用。

[mysql bin log 数据恢复](http://blog.csdn.net/xifeijian/article/details/20409775)
[MysqlReport解析](http://blog.csdn.net/xifeijian/article/details/19776667)
 [mysql 事务](http://www.cnblogs.com/LBSer/p/5183300.html)



SELECT * from ffz_bsns_logistics l WHERE NOT exists(
  SELECT 1 from ffz_bsns_logistics_info li where li.logisticsid = l.id
);


show engine innodb status

set tx_isolation = 'repeatable-read';  --事务隔离级别为repeatable-read，以后介绍


MySQL like % 查询优化 查询优化
新增一列，存储该字段的反转。比如原字段是abcd，取反存储为dcba，查询%bcd改成查dcb%。仅供参考。



set profiling = 1;
<do your insert>;
show profile;
 set profiling = 0;


### 导数据的时候取消约束检查

set foreign_key_checks=0


select host, user, password from mysql.user;

change master to master_host = 'server1',
    master_user = 'rep1',
    master_password = '1111111',
    master_log_file = 'mysql-bin.000001',
    master_log_pos  = 0;



## 读写分离的配置过程和部分原理

this tutorial will use the following IP addresses:
192.168.31.205-Master Database
192.168.31.126-Slave Database

assumes that you have already installed mysql
step ONe - Configure the Master database


## LNMP 默认mysqld 安装位置
Starts the MySQL database server.

Usage: /usr/local/mysql/bin/mysqld [OPTIONS]


在 [mysqld] 下作如下修改:

bind-address = 192.168.31.205


we need to grant privileges to the slave.You can use this line to name you slave and set up their password.The command should be in this format;

grant replication slave on *.*  to 'root'@'%' identified by '1111111';

where root is the user name, and 1111111 is the password;


Follow up with:
FLUSH PREVILEGES;


In your current tab switch to “newdatabase”.
`USE newdatabase;`

Following that, lock the database to prevent any new changes:
`FLUSH TABLES WITH READ LOCK;`

you can see a table that should look something like this:
show master status;

records these number,they will be useful later;

+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000143 |      342 | notes_11     |                  |


If you make any new changes in the same window, the database will automatically unlock. For this reason, you should open the new tab or window and continue with the next steps there.


Proceeding the with the database still locked, export your database using mysqldump in the new window (make sure you are typing this command in the bash shell, not in MySQL).

mysqldump -u root -p --opt newdatabase > newdatabase.sql

mysqldump --opt               Same as --add-drop-table, --add-locks, --create-options,
                      --quick, --extended-insert, --lock-tables, --set-charset,
                      and --disable-keys. Enabled by default, disable with
                      --skip-opt.



### Step Two—Configure the Slave Database
Import the database that you previously exported from the master database.

mysql -u root -p newdatabase < /path/to/newdatabase.sql



CHANGE MASTER TO MASTER_HOST='192.168.31.205',MASTER_USER='root', MASTER_PASSWORD='1111111', MASTER_LOG_FILE='mysql-bin.000143', MASTER_LOG_POS=  342;

Open up the the MySQL shell once again and type in the following details, replacing the values to match your information:

CHANGE MASTER TO MASTER_HOST='12.34.56.789',MASTER_USER='slave_user', MASTER_PASSWORD='password', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=  107;
This command accomplishes several things at the same time:

It designates the current server as the slave of our master server.
It provides the server the correct login credentials
Last of all, it lets the slave server know where to start replicating from; the master log file and log position come from the numbers we wrote down previously.

With that—you have configured a master and slave server.

Activate the slave server:

START SLAVE;

[防火墙问题,他们的折腾了一天](http://ji123.blog.51cto.com/11333309/195754)

change master to master_host='192.168.31.205',master_user='repuser',master_password='xsjy123',master_log_file='mysql-bin.000144',master_log_pos=602,master_port=3306;

iptables -I INPUT -p tcp -d 192.168.31.205 --dport 3306 -j ACCEPT

iptables -I OUTPUT -p tcp -s 192.168.31.205 --sport 3306 -j ACCEPT

grant all on notes_11.* to 'root'@'192.168.31.205' identified by '1111111';


set global general_log = on;
show global variables like "general%";

```
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('MyNewPass');
```


1.获取MySQL表的自增编号(AUTO_INCREMENT).SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'iophp' AND TABLE_NAME = 'io_post';
或者 SHOW TABLE STATUS FROM `iophp` WHERE `name` = 'io_post';

作者：eechen
链接：https://www.zhihu.com/question/66207785/answer/240562749
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


mysqldump
https://stackoverflow.com/questions/14022859/mysql-dump-database-along-data

```
mysql --auto-rehash -h ip -P 3306 -u userName -pPassWord DatabaseName
```

mysql 安装:

依赖boost,

wget   http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz

sudo mv ../boost_1_59_0.tar.gz  /usr/local/mysql/boost/

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/mysql/data -DSYSCONFDIR=/etc -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DDOWNLOAD_BOOST=1  -DWITH_BOOST=/usr/local/mysql/boost



### 表字符集不一致的解决方案
select * from  bigscreen_token as token INNER join tv_code_mac as tv on CONVERT(tv.token USING utf8) COLLATE utf8_unicode_ci  = CONVERT(token.token USING utf8) COLLATE utf8_unicode_ci  where token.login_type = 1 and token.collection_id > 0 and token.expired_at > '2018-05-26 00:00:00' and token.disabled = 0  limit 12;

select * from tv_code_mac as tv left join bigscreen_token as token on CONVERT(tv.token USING utf8) COLLATE utf8_unicode_ci  = CONVERT(token.token USING utf8) COLLATE utf8_unicode_ci where token.token_type = 0 and token.expired_at > '2018-05-26 00:00:00';









// 选择innodb类型的表
select table_name from INFORMATION_SCHEMA.TABLES where engine = 'InnoDB' and TABLE_SCHEMA = 'test';

// 设置mysql事务级别
SET TRANSACTION ISOLATION LEVEL READ COMMITTED；



悲观锁:

1.
Start Transaction;
select * from test2017 where c = 3 for update;
update test2017 set length = 12 where c = 3;
commit;

2.
update test2017 set length = 11 where c = 3;


select * from test2017 where c = 3;





表锁, 页锁, 行锁
共享锁(读锁) 排它锁(写锁)


A事务加了读锁后, B事务不能加上写锁.










```
// 字符校验集不同
select tv.*, t.id as tid , t.token as ttoken, c.id as cid, c.tv_code as tv_code  from tv_code_mac as tv left join tv_collection as c on c.tv_code  = CONVERT(tv.id USING utf8) COLLATE utf8_unicode_ci  left join bigscreen_token  as t on t.token = CONVERT(tv.token USING utf8) COLLATE utf8_unicode_ci where CONVERT(t.collection_id USING utf8) COLLATE utf8_unicode_ci  != CONVERT(c.id USING utf8) COLLATE utf8_unicode_ci;
```


```mysql
-- 改密码
set password for root@localhost = password('xxxxx'); 

update user set password=password() where user='root';
```



3. 判断主从延迟的方法

    MySQL提供了从服务器状态命令，可以通过 show slave status 进行查看,比如可以看看Seconds_Behind_Master参数的值来判断，是否有发生主从延时。
其值有这么几种：
NULL - 表示io_thread或是sql_thread有任何一个发生故障，也就是该线程的Running状态是No,而非Yes.
0 - 该值为零，是我们极为渴望看到的情况，表示主从复制状态正常