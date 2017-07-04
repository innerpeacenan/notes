## ideaVIm的配置和使用 ##


## 鼠标放到phpstrom 图标上，滚动鼠标，可以快速切换窗口，非常方便

### 安装和激活

[install phpstorm](http://www.linuxdiyf.com/linux/19328.html)

[activate phpstorm 2016.2.1](http://idea.lanyus.com/)



### 开启和关闭 ###
重要功能: show annotation  close annotaion
Ctrol+tab 键可以在 最近的 tab 之间来回前换
    用`alt v`来进行切换
* phpstorm configuration and activation
* 快速切换到所标记的
> 在ideal vim中,目前大写的文件标记是不起作用的,因此,可以采用书签功能来查找和定位最常使用的文杰
  ,可以按<C>+F11设置书签,按shift+F11查找和管理书签,如果是数字键的书签的话,可以用<C>+number切换到对应的文件
  小写的文件内位置标志是可以用的
* ideal vim 可以读取文件 `~/.ideavimrc`


### phpstorm常用快捷键：
Ctrl + Shift + A 查找快捷键(最方便的方法)
比如搜索:"Call hierarchy",可以搜索一个php 方法在全项目中的应用位置的列表,可以跟踪到具体的每一个文件

Ctrl + Alt + S 打开设置对话框（与QQ冲突）

#### 编辑
```
注意 phpstorm 会对未保存的方法在编辑器头上有一个星号表示该文件还未保存,内容在内存中或者在缓冲区
Ctrl + J 活动代码提示(自动代码提示，自动补全)
F12 返回到以前的工具窗口
F2（Shift+F2） 下/上高亮错误或警告快速定位

CTRL+SHIFT+ALT+N 查找php类名/变量名 ,js方法名/变量名, css 选择器
CTRL+SHIFT+ALT+N 查找php类名/变量名 ,js方法名/变量名, css 选择器
```

#### 重构
```
SHIFT+F6 重命名,重构当前区域内变量重命名/重构 .不但可以重命名文件名，而且可以命名函数名，函数名可以搜索引用的文件，还可以重命名局部变量。还可以重命名标签名。
ALT + INSERT 生成的代码...器（getter，setter方法，构造函数）
Ctrl + I 实现方法
Ctrl + O 覆盖方法
```


#### 源码阅读
```
F4 查找变量来源

CTRL+H 显示类层级关系图，继承/实现关系

Ctrl+Shift+H 方法的层次结构 (方法的调用层次)

Ctrl + Shift+I 打开快速定义查询

CTRL+ALT+B 找到继承该接口或者父级 的所有子类, 统计所有子类个数
```


Reformatting code for the current file  `Ctrl+Shift+Alt+L`.
复制当前文件路径 `<ctr> <shift> c`

settings <C><win>  ,set for myself because the default shutcut is invalid under vmware (个人设置)

### important concept (重要概念)
* Run to Cursor (phpstorm 调试)
We may want to just run code until we reach the position where our cursor is located. After we place the cursor somewhere in our code and press Alt+F9, PhpStorm will run code until execution hits that spot.
Of course, if the location of the cursor is not in the execution path of our code (e.g. dead code or an if statement where we select a different code path), the IDE will not be able to pause execution at the cursor location.

CTRL+Q 显示代码注释
Ctrl+Shift+H 方法的层次结构



### phpstorm + xdebug + linux
make sure xdebug enabled remote debugging and profiling


