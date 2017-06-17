[todo]
### php Unit 使用总结
可能存在的bug:
当一个php PDOEXecption 被屏蔽后,phpunit 允许结果后显示 Segmentation fault (core dumped) 这个c语言级别的错误

dbUnit setUp 方法在允许每个测试用例的时候都会清空一次数据库,避免相互干扰,但是全局变量,类静态变量等会在个测试组件种形成干扰


个人常用的 phpUnit test 运行命令
`phpunit --verbose --bootstrap /home/wwwroot/www.note.git/public/index-test.php --filter testUpdate  ItemTest.php`