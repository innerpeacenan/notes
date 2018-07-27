show dbs
use beeper2;

显示所有文档

show collections
show tables
db.getCollectionNames()



db.warehouses.find({},{"_id":-1, "name":1}).limit(1)

控制要显示的字段(0表示不显示该字段)
db.warehouses.find({},{"_id":0, "wid":1, "name":1}).limit(1)

聚合:
db.warehouses.aggregate([{$group : { _id : "$by_user", num_tutorial : {$sum : 1}}}])

查询计划解释:
db.warehouses.find({cuid:279},{_id:0, wid: 1}).limit(1).explain();


mogo 跟新操作:
use beeper2;
db.car_teams.update({ctid:{$in:[4226,5344,4218,4778,5094,4800,6892,6992,7271,7208]}}, {$set:{is_thunderbird:1}}, {multi:true});

