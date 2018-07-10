### create db
// 如果该数据库不存在,会自动创建
use dbName

// 从删库到跑路
db.dropDatabase();

db.createCollection();


查看所有集合

show dbs
查看每个数据库下的所有集合
show collections
//或者
show tables

### 数据库状态查看
db.serverStatus();

### 增,删,改

// 新增
db.inventory.insert({ item: "mousepad", qty: 25, tags: ["gel", "blue"], size: { h: 19, w: 22.85, uom: "cm" } })

// 更新
db.inventory.update({item: "journal"}, {$set:{"qty":20}});
// 删除
db.inventory.remove({qty:23});

// 批量写入(ordered 类型和 unordered 两种类型不同表现)
Bulk Write

```
db.stores.insert(
   [
     { _id: 1, name: "Java Hut", description: "Coffee and cakes" },
     { _id: 2, name: "Burger Buns", description: "Gourmet hamburgers" },
     { _id: 3, name: "Coffee Shop", description: "Just coffee" },
     { _id: 4, name: "Clothes Clothes Clothes", description: "Discount clothing" },
     { _id: 5, name: "Java Shopping", description: "Indonesian goods" }
   ]
)



db.characters.bulkWrite(
      [
         { insertOne :
            {
               "document" :
               {
                  "_id" : 4, "char" : "Dithras", "class" : "barbarian", "lvl" : 4
               }
            }
         },
         { insertOne :
            {
               "document" :
               {
                  "_id" : 5, "char" : "Taeln", "class" : "fighter", "lvl" : 3
               }
            }
         },
         { updateOne :
            {
               "filter" : { "char" : "Eldon" },
               "update" : { $set : { "status" : "Critical Injury" } }
            }
         },
         { deleteOne :
            { "filter" : { "char" : "Brisbane"} }
         },
         { replaceOne :
            {
               "filter" : { "char" : "Meldane" },
               "replacement" : { "char" : "Tanys", "class" : "oracle", "lvl" : 4 }
            }
         }
      ]
   );
```

### 查询

// The { item : null } query matches documents that either contain the item field whose value is null or that do not contain the item field.
db.inventory.find( { item: null } )

// null 对应的type code 为:10
db.inventory.find( { item : { $type: 10 } } );

// 查询没有该字段的
db.inventory.find( { item : { $exists: false } } )

// 给定查询条件的结果集数量查询
db.inventory.find().count();


db.test.find({$and:[{"title":"Buy milk"} , {"_id": 1}]}).pretty();

// 114 different from "114", 在 mogodb 里边是两种不同的数据类型

db.warehouses.find({"cuid":114});

db.test.find(
 {
   $or: [
    {"title":"Buy milk"},{"_id":1}
   ]
 }
);

db.getCollectionInfos({"name":"warehouses"})


db.drivers.update({},{"$set":{"is_chartered":false}},true,true)


show dbs;
use beeper2;
show collections
db.warehouses.find().pretty().limit(1)
db.warehouses.find({cuid : 279}).pretty().limit(1)



进一步细化的查询:
db.warehouses.find({"cuid" : { $lt:279}}).pretty().limit(1)

db.warehouses.find({"cuid" : { $lt:279} , "wid": 414}).pretty().limit(1)

db.warehouses.find({ $or:[{"cuid" : { $lt:279} , "wid": 414}]}).pretty().limit(1)

db.warehouses.find({"cuid" : {$lt:279}, $or:[{"wid": 414}, {"wid": 412}]}).pretty().limit(2)

范围查询
db.col.find({likes : {$lt :200, $gt : 100}})

//文本查询
db.stores.find( { $text: { $search: "java coffee shop" } })

// exact search
db.stores.find( { $text: { $search: "java \"coffee shop\"" } } )

//text exclusion
db.stores.find( { $text: { $search: "java shop -coffee" } } )

// 按匹配评分查询
db.stores.find(
   { $text: { $search: "java coffee shop" } },
   { score: { $meta: "textScore" } }
).sort( { score: { $meta: "textScore" } } )


### mongodb 索引:

db.users.ensureIndex({"tags":1})
db.users.find({tags:"cricket"})
db.users.find({tags:"cricket"}).explain()

### 汇总查询

```
db.posts.mapReduce( 
   function() { emit(this.user_name,1); }, 
   function(key, values) {return Array.sum(values)}, 
      {  
         query:{status:"active"},  
         out:"post_total" 
      }
).find()
```

### 更新并查询

db.to_2customer_evaluations.find({$and:[{cuid:700},{evid:{$in:[486554,462068,487278,449731,462103]}}]}).forEach(function(doc){db.to_2customer_evaluations.update({_id:doc._id},{$set:{reply:""}})});
