
aptitude install python3-dev

采用第二种方案,内容如下:

```
1)     libexpat1 [2.1.0-7ubuntu0.16.04.2 (now) -> 2.1.0-7 (xenial)]   
2)     libpython3.5 [3.5.2-2~16.04 (now) -> 3.5.1-10 (xenial)]        
3)     libpython3.5-minimal [3.5.2-2~16.04 (now) -> 3.5.1-10 (xenial)]
4)     libpython3.5-stdlib [3.5.2-2~16.04 (now) -> 3.5.1-10 (xenial)] 
5)     python3.5 [3.5.2-2~16.04 (now) -> 3.5.1-10 (xenial)]           
6)     python3.5-minimal [3.5.2-2~16.04 (now) -> 3.5.1-10 (xenial)]  
```

安装依赖librdkafka
```
git clone https://github.com/edenhill/librdkafka.git
cd librdkafka/
./configure
make
make install
```

开始安装安装包(包含confluent-kafka==0.11.0)
```
cd /var/www/deploy/beeper_binlog_collector/
pip intall -r requirements.txt 
```

