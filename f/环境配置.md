* 问题描述:xampp+zend framwork(apache version 2.4) 配置虚拟host     
* 之前很多教程在这一块都存在问题，主要是apache 2.4 以后的版本里，使用
```
Require all granted 
```
替代了
```
Order Allow, Deny
Allow from all
```
所以在<Directory>下增加Require all granted
```
<VirtualHost *:80>
       DocumentRoot "D:\nxn\public"
       ServerName nxn
       <Directory "D:\nxn\public">
                Allow from all
                AllowOverride All
                Require all granted
				#Require all granted 这是关键的一句
        </Directory>	   
</VirtualHost>

```
[参考帖子](http://blog.csdn.net/lilanfei/article/details/40377503)



## 配置过程:
Composer (version 1.4.1) successfully installed to: /home/ffz/Downloads/composer.phar

Use it: php composer.phar

sudo mv composer.phar /usr/local/bin/composer