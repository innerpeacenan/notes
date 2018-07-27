elastic search 目前被安装到 /home/ffz/opt 目录下, 在/home/ffz/opt/elasticsearch-6.0.0 以用户ffz的身份运行: ./bin/elasticsearch, 服务正常启用. 但在在新建第一个 index 后, 新建第一个文档, 及控制台提示 flood stage disk watermark [95%] exceeded on. 查看磁盘中间, 主分区被占用的所剩无几了, 因此考虑用 www 用户的去运行 es, 并将其home设置到: /home/www 下面,因为这个目录当时在挂在的时候,大概有20G, 目前的使用量非常少.

首先, 查看 www 这个用户的所属的群组:
```
id www
uid=1002(www) gid=1002(www) groups=1002(www)
```

对照用户ffz,修改www的档案:

```
vim /etc/passwd 添加如下内容:
ffz:x:1000:1000:ffz,,,:/home/ffz:/bin/bash
www:x:1002:1002::/home/www:/bin/bash
```

非www用户添加 sudo 权限

```
usermod -aG sudo www

chown -R www:www /home/www
```



/etc/security/limits.conf




查询indices
curl  'http://localhost:9200/_mapping?pretty=true'

增:
curl -X POST 'http://localhost:9200/accounts/person/' -H 'Content-Type: application/json' -d '
{
  "user": "李四",
  "title": "工程师",
  "desc": "系统管理"
}'


删除:
curl -X DELETE  'http://localhost:9200/accounts/person/2'
// 注意是X 不是 x
curl -X DELETE 'http://localhost:9200/weather'

curl -X PUT 'http://localhost:9200/accounts/person/1' -H 'Content-Type: application/json' -d '
{
  "user": "张三",
  "title": "工程师",
  "desc": "数据库管理"
}'

改正:
curl -X PUT 'localhost:9200/accounts/person/1' -H 'Content-Type: application/json' -d '
{
    "user" : "张三",
    "title" : "工程师",
    "desc" : "数据库管理，软件开发"
}' 

Updates can also be performed by using simple scripts. This example uses a script to increment the age by 5:

POST /customer/_doc/1/_update?pretty
{
  "script" : "ctx._source.age += 5"
}


update by query

POST twitter/_update_by_query?conflicts=proceed


// 查询标准所有记录
curl 'http://localhost:9200/accounts/person/_search?pretty=true'

// 修改配置项
curl -X PUT 'http://localhost:9200/accounts/_settings' -H "Content-Type: application/json"  -d '{"index.blocks.read_only_allow_delete": null}'




集群健康情况:
curl 'http://localhost:9200/_cat/health?v'

add a new index

curl -X PUT 'http://localhost:9200/customer?pretty'


list all indices

GET /_cat/indices?v


黄色状态解释:
You might also notice that the customer index has a yellow health tagged to it. Recall from our previous discussion that yellow means that some replicas are not (yet) allocated. The reason this happens for this index is because Elasticsearch by default created one replica for this index. Since we only have one node running at the moment, that one replica cannot yet be allocated (for high availability) until a later point in time when another node joins the cluster. Once that replica gets allocated onto a second node, the health status for this index will turn to green.





"Document mapping type name can't start with '_'


If we study the above commands carefully, we can actually see a pattern of how we access data in Elasticsearch. That pattern can be summarized as follows:

<REST Verb> /<Index>/<Type>/<ID>


curl 'http://localhost:9200/twitter/_search?q=user:kimchy&pretty=true'



查询:

curl -X POST 'http://localhost:9200/twitter/_search' -H 'Content-Type: application/json' -d '
{
    "query":{
	    "match": {
            "message": "elasticsearch"
        }
    }
}
'



{
    "bool": {
        "must":     { "match": { "title": "how to make millions" }},
        "must_not": { "match": { "tag":   "spam" }},
        "should": [
            { "match": { "tag": "starred" }}
        ],
        "filter": {
          "bool": { 
              "must": [
                  { "range": { "date": { "gte": "2014-01-01" }}},
                  { "range": { "price": { "lte": 29.99 }}}
              ],
              "must_not": [
                  { "term": { "category": "ebooks" }}
              ]
          }
        }
    }
}
'


es 复合查询:

curl -X POST 'http://localhost:9200/twitter/_search' -H 'Content-Type: application/json' -d '
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "message": "Elasticsearch"
          }
        }
      ]
    }
  }
}
'


