问题背景: 在一个python 项目中, 如何组织文件? 

首先有一个简单的项目开始, 现在这个项目只有两个文件, 如何在一个模块中引入另外一个模块定义的方法呢? (这里可以暂时将一个文件看做一个模块)

参考:
http://blog.csdn.net/u010412719/article/details/47089883


作为 PHP 工程师, 可能想当然的以为python 中引入另外一个模块,就可以直接用里边的变量了, 然而并不是这样的, 引用的变量应该为模块的成员变量存在(但实际上我并没有定义类).假设 要在 str.py 里边引入 tables.py 里边的变量 tableNames, 引用的方式为:  tables.tableNames.
既然这一点与php不同, 你可能很自然的会想到, 要不用 global 关键字引入全局变量吧, 经过尝试, 发现报变量 tableNames 不存在, 查阅资料后,发现global 旨在模块内部其作用, 相当于c语言中的文件作用域的概念. 当然 php 中没有这个概念.
要在python3.5 中定义变量, 只能通过引入一个模块, 通过模块的方法去操作其成员变量.


https://www.cnblogs.com/suwings/p/6358061.html

参考python 中 globalDemo 目录

* python 换行:

python代码换行就是每行后面加个 \

元组可跨行写, 不影响.
