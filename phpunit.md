[todo]
### php Unit 使用总结
可能存在的bug:
当一个php PDOEXecption 被屏蔽后,phpunit 允许结果后显示 Segmentation fault (core dumped) 这个c语言级别的错误

dbUnit setUp 方法在允许每个测试用例的时候都会清空一次数据库,避免相互干扰,但是全局变量,类静态变量等会在个测试组件种形成干扰


个人常用的 phpUnit test 运行命令

> `phpunit --verbose --bootstrap /home/wwwroot/www.note.git/public/index-test.php --filter testUpdate  ItemTest.php`


codecept:

> codecept run codeception/acceptance/AboutCept.php


phpunit 隔离测试

> phpunit --process-isolation tests/


> 如果在低版本的 PHP unit test 中,放弃php 匿名类的使用的话,可以声明以不同的进程执行程序.期间可能由于安全原因, php_ini禁用了一些文件,重新启用这些程序就可以了.

