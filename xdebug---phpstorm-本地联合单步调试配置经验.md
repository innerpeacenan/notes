xdebug troubleShotting

* cli 模式下调试,运行:

export XDEBUG_CONFIG="remote_enable=1 remote_mode=req remote_port=9001 remote_host=127.0.0.1 remote_connect_back=0  xdebug.remote_log=/home/ffz/xdebug.log"

xdebug.remote_log 也可以不配置, 主要是方便定位问题. 官方的参考教程中, 提供的另一个命令行下运行的方式,在我的机器上是无效的.

* 注意: php-fpm 下,修改配置后,需要重启才能生效.(尽管知道这一点,但是在配置过程中还是吃亏啦)

参考资料:

https://confluence.jetbrains.com/display/PhpStorm/Debugging+PHP+CLI+scripts+with+PhpStorm#DebuggingPHPCLIscriptswithPhpStorm-Prerequisites

https://confluence.jetbrains.com/display/PhpStorm/Troubleshooting+PhpStorm+debugging#TroubleshootingPhpStormdebugging-XDebugcan'tconnecttoPhpStorm

其他方面参考官方教程, 整体比较简单.

其他方面的配置, 参考官方教程.

