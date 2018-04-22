curl 发post 请求, json 格式
curl -X POST 'http://beeper_customer_api.api.staging.yn.cn/v1/datacollect/event/append_mileage_and_time'  -d '"data":{"trans_event_id":5825581,"total_mileage":576.9,"locate_time":1516959420}'
