## 环境搭建

[java 算法环境搭建](http://algs4.cs.princeton.edu/linux/)


* java 的各个版本

> Java发展到现在，按应用来分主要分为三大块：J2SE,J2ME和J2EE。这三块相互补充，应用范围不同。

> J2SE就是Java2的标准版，主要用于桌面应用软件的编程；

> J2ME主要应用于嵌入是系统开发，如手机和PDA的编程；

> J2EE是Java2的企业版，主要用于分布式的网络程序的开发


* [jar, war, ear 的区别] (http://blog.csdn.net/mashengwang/article/details/6105189)



### eclipse 管理和查看maven 项目的方式和方法 

下载最新版本的eclipse(集成maven项目), 在导入项目中, 找到导入 maven 项目的选项,

maven 帮助下载 eclcipse 的源代码和文档, 方便 eclipse 进行代码跟踪:

> mvn eclipse:eclipse -DdownloadSources -DdownloadJavadocs

[j2e下载](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/kepler/SR2/eclipse-jee-kepler-SR2-linux-gtk-x86_64.tar.gz&mirror_id=105)

我的java安装文件存放位置: /etc/opt 完整版的 eclipse 目前存放在这个位置

### javac 命令参数详解决

```
-cp path or -classpath path
              If neither CLASSPATH, -cp nor -classpath is specified, then the user class path is the current directory. 

-g            Generates all debugging information, including local variables. By default, only line number and source file information is
              generated.(该选项类似c99 -g ,方便调试用)

-encoding UTF-8 (编码方式声明)


-Xlint:all
              Enables all recommended warnings. In this release, enabling all available warnings is recommended.

-Xlint:none
              Disables all warnings.

-d directory  声明.class文件存放的位置
              Sets the destination directory for class files. The directory must already exist because javac does not create it. If a class is part of a package, then javac puts the class file in a subdirectory that reflects the package name and creates directories as
              needed.
If you specify -d/home/myclasses and the class is called com.mypackage.MyClass, then the class file is /home/myclasses/com/mypackage/MyClass.class.

              If the -d option is not specified, then javac puts each class file in the same directory as the source file from which it was
              generated.

              Note: The directory specified by the -d option is not automatically added to your user class path.
```


#### root用户的配置实例

```
# bash name: javac-algs4
# This must match the install directory
INSTALL=~/algs4
# Sets the path to the classpath libraries
jars=(.:${INSTALL}/algs4.jar)
javac -cp "$jars" -g -encoding UTF-8 -Xlint:all -Xlint:-overrides "$@"

javac-algs4 chapter2/TopM.java  -d "../bin/chapter2"
//javac 可以将多个依赖的文件放到一起编译
//MammalInt.java 实现了 Animal.java 中的接口
javac Animal.java  MammalInt.java
java animal/MammalInt
//指定编译目录
javac -d ../bin Test.java
```
### java 

```
//java 启用断言
java 引入jar包
java -cp ./:/home/ffz/Desktop/jsoup-1.8.1.jar  Test
java -enableassertions Test
```


### 小技巧

* java 程序入口查找

```
grep -F 'public static void main(String[] args)' -r dubbo-demo/*
```
* ubuntu maven 安装

```
mvn -v
apt install maven
```

### java 语法(与 php 的去吧)

java 里边, 访问类的成员变量的时候, 可以省略关键词 this

```
public static void main(String[] args) throws ParseException, IOException { }
// java 的 toString 方法
public String toString(){ return super.getName(); }
```

[public class是公共类的意思，public 是访问修饰符．java规定，一个类文件，public 修类的class只有一个，并且类名必须和你新建的这个类文件名一样，所以一个类文件中可以有多个类，但由public修饰的类只能有一个](http://blog.csdn.net/netuser1937/article/details/54310925)


IO 操作

* java.util.Scanner

Scanner默认使用空格作为分割符来分隔文本，但允许你指定新的分隔符

```
Scanner s = new Scanner();
s.next() 读一个单词
s.nextline() 读取一行
```

参考:

http://blog.51cto.com/lavasoft/182467

http://blog.csdn.net/scythe666/article/details/51980596


[java-difference-between-filewriter-and-bufferedwriter](https://stackoverflow.com/questions/12350248/java-difference-between-filewriter-and-bufferedwriter)


java 错误类型收集:


### java 常见错误信息

* bug:incompatible types: unexpected return value (return type is void, so do not need to return)

* error: cannot find symbol

```
// 错误原因:  未导入包, 应该加入 java.util.*;
        Set<Integer> s1 = new HashSet<Integer>();
```

* HashSetTest.java:12: error: incomparable types: String and Set<Integer>

错误原因: 类型不对


* String 类型的相等比较(因为 String 类型是对象,即应用类型,而非基本类型)

```
// s1 是集合
assert "[4, 5]" == s1 : "why?";
```
> == tests for reference equality (whether they are the same object).
> .equals() tests for value equality (whether they are logically "equal").



java 错误提示码:

non-static method getParent() cannot be referenced from a static context

