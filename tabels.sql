CREATE TABLE `order_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `origin_id` varchar(64) NOT NULL COMMENT '第三方订单id',
  `tms_order_code` varchar(64) DEFAULT '' COMMENT '运单号 暂时只有菜鸟在用',
  `cuid` bigint(20) unsigned NOT NULL COMMENT 'B端用户的id',
  `customer_name` varchar(64) NOT NULL COMMENT '客户名称',
  `dp_contact_name` varchar(32) DEFAULT '' COMMENT 'C端用户的名称',
  `dp_contact_mobile` varchar(32) NOT NULL COMMENT 'C端用户的手机号',
  `dp_backup_mobile` varchar(32) DEFAULT '' COMMENT 'C端用户的备用手机号',
  `dp_address` varchar(256) NOT NULL COMMENT 'C端用户的地址',
  `is_important` tinyint(3) unsigned DEFAULT '0' COMMENT '是否重要客户,1:重要客户,0:非重要客户',
  `is_cod` tinyint(3) unsigned DEFAULT '0' COMMENT '是否代收款,1:代收款,0:不代收款',
  `is_abnormal` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否异形货',
  `order_send_day` int(11) unsigned DEFAULT '0' COMMENT '配送日期,时间戳',
  `dp_rta_start` int(11) unsigned DEFAULT '0' COMMENT 'C端用户开始可以收货的开始时间',
  `dp_rta_end` int(11) unsigned DEFAULT '0' COMMENT 'C端用户开始可以收货的结束时间',
  `dp_longitude` varchar(32) DEFAULT '' COMMENT '坐标,经度',
  `dp_latitude` varchar(32) DEFAULT '' COMMENT '坐标,维度',
  `dp_coord_sys` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配送点坐标图商标识',
  `dp_guide` varchar(512) DEFAULT '' COMMENT '指引',
  `call_back_url` varchar(512) DEFAULT '' COMMENT '状态回调的url',
  `warehouse_name` varchar(64) NOT NULL COMMENT '仓名称',
  `warehouse_id` bigint(20) unsigned NOT NULL COMMENT '仓id',
  `order_total_price` int(11) unsigned DEFAULT '0' COMMENT '总的价格,单位是分',
  `order_total_num` int(11) unsigned DEFAULT '0' COMMENT '总的数量',
  `cargo_price` int(11) unsigned DEFAULT '0' COMMENT '代收金额,单位是分',
  `order_total_weight` bigint(20) unsigned DEFAULT '0' COMMENT '订单总的重量,单位是克',
  `order_total_volume` bigint(20) unsigned DEFAULT '0' COMMENT '订单总的体积,单位是平房厘米',
  `order_status` int(11) unsigned NOT NULL COMMENT '订单状态值',
  `sign_status` tinyint(3) unsigned DEFAULT '0' COMMENT '签单状态',
  `create_time` int(11) unsigned DEFAULT '0' COMMENT '创建时间',
  `sign_time` int(11) unsigned DEFAULT '0' COMMENT '签单时间',
  `update_time` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
  `line_time` int(11) unsigned DEFAULT '0' COMMENT '排线时间',
  `pickup_time` int(11) unsigned DEFAULT '0' COMMENT '订单进入拣货中的时间',
  `start_send_time` int(11) unsigned DEFAULT '0' COMMENT '司机开始配送时间',
  `end_send_time` int(11) unsigned DEFAULT '0' COMMENT '司机结束配送时间',
  `cancel_time` int(11) unsigned DEFAULT '0' COMMENT '取消订单的时间',
  `cancel_reason` varchar(128) DEFAULT '' COMMENT '取消订单的原因',
  `cancel_cuid` bigint(20) unsigned DEFAULT '0' COMMENT '取消订单的人id',
  `cancel_user` varchar(64) DEFAULT '' COMMENT '取消订单的人名称',
  `area_id` varchar(64) DEFAULT '' COMMENT '区域id',
  `area_name` varchar(64) DEFAULT '' COMMENT '区域名称',
  `note` varchar(512) DEFAULT '' COMMENT '备注信息',
  `callback_url` varchar(512) DEFAULT '' COMMENT '回调的url',
  `order_detail` longtext COMMENT '订单详情',
  `source` varchar(64) DEFAULT '' COMMENT '订单来源',
  `complete_longitude` varchar(32) DEFAULT '' COMMENT '订单完成时的坐标,经度',
  `complete_latitude` varchar(32) DEFAULT '' COMMENT '订单完成时的坐标,维度',
  `complete_coord_sys` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单完成坐标图商标识',
  `uarrive_longitude` varchar(32) DEFAULT '' COMMENT '到达配送地点的坐标,经度',
  `uarrive_latitude` varchar(32) DEFAULT '' COMMENT '到达配送地点的坐标,维度',
  `uarrive_coord_sys` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '到达配送点坐标图商标识',
  `uarrive_time` int(11) unsigned DEFAULT '0' COMMENT '到达配送地点的时间',
  `from` varchar(32) DEFAULT '' COMMENT '修改的来源',
  `harrive_time` int(11) unsigned DEFAULT '0' COMMENT '到达仓的时间',
  `is_pickup` tinyint(3) unsigned DEFAULT '0' COMMENT '配送点为送属性,0:送,1:取',
  `create_day` int(11) unsigned DEFAULT '0' COMMENT '创建订单的天,为了统计订单',
  `order_create_time` int(11) unsigned DEFAULT '0' COMMENT '订单在第三方下单的时间',
  `province` varchar(64) DEFAULT '' COMMENT '省',
  `city` varchar(64) DEFAULT '' COMMENT '市',
  `district` varchar(64) DEFAULT '' COMMENT '区',
  `iti_callback_url` varchar(512) DEFAULT '' COMMENT '派车单状态回调的url',
  `reject_reason` varchar(128) DEFAULT NULL COMMENT '拒收原因',
  `sign_images` text COMMENT '签收单的照片',
  `sign_code` varchar(16) DEFAULT '' COMMENT '签收验证码',
  `tag` int(11) DEFAULT '0' COMMENT '1:验证码验证成功',
  `distri_consts` int(11) unsigned DEFAULT '0' COMMENT '配送费',
  `user_id` bigint(20) unsigned DEFAULT '0' COMMENT '配送中心用户id,后期去掉',
  `send_id` bigint(20) unsigned DEFAULT '0' COMMENT '发货方的id',
  `send_type` tinyint(3) unsigned DEFAULT '0' COMMENT '发货方式',
  `md5` varchar(64) NOT NULL COMMENT '地址的md5',
  `group_name` varchar(32) DEFAULT '' COMMENT '集合名称',
  `received_money` int(10) unsigned DEFAULT NULL,
  `reduction_reason` varchar(128) DEFAULT NULL COMMENT '减免原因',
  `payee` tinyint(4) DEFAULT NULL COMMENT '收款方',
  `received_money_time` int(10) unsigned NOT NULL COMMENT '收款时间',
  `pay_images` text NOT NULL COMMENT '收款照片',
  `service_charge` int(10) unsigned DEFAULT NULL,
  `reason_code` int(32) unsigned DEFAULT NULL,
  `receiving_money_time` int(10) unsigned NOT NULL COMMENT '开始收款时间',
  `pay_authority` tinyint(4) DEFAULT NULL COMMENT '代收款开关',
  `lanshou_time` int(12) unsigned DEFAULT '0' COMMENT '订单揽收时间',
  PRIMARY KEY (`id`),
  KEY `cuid_origin_id` (`cuid`,`origin_id`),
  KEY `order_send_day` (`order_send_day`),
  KEY `dp_contact_mobile` (`dp_contact_mobile`),
  KEY `cuid_warehouse_id` (`cuid`,`warehouse_id`),
  KEY `cuid_order_send_day` (`cuid`,`order_send_day`),
  KEY `cuid_status` (`cuid`,`order_status`),
  KEY `create_day_cuid` (`create_day`),
  KEY `index_name` (`tms_order_code`),
  KEY `cuid_create_day` (`cuid`,`create_day`),
  KEY `order_list_cuid_order_send_day_order_status_index` (`cuid`,`order_send_day`,`order_status`),
  KEY `order_list_customer_name_index` (`customer_name`),
  KEY `order_list_dp_contact_name_index` (`dp_contact_name`),
  KEY `order_list_is_cod_index` (`is_cod`),
  KEY `order_list_pay_authority_index` (`pay_authority`),
  KEY `order_list_received_money_index` (`received_money`),
  KEY `order_list_reason_code_index` (`reason_code`),
  KEY `idx_cuid_end_send_time` (`cuid`,`end_send_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49478023252993 DEFAULT CHARSET=utf8

