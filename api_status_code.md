success:
  code: 0
  desc: 成功
http_unauthorized:
  code: 901
  desc: 请求验证未通过
http_not_found:
  code: 904
  desc: 访问的页面不存在
http_method_not_allow:
  code: 905
  desc: 不允许的请求方法
params_invalid:
  code: 1000
  desc: 参数非法
params_invalid_required:
  code: 1001
  desc: 缺少必填项
params_invalid_format:
  code: 1002
  desc: 参数格式错误
params_invalid_value:
  code: 1003
  desc: 参数值不在配置选项中
params_invalid_frquence:
  code: 1004
  desc: 频率过快
params_invalid_exceed_limit:
  code: 1005
  desc: 超出限制
params_invalid_password_match:
  code: 1006
  desc: 密码不对
params_invalid_account_disable:
  code: 1007
  desc: 账号被封
params_invalid_password_not_change:
  code: 1008
  desc: 新旧密码不可以相同
params_invalid_unique_repeat:
  code: 1009
  desc: 唯一key有重复
params_invalid_business_limit:
  code: 1010
  desc: 超出业务限制
params_invalid_param_too_long:
  code: 1011
  desc: 参数长度过长
conflict_error:
  code: 1012
  desc: 冲突导致失败
already_done:
  code: 1013
  desc: 操作在请求前就已经完成
invalid_action:
  code: 1014
  desc: 该操作不合法
database_error:
  code: 1100
  desc: 数据库错误
data_error:
  code: 1101
  desc: 访问的数据不存在
datetime_error:
  code: 1200
schedule_error:
  code: 1250
service_error:
  code: 1300
server_error:
  code: 1500
  desc: 系统错误
api_error:
  code: 1600
  desc: 调用底层API出错
config_error:
  code: 1700
  desc: 配置文件出错
