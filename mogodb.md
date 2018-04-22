查看所有集合

show dbs
查看每个数据库下的所有集合
show collections

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


