查找某一客户仓的ID
curl 'http://192.168.203.11:7200/v2/warehouse/gets?customer_id=114&from=10499'

BeeperTransEvent - 运力分组统计

/v2/beeper/trans/event/groupby

get
http://172.17.55.222:7220/v2/beeper/trans/event/groupby?from=300&warehouse_id=4699&group_by=status&work_time_start=2018-01-01%2000:00:00&work_time_end=2018-01-11%2000:00:00

统计信息:
{
    "code": 0,
    "msg": "成功",
    "info": {
        "totalTime": 2,
        "total": 2,
        "list": {
            "100": 2,
            "900": 1
        },
        "pagination": {
            "total": 2,
            "total_pages": 1,
            "per_page": 20,
            "page": 1,
            "pre_page": 1,
            "next_page": 1,
            "count": 2
        }
    }
}


