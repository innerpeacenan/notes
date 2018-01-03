

### 启用全局代理的方式:(目前还存在一些问题,待进一步研究)

1.关闭防火墙
> sudo ufw disable

2.打开 shadowsock,

> ss-qt5

3.导入windows 相应的配置,允许 lan 共享

> settings-> network-> network proxy -> ssh部分输入: 127.0.0.1, 端口输入配置文件中设置的端口,如1080