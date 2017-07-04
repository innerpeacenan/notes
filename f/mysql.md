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


前一天的时间格式是26-5-1 22:21:21
date(‘Y-n-j H:i:s’， strtotime(‘-1 days’)




事务：
原子性（Atomicity）
一致性（Consistency）
隔离性（Isolation）
持久性（Durability）



mysqld writes statements to the query log in the order that it receives them, which might differ from the order in which they are executed. This logging order is in contrast with that of the binary log, for which statements are written after they are executed but before any locks are released. In addition, the query log may contain statements that only select data while such statements are never written to the binary log.



CREATE TABLE `notes` (
  `id` int unsigned NOT NULL auto_increment,
  `item_id` int unsigned NOT NULL comment 'eq to items.id, 项目ID',
  `content` text NOT NULL,
  `ct_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint(1) DEFAULT '1',
  primary key(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='notes';


insert into notes (item_id,content) value(1,"test");

insert into items (user_id,name,c_time,u_time,status) values(1,"name",now(),now(),2);

CREATE TABLE `items` (
  `id` int unsigned NOT NULL auto_increment comment '主键',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '用户id',
  `name` char(12) NOT NULL,
  `c_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `u_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间,需要在修改basic_info后,或者更新了与之对应的note后,更新该字段',
  `status` enum('draft','enable') NOT NULL DEFAULT 'enable' COMMENT 'draft 回收暂放, enable 启用',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ct_time` (`c_time`),
  KEY `latest_time` (`u_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='items'


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
