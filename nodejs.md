
## node js 源码安装
/usr/bin/nodejs
4.0 全局安装



/usr/local/bin/npm -v
/usr/local/bin/node -v



### nodejs 个人项目安装过程

beeper_api 项目安装过程:
(1) node 版本过高, 造成了一定问题, 重新安装

(2) 将192.168.203.13这台机器上的/var/www/beeper_api目录下testing.env.cson文件的内容拷贝到development.env.cson文件中.


(3) 将打包好的 /home/www/node_modules.tar.gz 解压到 /var/www/deploy/beeper_api 目录下, 代替 /usr/local/bin/npm install
(4) /usr/local/bin/node customer_api.js

由于 app_base.init(process.env.APP_NAME, 6500, function(err, result) 中制定了端口号 6500


通过所启用的端口号为:
netstat -tulnp | grep 'node'

发现存在 6500 端口


在  customer_api.js 开头打印 console.log("hello"), 会在服务重新启动的时候执行一次, nodejs 为常驻进程, express 的启动代码只执行一次.


安装 supervisor
/usr/local/bin/npm install supervisor -g

nodejs 开发模式:
/var/log/yunniao/beeper_api

目前的难点: 模拟发请求的话, 需要写java代码, 直接发请求可能不行,需要登录


需要登陆:
{"code":100,"info":{"msg":"请检查是否登录"}}''


curl -X POST  'http://localhost:6500/api/v2/trans_task/create'



对 node 原生的 request 组件进行了一次包装.(类似对 php curl 扩展的包装)
/var/www/deploy/beeper_api/lib/build_request_url.js

cson 和 json 的关系:
CSON(Cursive Script Object Notation) is a strict superset of JavaScript Object Notation(JSON) that can be written by hand (hence the name) and translated to a canonical JSON. ... Every CSON data can be translated to JSON back and forth, so you can continue using the existing library that only understands JSON.

lodash

类似php array_get 方法:
path (Array|string): The path of the property to get
_.get(body, 'match_type',
		_.get(BeeperDefinitions, 'transport.trans_match.match_type.bid.code'));




打印对象:
return that(JSON.stringify(params) || 'error')

记Log

logger.access.info('Worker ' + process.env.WORKER_ID + ' starting ...');


路由规则在这个文件里边

lib/mvc_boot_v2.js

该文件其实被 watch.js 所引用:
watch.js:10:	install_route = require('./lib/mvc_boot_v2');




grep 'api/v2/trans_task/create' customer_api.js-2018-02-01.log  | grep '422'

watch.js 被 app_base.js 所引用, 所以整个链路就是这样的.


请求的配置文件位置:
edit config/request_api.cson


base_data:
http://beeper_base_data.api.d1.yn.cn/v2/customer/setting/get_by_customer_id


是否可以创建标书:(招司机)
lib/tender.js:4320:function is_customer_can_create_tender(cuid, cb){
lib/tender.js:4457:		is_customer_can_create_tender : is_customer_can_create_tender,
controllers/customer_api/trans_task.js:1105:			tender_lib.is_customer_can_create_tender(customer_id, function(err, result){

直接查询的客户表格和库:
/var/www/deploy/beeper_api/models/customer_model.js
42:
var customerSchema = new Schema


node model
models/finance/yn_income_model.js


回调函数的返回有三种:
有请求error,  return that(error)
无请求error, 但 result.code > 0,  reutrn that(result.msg);
有数据, that(null, {task: result.info});


//请求的结果如果需要保存,则以一个属性的形式存起来
.seq('cal_fee', function (customer_invoice) {
_calculate_actual_single_price(query.trans_task_id, customer_invoice, this);
})

以 this.vars.cal_fee 这种方式引用


lib/customer.js:409:			var login_name = _.get(this.vars.account_info, 'login_name');


登陆认证:
services/auth_service.js


services/auth_service.js:118:					return cb('您输入的密码与用户名不匹配，请重新输入');


beeper_api 常量位置:
node_modules/beeper_constants/constants.cson

















