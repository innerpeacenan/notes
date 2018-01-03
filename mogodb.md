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


