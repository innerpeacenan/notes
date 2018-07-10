use beeper_customer_api;
drop table if exists `tv_collection_log`;
CREATE TABLE `tv_collection_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `collection_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '集合ID,tv_collection.id',
  `operator_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '鸟眼操作人ID',
  `operator_name` char(20) NOT NULL DEFAULT '' COMMENT '操作人名称',
  `operate_type` tinyint(3) NOT NULL DEFAULT '3' COMMENT '1,绑定, 2,解绑, 3,其他',
  `before_data` varchar(1000) NOT NULL DEFAULT '' COMMENT '修改前的数据,json格式',
  `after_data` varchar(1000) NOT NULL DEFAULT '' COMMENT '修改后的数据,json格式',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='在仓大屏配置修改记录表';




CREATE TABLE bigscreen_statistics_snapshot (
  id                    BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  tv_code               BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '电视编码',
  app_type              TINYINT(4)          NOT NULL DEFAULT 1
  COMMENT '标志使用的软件类型,是浏览器还是tv_app',
  create_date           DATE                NOT NULL DEFAULT '0000-00-00'
  COMMENT '电视播放日期,也即该统计信息新建的日期',
  bigcreen_type         TINYINT(4)          NOT NULL DEFAULT 1
  COMMENT '电视大屏类型,与bigscreen_token.token_type对应',
  total_active_time     BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '播放时长,单位分钟',
  list_mode_active_time BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '在仓大屏列表模式播放时长,单位分钟',
  map_mode_active_time  BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '在仓大屏地图模式播放时长,单位分钟',
  collection_count      INT(11) UNSIGNED    NOT NULL DEFAULT 0
  COMMENT '集合数量',
  event_count           BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '出车数量',
  order_count           BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '订单数量',
  customer_name         VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '项目名称',
  company_name          VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '公司名称',
  group_name            VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '集团名称',
  `created_at`          DATETIME            NOT NULL DEFAULT '0000-00-00 00:00:00'
  COMMENT '创建时间',
  `updated_at`          DATETIME            NOT NULL DEFAULT '0000-00-00 00:00:00'
  COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY `uq_tv_code_screen_type_date`(tv_code, bigcreen_type, create_date)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '鸟眼各种大屏按电视每天的统计信息快照';

CREATE TABLE bigscreen_statistics_snapshot (
  id               BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  tv_code          BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '电视编码',
  create_date      DATE                NOT NULL DEFAULT '0000-00-00'
  COMMENT '电视播放日期,也即该统计信息新建的日期',
  bg_type          TINYINT(4)          NOT NULL DEFAULT 1
  COMMENT '电视大屏类型,与bigscreen_token.token_type对应(集团大屏和在仓大屏)',
  collection_count INT(11) UNSIGNED    NOT NULL DEFAULT 0
  COMMENT '集合数量',
  event_count      BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '出车数量',
  order_count      BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '订单数量',
  customer_ids     VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '项目ID,多个客户逗号分割',
  customer_name    VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '项目名称',
  company_ids      VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '公司ID,多个公司逗号分割',
  company_name     VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '公司名称',
  group_ids        VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '集团id,多个集团逗号分隔',
  group_name       VARCHAR(200)        NOT NULL DEFAULT ''
  COMMENT '集团名称',
  `created_at`     DATETIME            NOT NULL DEFAULT '0000-00-00 00:00:00'
  COMMENT '创建时间',
  `updated_at`     DATETIME            NOT NULL DEFAULT '0000-00-00 00:00:00'
  COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY `uq_tv_code_screen_type_date`(tv_code, bg_type, create_date)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '鸟眼各种大屏按电视每天的统计信息快照';


INSERT INTO `bigscreen_statistics_snapshot`
(`tv_code`, `create_date`, `bg_type`, `collection_count`, `event_count`, `order_count`, `customer_ids`, `customer_name`, `company_ids`, `company_name`,`group_ids`, `group_name`, `created_at`, `updated_at`)
VALUES
  (100018, '2018-05-14', 1, 2, 5, 30, 279, 'cqy-bj2', '2815', '柴公司全称十', '6', '柴倩怡集团全称一', '2018-05-14 14:51:23', '2018-05-14 14:51:23'),
  (100019, '2018-05-14', 20, 2, 50, 100, '', '', '','', '6','柴倩怡集团全称一','2018-05-14 14:51:23', '2018-05-14 14:51:23'),
  (100020, '2018-05-14', 25, 3, 20, 50, '147,279', 'shiyang123,cqy-bj2','2815','柴公司全称十','','','2018-05-14 14:51:23', '2018-05-14 14:51:23');


delimiter ;;
create procedure myproc3()
  begin
    declare num int ;
    set num = 1 ;
    while num < 1000 do
      insert into test (name, `length`, c )
      values
        (concat("name", 1), 1, num) ;
      set num = num + 1 ;
    end
    while ;
  end;;
delimiter ;





select * from  bigscreen_token as token INNER join tv_code_mac as tv on CONVERT(tv.token USING utf8) COLLATE utf8_unicode_ci  = CONVERT(token.token USING utf8) COLLATE utf8_unicode_ci  where token.login_type = 1 and token.collection_id > 0 and token.expired_at > '2018-05-26 00:00:00' and token.disabled = 0  limit 12;

select * from tv_code_mac as tv left join bigscreen_token as token on CONVERT(tv.token USING utf8) COLLATE utf8_unicode_ci  = CONVERT(token.token USING utf8) COLLATE utf8_unicode_ci where token.token_type = 0 and token.expired_at > '2018-05-26 00:00:00';