# 订单签单状态
order_sign_status:
  -
    code: 1
    name: '已妥投'
  -
    code: 2
    name: '未妥投'

	
order_status:
  wait_lanshou:
    code: 20
    name: '待揽收'
    desc: '系统接单'
  normal:
    code: 51
    name: '待处理'
    desc: '订单揽收'
  abnormal:
    code: 52
    name: '待处理(位置异常)'
    desc: '订单揽收'
  line:
    code: 100
    name: '排线中'
    desc: '订单排线'
  pickup:
    code: 200
    name: '拣货中'
    desc: '开始拣货'
  harrive:
    code: 250
    name: '发货中'
    desc: '开始装货'
  send:
    code: 300
    name: '配送中'
    desc: '开始配送'
  user_arrive:
    code: 400
    name: '配送中(司机到达)'
    desc: '司机签到'
  unpaid:
    code: 430
    name: '收款中'
    desc: '收款中'
  paid:
    code: 450
    name: '已收款待签字'
    desc: '已收款待签字'
  complete:
    code: 500
    name: '已完成'
    desc: '配送完成'
  cancel:
    code: 600
    name: '取消'
    desc: '订单取消'

	

CREATE TABLE `order_snap` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `cuid` bigint(20) unsigned NOT NULL COMMENT '客户id',
  `order_id` bigint(20) unsigned NOT NULL COMMENT '订单id',
  `order_status` int(10) unsigned DEFAULT '0' COMMENT '订单状态',
  `sign_status` tinyint(3) unsigned DEFAULT '0' COMMENT '签收状态',
  `order_send_day` date DEFAULT NULL COMMENT '配送日期',
  `deliveryman_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '司机姓名',
  `deliveryman_mobile` varchar(32) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '司机电话',
  `reject_reason` varchar(128) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '签收/拒收原因',
  `cancel_reason` varchar(128) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '取消原因',
  `operation_type` int(10) unsigned NOT NULL COMMENT '操作类型',
  `operator_from` tinyint(1) unsigned DEFAULT '1' COMMENT '操作人来源[1B端 2W端]',
  `operator_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '操作人ID',
  `operator_user_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_cuid` (`cuid`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55866 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='订单快照表'




// beeper2 订单取消
CREATE TABLE `pod_customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一ID',
  `customer_id` int(11) unsigned NOT NULL COMMENT '客户ID',
  `is_enabled` tinyint(1) NOT NULL COMMENT '是否勾选了代收货款服务: 0未勾选，1勾选',
  `service_fee` double(8,4) NOT NULL COMMENT '服务费率，精确到0.01%',
  `pod_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '客户回款天数: 0代表T+0，1代表T+1',
  `begun_at` datetime NOT NULL COMMENT '代收货款服务生效时间',
  `is_train_needed` tinyint(1) NOT NULL COMMENT '是否需要对司机进行代收货款培训',
  `confirmation_information` text COLLATE utf8_unicode_ci NOT NULL COMMENT '确认资料信息',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `effect_at` datetime NOT NULL COMMENT '代收款开关的最近状态改变时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci



// 查询一条满足可取消条件的订单
select id, origin_id, cuid from order_list where cuid = 147 and order_status < 200 limit 1;




CREATE TABLE `order_send_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `cuid` bigint(20) unsigned NOT NULL COMMENT '用户id',
  `sender_name` varchar(64) NOT NULL COMMENT '发货方的名称',
  `sender_mobile` varchar(32) NOT NULL COMMENT '发货方的手机号',
  `sender_company` varchar(128) NOT NULL COMMENT '发货方的公司名称',
  `sender_address` varchar(128) NOT NULL COMMENT '发货方的地址',
  `md5` char(64) NOT NULL COMMENT 'name+mobile+company+address的MD5',
  `status` int(11) DEFAULT '0' COMMENT '状态',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `cuid_md5` (`cuid`,`md5`)
) ENGINE=InnoDB AUTO_INCREMENT=100466 DEFAULT CHARSET=utf8 


CREATE TABLE `order_group_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `order_id` bigint(20) unsigned NOT NULL COMMENT '订单ID',
  `group_id` bigint(20) unsigned NOT NULL COMMENT '结果集ID',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `create_method_code` smallint(6) NOT NULL COMMENT '来源',
  `sequence` smallint(6) NOT NULL COMMENT '排序',
  `order_update_time` int(10) unsigned DEFAULT NULL COMMENT '订单更新时间',
  `estimate_drive_time` int(11) unsigned DEFAULT '0' COMMENT '预估的行驶时长(分钟)',
  `estimate_drive_distance` int(11) unsigned DEFAULT '0' COMMENT '预估的行驶距离(米)',
  `estimate_service_time` int(11) unsigned DEFAULT '0' COMMENT '预估的服务时长(分钟)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_group_relation_order_id_group_id_unique` (`order_id`,`group_id`),
  KEY `order_group_relation_update_time_index` (`update_time`),
  KEY `order_group_relation_group_id_update_time_index` (`group_id`,`update_time`),
  KEY `order_group_relation_group_id_sequence_update_time_id_index` (`group_id`,`sequence`,`update_time`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16566041 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci



CREATE TABLE `order_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增ID',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态',
  `type` tinyint(4) NOT NULL COMMENT '类型',
  `keyword` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '关键字',
  `warehouse_id` bigint(20) unsigned DEFAULT NULL COMMENT '仓库ID',
  `warehouse_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '仓库名字',
  `region_id` bigint(20) unsigned DEFAULT NULL COMMENT '区域ID',
  `region_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '区域名字',
  `cuid` bigint(20) unsigned NOT NULL COMMENT '客户ID',
  `itinerary_id` bigint(20) unsigned DEFAULT NULL COMMENT '派车单ID',
  `order_send_day` int(10) unsigned DEFAULT NULL COMMENT '订单发送日期',
  `order_count` int(10) unsigned NOT NULL COMMENT '订单数量',
  `group_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '订单集合名称',
  `correlation_id` int(11) DEFAULT '0' COMMENT '算法ID',
  `line_car_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '集合使用车型',
  `car_type_id` int(10) NOT NULL DEFAULT '0' COMMENT '车型id',
  `creator_id` int(11) unsigned DEFAULT '0' COMMENT '集合创建人id',
  `creator_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '集合创建人名称',
  `updater_id` int(11) unsigned DEFAULT '0' COMMENT '集合修改人id',
  `updater_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '集合修改人名称',
  PRIMARY KEY (`id`),
  KEY `order_group_type_keyword_status_index` (`type`,`keyword`,`status`),
  KEY `order_group_status_index` (`status`),
  KEY `order_group_update_time_index` (`update_time`),
  KEY `order_group_itinerary_id_index` (`itinerary_id`),
  KEY `order_group_warehouse_id_index` (`warehouse_id`),
  KEY `order_group_cuid_index` (`cuid`),
  KEY `order_group_order_send_day_warehouse_id_cuid_index` (`order_send_day`,`warehouse_id`,`cuid`)
) ENGINE=InnoDB AUTO_INCREMENT=314885 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci


 CREATE TABLE `region_order_date_1023` (
  `cuid` bigint(20) unsigned NOT NULL COMMENT '客户ID',
  `order_id` bigint(20) unsigned NOT NULL COMMENT '订单ID',
  `date` int(11) unsigned NOT NULL COMMENT '配送日期',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单配送日期表' 


CREATE TABLE `order_tiles_2017_01_15` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `cuid` bigint(20) unsigned NOT NULL COMMENT '客户ID',
  `order_id` bigint(20) unsigned NOT NULL COMMENT '订单ID',
  `order_status` int(10) unsigned NOT NULL COMMENT '订单状态',
  `warehouse_id` bigint(20) unsigned NOT NULL COMMENT '仓ID',
  `date` int(10) unsigned NOT NULL COMMENT '配送时间',
  `longitude` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '经度',
  `latitude` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '纬度',
  `precision` int(10) unsigned NOT NULL COMMENT '精度',
  `tile_no` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '瓦片表示',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_tiles_2017_01_15_cuid_order_id_precision_unique` (`cuid`,`order_id`,`precision`),
  KEY `order_tiles_2017_01_15_cuid_order_status_index` (`cuid`,`order_status`),
  KEY `order_tiles_2017_01_15_order_id_order_status_index` (`order_id`,`order_status`),
  KEY `order_tiles_2017_01_15_warehouse_id_order_status_order_id_index` (`warehouse_id`,`order_status`,`order_id`),
  KEY `order_tiles_2017_01_15_precision_tile_no_warehouse_id_index` (`precision`,`tile_no`,`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci


beeper_trans_event

CREATE TABLE `yn_trans_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '事件id，即出车计划ID',
  `trans_task_id` int(11) NOT NULL COMMENT '线路任务ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `customer_price` int(11) NOT NULL COMMENT '客户价格，单位：分',
  `warehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `driver_id` int(11) NOT NULL COMMENT '司机ID',
  `driver_price` int(11) NOT NULL COMMENT '司机价格，单位:分',
  `sales_id` int(11) NOT NULL COMMENT '客服经理ID',
  `sop_mgr_id` int(11) NOT NULL COMMENT '现控经理id',
  `bid_mgr_id` int(11) NOT NULL COMMENT '岗位管理经理ID',
  `dd_id` int(11) NOT NULL COMMENT '拓展经理ID',
  `car_id` int(11) NOT NULL COMMENT '司机的车型ID',
  `car_num` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '司机的车牌号码',
  `car_team_id` int(11) NOT NULL DEFAULT '0' COMMENT '司机所属车队id',
  `status` smallint(6) NOT NULL DEFAULT '100' COMMENT '状态, 100 in_plan, 700 不配送',
  `type` smallint(6) NOT NULL DEFAULT '100' COMMENT '运力类型，默认为普通运力',
  `inspect_status` smallint(3) NOT NULL DEFAULT '100' COMMENT '检察状态',
  `inspect_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '检察状态最后更新时间',
  `comment` varchar(2000) COLLATE utf8_unicode_ci NOT NULL COMMENT '状态变化的描述：例如旷工原因、请假原因',
  `work_time` datetime NOT NULL COMMENT '出车日期 到仓时间',
  `work_begin_time` time NOT NULL COMMENT '到仓时间',
  `time_cost` int(11) NOT NULL COMMENT '预计花费时间 单位：秒',
  `created_at` datetime NOT NULL COMMENT '任务创建时间',
  `updated_at` datetime NOT NULL COMMENT '最后更新时间',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '出车计划是否被删除',
  `fcc_id` int(11) NOT NULL COMMENT '现控员ID',
  `invoice_contents` varchar(2000) COLLATE utf8_unicode_ci NOT NULL COMMENT '存储当时需开发票的内容',
  `task_type` smallint(6) NOT NULL COMMENT '线路任务类型',
  `task_line_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '任务线路名称',
  `task_is_back` tinyint(1) NOT NULL COMMENT '是否返仓 0不要求；1要求',
  `is_addition` tinyint(1) NOT NULL COMMENT '该出车记录是否是加跑',
  `addition_count` int(11) NOT NULL COMMENT '加跑次数，表示该出车记录被加跑了几次',
  `addition_comment` varchar(2000) COLLATE utf8_unicode_ci NOT NULL COMMENT '加跑说明，该出车记录被设置加跑的时候的说明文字',
  `addition_seq` int(11) NOT NULL COMMENT '当该出车记录为加跑记录的时候，表示该加跑是第几次加跑，序号',
  `source_event_id` int(11) NOT NULL COMMENT '当该出车记录为加跑记录的时候，记录其父项出车计划ID 即是对那一条出车计划进行加跑',
  `first_pay_money` tinyint(1) NOT NULL COMMENT '是否首次签到，用来做首日打款用的，一个司机只能有一个',
  `first_check_in` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否首次签到，用来做产生待评价用的，一个司机在一个客户的一个仓库下只能有一个',
  `is_supplement` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为补签到',
  `is_late` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否迟到',
  `is_wrong_location` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否签到位置与仓位置偏差大于1.5公里',
  `adc_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户所属管理区ID',
  `complete_time` datetime DEFAULT NULL COMMENT '运力完成时间',
  `project_type` smallint(2) DEFAULT '0' COMMENT '客户项目类型',
  `bu_leader_id` int(11) DEFAULT '0' COMMENT '客户所属bu leader的id',
  `new_trade_level_one` int(11) NOT NULL DEFAULT '0' COMMENT '客户新行业一级分类id',
  `new_trade_level_two` text COLLATE utf8_unicode_ci COMMENT '客户新行业二级分类id',
  PRIMARY KEY (`id`),
  KEY `idx_customer_id_task_type` (`customer_id`) COMMENT '客户ID和任务类型联合索引',
  KEY `idx_work_time` (`work_time`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_source_event_id` (`source_event_id`),
  KEY `idx_fcc_id` (`fcc_id`),
  KEY `idx_driver_id` (`driver_id`),
  KEY `idx_status` (`status`),
  KEY `idx_trans_task_id` (`trans_task_id`),
  KEY `idx_updated_at` (`updated_at`),
  KEY `idx_car_team_id` (`car_team_id`) COMMENT '司机所属车队id索引',
  KEY `idx_inspect_at` (`inspect_at`) COMMENT '出车记录检察状态更新时间索引',
  KEY `idx_dd_id` (`dd_id`),
  KEY `idx_warehouse_id` (`warehouse_id`) COMMENT '仓的索引',
  KEY `idx_complete_time` (`complete_time`),
  KEY `idx_did_status_del_worktime` (`driver_id`,`status`,`is_del`,`work_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3183359 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci


运力打点表(签到,离仓, 完成的数据库位置):
yn_trans_event_coordinate | CREATE TABLE `yn_trans_event_coordinate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '经纬度 ID',
  `trans_event_id` int(10) unsigned NOT NULL COMMENT '运力 ID',
  `type` smallint(3) NOT NULL COMMENT '类型, 这里和运力表中 status 取值一致, (400: 签到 800: 离仓 900: 配送完成)',
  `longitude` double(9,6) NOT NULL COMMENT '经度',
  `latitude` double(9,6) NOT NULL COMMENT '纬度',
  `coord_sys` smallint(3) NOT NULL DEFAULT '0' COMMENT '图商(0: 默认值 1: 百度 2: 高德 3: 世界坐标)',
  `client_ip` char(15) COLLATE utf8_unicode_ci NOT NULL COMMENT '打点时上报的客户端ip地址',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `picture_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '打点类型的图片',
  `operation_source` smallint(3) DEFAULT '0' COMMENT '操作来源，例如：801自动离仓，901补配送完成，902救援完成',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_event_id_type_index` (`trans_event_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=1657486 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci |



/var/www/deploy/beeper_definitions/current/config/transport/trans_event.yaml
运力类型
trans_event_type:
  normal:
    code: 100 
    name: '普通运力'
  practice:
    code: 200 
    name: '实习运力'
  rescue:
    code: 300 
    name: '救援运力' 

运力状态表:

trans_event_status:
  in_plan:
    code: 100 
    name: '未签到'                                                                                                                                
  check_in:
    code: 400 
    name: '签到'
  absent:
    code: 500 
    name: '旷工'
  leave:
    code: 600 
    name: '请假'
  day_off:
    code: 700 
    name: '设置不配送'
  departure:
    code: 800 
    name: '配送中'
  complete:
    code: 900 
    name: '配送完成'
  undo_complete:
    code: 950 
    name: '取消配送完成'


	
	
	
openapi 鉴权的表:

CREATE TABLE `authority` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `cuid` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `token` varchar(32) NOT NULL COMMENT 'token',
  `order_limit` int(10) unsigned NOT NULL DEFAULT '20' COMMENT '订单上限',
  `iti_callback_url` varchar(512) DEFAULT '' COMMENT '派车单状态回调的url',
  `reserve_callback_url` varchar(512) DEFAULT '' COMMENT '预约信息回传url',
  `order_callback_url` varchar(512) DEFAULT '' COMMENT '订单状态回调的url',
  `name` varchar(32) NOT NULL COMMENT '展示用户名',
  `source_name` varchar(32) NOT NULL,
  `content` varchar(1024) NOT NULL COMMENT '权限内容',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `customization_type` tinyint(3) DEFAULT '0',
  `third_key` varchar(64) DEFAULT NULL,
  `third_code` varchar(64) DEFAULT NULL,
  `create_user_id` int(10) unsigned DEFAULT NULL COMMENT '创建者ID',
  `create_user_name` varchar(64) DEFAULT NULL COMMENT '创建者姓名',
  `update_user_id` int(10) unsigned DEFAULT NULL COMMENT '更新者ID',
  `update_user_name` varchar(64) DEFAULT NULL COMMENT '更新者姓名',
  `email` varchar(64) DEFAULT NULL COMMENT '发送密码邮箱',
  `callback_method` tinyint(4) NOT NULL DEFAULT '0' COMMENT '回传方法,默认0表示GET',
  PRIMARY KEY (`id`),
  KEY `idx_cuid` (`cuid`),
  KEY `idx_source_name` (`source_name`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='openapi权限'


CREATE TABLE `order_import` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `cuid` bigint(20) unsigned NOT NULL COMMENT '用户的id',
  `import_day` int(11) NOT NULL COMMENT '上传订单的时间',
  `file_name` varchar(64) NOT NULL COMMENT '上传的文件名称',
  `status` tinyint(3) unsigned NOT NULL COMMENT '导入状态,1:导入中,2:删除,3:执行结果异常,4:导入完成',
  `end_time` int(11) unsigned DEFAULT '0' COMMENT '任务执行结束时间',
  `order_num` int(11) unsigned NOT NULL COMMENT '导入订单的条数',
  `error_num` int(11) unsigned DEFAULT '0' COMMENT '失败的订单数',
  `field_num` int(11) unsigned DEFAULT '0' COMMENT '失败的字段数',
  `type` tinyint(3) unsigned DEFAULT '0' COMMENT '错误的类型,1:校验失败,2:系统错误',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
  `proof` varchar(50) DEFAULT NULL COMMENT 'store_service 返回的文件凭证',
  PRIMARY KEY (`id`),
  KEY `cuid` (`cuid`),
  KEY `cuid_import_day` (`cuid`,`import_day`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4123 DEFAULT CHARSET=utf8


# 订单回调定制化语句
update `authority` set `customization_type` = 3 where  `source_name` =  "test" limit 1;

# 查询任务和运力对应关系以及运力的状态信息
beeper_trans_event.yn_trans_event
select customer_id, trans_task_id, work_time,status  from yn_trans_event where trans_task_id = 94997  order by id desc limit 10;



beeper_trans_settlement.trans_event_customer_expense
CREATE TABLE `trans_event_customer_expense` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `trans_event_id` int(11) unsigned NOT NULL COMMENT '出车记录id',
  `customer_id` int(11) unsigned NOT NULL COMMENT '计费发生的客户id',
  `type` smallint(3) unsigned NOT NULL COMMENT '价格类型 如：温控服务价格、sop服务价格等',
  `price` int(11) NOT NULL COMMENT '价格（单位：分）',
  `status` smallint(3) unsigned NOT NULL COMMENT '结算状态（100:不结算，200:结算，300:取消结算）',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_trans_event_id_type` (`trans_event_id`,`type`),
  KEY `idx_trans_event_id` (`trans_event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=628293 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;









# 司机福利相关表

CREATE TABLE `customer_welfare_event_approving` (
  `customer_welfare_event_id` int(11) NOT NULL COMMENT '福利发放记录ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `money` bigint(20) NOT NULL DEFAULT '0' COMMENT '发放金额,单位是分',
  PRIMARY KEY (`customer_welfare_event_id`),
  KEY `idx_customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='待审核福利发放记录'


CREATE TABLE `customer_welfare_event` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户福利事件ID',
  `customer_id` int(11) unsigned NOT NULL COMMENT '客户ID',
  `driver_id` int(11) unsigned NOT NULL COMMENT '司机ID',
  `adc_id` int(11) unsigned DEFAULT NULL COMMENT '客户管理区',
  `city` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '司机所属城市',
  `district` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '司机所属区县',
  `reason` varchar(1000) COLLATE utf8_unicode_ci NOT NULL COMMENT '发放原因',
  `money` bigint(20) NOT NULL COMMENT '发放金额,单位是分',
  `tax` bigint(20) NOT NULL COMMENT '发放金额对应的税,单位是分',
  `operator_id` int(11) unsigned NOT NULL COMMENT '操作人员ID',
  `operator_nick` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '操作人员的名称',
  `from` int(11) unsigned NOT NULL COMMENT '数据产生的调用端信息',
  `sale_id` int(11) DEFAULT NULL COMMENT '客户顾问ID',
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `finance_pay_type` int(11) NOT NULL DEFAULT '100' COMMENT '客户类型',
  `project_type` smallint(2) NOT NULL DEFAULT '0' COMMENT '福利发放时客户的项目类型',
  `bu_leader_id` int(11) DEFAULT '0' COMMENT '客户所属bu leader的id',
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '客户发福利的ip地址',
  `approval_status` smallint(5) NOT NULL DEFAULT '0' COMMENT '审批状态',
  `approved_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '审批时间',
  `approved_by_id` int(11) NOT NULL DEFAULT '0' COMMENT '审批人ID',
  `approved_by_nick` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '审批人姓名',
  `approval_remark` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '审核说明',
  `welfare_type` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '福利类型',
  `customer_price` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '客户单价，单位为分',
  `driver_price` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '司机单价，单位为分',
  `welfare_count` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '福利数量',
  `welfare_belong` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '福利归属',
  `driver_summary` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '司机福利总和，单位为分',
  `customer_summary` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '客户福利总和，单位为分',
  `type_id` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '客户福利类型id',
  `is_default_approved` bigint(19) NOT NULL DEFAULT '0' COMMENT '福利是否属于是默认审核通过的',
  `usrdef_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '手动输入的福利类型，默认为空',
  `as_cost` bigint(19) NOT NULL DEFAULT '0' COMMENT '该笔福利是否计入项目成本，默认为不进入项目成本：即客户应收',
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_customer_id_created_at` (`customer_id`,`created_at`),
  KEY `idx_driver_id_created_at` (`driver_id`,`created_at`),
  KEY `idx_city_district` (`city`,`district`),
  KEY `idx_sale_id_created_at` (`sale_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1556 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 



司机福利配置:
CREATE TABLE `customer_welfare_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户福利ID',
  `customer_id` int(11) unsigned NOT NULL COMMENT '客户ID',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启福利',
  `monthly_quota_money` bigint(20) NOT NULL COMMENT '客户月度福利上限,单位是分',
  `monthly_quota_money_per_driver` bigint(20) NOT NULL COMMENT '客户每个司机的月度福利上限,单位是分',
  `operator_id` int(11) unsigned NOT NULL COMMENT '操作人员ID',
  `operator_nick` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '操作人员的名称',
  `from` int(11) unsigned NOT NULL COMMENT '数据产生的调用端信息',
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci



CREATE TABLE `bigscreen_token` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(18) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '随机串',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型,1 在仓大屏',
  `account_id` int(11) NOT NULL DEFAULT '0' COMMENT '账号ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '集团ID',
  `warehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓ID',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否失效',
  `expired_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '过期时间',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_token` (`token`),
  KEY `idx_warehouse_id_type` (`warehouse_id`,`type`),
  KEY `idx_group_id_type` (`group_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='大屏token表' |



集团信息表:customer_group























