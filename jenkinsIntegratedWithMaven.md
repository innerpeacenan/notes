说明,  本教程使用的 jenkns 版本信息如下:

/usr/share/jenkins/jenkins.war  --version
ls (GNU coreutils) 8.25
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Richard M. Stallman and David MacKenzie.

集成步骤如下:

(1) 用 `mvn --version` 查看 maven 的安装信息, 其中就包含 Maven home:

```
Apache Maven 3.3.9
Maven home: /usr/share/maven
Java version: 1.8.0_03-Ubuntu, vendor: Oracle Corporation
Java home: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "4.4.0-45-generic", arch: "amd64", family: "unix"
```
这里. Maven home: /usr/share/maven.

(2) [在 jenkins 中添加 maven home路径,并保存](http://note.youdao.com/noteshare?id=a193fe155ae595232549581a527d1b65)

参考资料:
http://kentyeh.github.io/mavenStartup/