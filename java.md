# 环境搭建
[java 算法环境搭建](http://algs4.cs.princeton.edu/linux/)
### javac 命令参数详解决

```
-cp path or -classpath path
              Specifies where to find user class files, and (optionally) annotation processors and source files. This class path overrides the
              user class path in the CLASSPATH environment variable. If neither CLASSPATH, -cp nor -classpath is specified, then the user
              class path is the current directory. See Setting the Class Path.

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
If you specify -d/home/myclasses and the class is called com.mypackage.MyClass, then the class file is
              /home/myclasses/com/mypackage/MyClass.class.

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

用法示例:
javac-algs4 chapter2/TopM.java  -d "../bin/chapter2"
```


