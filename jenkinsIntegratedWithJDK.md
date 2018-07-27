(1) 首先,确认自己安装了 jdk, 通过运行

javac -version 查看 javac 版本, 结果如下:

```
 javac 1.8.0_03-Ubuntu
```

如果只安装了jre的话, 是不会有 javac 的. 因此确认自己安装了jdk, 通过 java -version 的第一行也得到了印证, 如下:

```
 openjdk version "1.8.0_03-Ubuntu"
 OpenJDK Runtime Environment (build 1.8.0_03-Ubuntu-8u77-b03-3ubuntu3-b03)
OpenJDK 64-Bit Server VM (build 25.03-b03, mixed mode)
```
接下来要做的就是找到 JAVE_HOME, 我的 jdk安装的时候,未设置该变量. 具体如下:

```
root@:/usr/share/java$ls -alF  /usr/bin/javac
lrwxrwxrwx 1 root root 23 Mar 31  2017 /usr/bin/javac -> /etc/alternatives/javac*
```

注意, etc/alternatives/javac 这个文件仍然带有 * , 说明其仍然是个连接, 进一步追踪.

```
ll /etc/alternatives/javac
lrwxrwxrwx 1 root root 43 Mar 31  2017 /etc/alternatives/javac -> /usr/lib/jvm/java-8-openjdk-amd64/bin/javac*
```

以此确认 jdk 的 home 路径为 /usr/lib/jvm/java-8-openjdk-amd64 

**jdk home 路径在 javac 的可执行目录 bin 的上一层.**

(2) 参考 maven 在 jenkins 上的集成方法, 填写相关项.


参考: 
https://stackoverflow.com/questions/24974725/jenkins-not-finding-java-home






jenkins 在使用过程中的一些经验:
找到 jenkins.war 安装包的位置,

```
find / -name "jenkins.war" -type f

java -jar /usr/share/jenkins/jenkins.war
```


安装完成后,提示初始化生成的用户和密码:

```
4d254b2ca1654375a8a24a47ed217f43
This may also be found at: /root/.jenkins/secrets/initialAdminPassword
```
jenkins 的 pipeline 默认路径: `~/.jenkins/workspace/pipeline$`

[jenkins 的官方文档需要继续看](https://jenkins.io/doc/book/pipeline/jenkinsfile/),

今天获得的主要收获为:
(1) 了解了 `jenkins` 的运行 shell 的方式
(2) 了解了 jenkins 部署时间的设置问题, 因为默认的时间很容易不够用而导致超时反复刷新的问题

