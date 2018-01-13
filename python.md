### python 头文件声明和字符编码声明

```
 #!/usr/bin/python
 # -*- coding:utf-8 -*-
```


熟悉了python 多文件组织方式
https://stackoverflow.com/questions/34384205/python-module-object-is-not-callable
http://blog.csdn.net/index20001/article/details/73501375


#True 首字母大写

```python
#!/usr/bin/python
if True:
	print("true")
else:
	print("false")
```

```
student = {'Tom','Jim','Mary','Tom','Jack','Rose'}
teacher = {'LiNing','QiaoDan','Tom'}
print(student)
if ('rose' in student ):
    print('rose在集合中:'+set(student+teacher))
else:
    print('rose不在集合中:'+set(student-teacher))
#endif
```

python中数字和字符串相加前需要转换

```
#!/usr/bin/python3
languages = ['C','C++','Perl','Python']
# print(len(languages))
for i in range(len(languages)):
	print(str(i)+" : "+languages[i]);
# end for
```



pip freeze
显示所安装的包


[python 包导入规则](http://codingpy.com/article/python-import-101/)



### python 与 php比较, 要注意的地方

```
try:
    f = open('/path/to/file', 'r')
    print(f.read())
finally:
    if f:
        f.close()


python 自动关闭文件的简写方式

with open('/path/to/file', 'r') as f:
    print(f.read())


__init__ 构造
__del__ 析构


python setter 和 getter
class Student(object):

    def get_score(self):
         return self._score

    def set_score(self, value):
        if not isinstance(value, int):
            raise ValueError('score must be an integer!')
        if value < 0 or value > 100:
            raise ValueError('score must between 0 ~ 100!')
        self._score = value



python 特有
@property
@score.setter

python 多重继承
class Dog(Mammal, RunnableMixIn, CarnivorousMixIn):



魔术方法:
__str__

可迭代
__iter__


相当于 PHP 的 arrayAccess 接口
__getitem__


getter 拦截器
__getattr__()

python __call__  与 php 不同, 是为构造去设置的, 不是很灵活


```


ubantu 下安装 python yaml 扩展

```
apt-get install python3-yaml
```


文档测试: python doctest

if __name__ == '__main__':
    import doctest
    doctest.testmod()

```
# mydict2.py
class Dict(dict):
    '''
    Simple dict but also support access as x.y style.

    >>> d1 = Dict()
    >>> d1['x'] = 100
    >>> d1.x
    100
    >>> d1.y = 200
    >>> d1['y']
    200
    >>> d2 = Dict(a=1, b=2, c='3')
    >>> d2.c
    '3'
    >>> d2['empty']
    Traceback (most recent call last):
        ...
    KeyError: 'empty'
    >>> d2.empty
    Traceback (most recent call last):
        ...
    AttributeError: 'Dict' object has no attribute 'empty'
    '''
    def __init__(self, **kw):
        super(Dict, self).__init__(**kw)

    def __getattr__(self, key):
        try:
            return self[key]
        except KeyError:
            raise AttributeError(r"'Dict' object has no attribute '%s'" % key)

    def __setattr__(self, key, value):
        self[key] = value

if __name__=='__main__':
    import doctest
    doctest.testmod()
```

python 中位运算

```python
'''
>>> 1 << 0
1
>>> 1 << 1
2
>>> 1 << 2
4
'''
bitmask
```
[how to use bitmask](https://stackoverflow.com/questions/18591924/how-to-use-bitmask#)



python 代码调试:

(https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000/001431915578556ad30ab3933ae4e82a03ee2e9a4f70871000)


```
assert n != 0, 'n is zero!'
print
logging
pdb.set_trace()
pdb
PyCharm Eclipse pydev
```


python 单元测试方法

```
另一种方法是在命令行通过参数-m unittest直接运行单元测试：

$ python3 -m unittest mydict_test

```


class Student(object):

    @property
    def score(self):
        return self._score

    @score.setter
    def score(self, value):
        if not isinstance(value, int):
            raise ValueError('score must be an integer!')
        if value < 0 or value > 100:
            raise ValueError('score must between 0 ~ 100!')
        self._score = value


可变参数:定义可变参数和定义一个list或tuple参数相比，仅仅在参数前面加了一个*号。在函数内部，参数numbers接收到的是一个tuple
所以Python允许你在list或tuple前面加一个*号，把list或tuple的元素变成可变参数传进去：

```
def calc(*numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum
```


```
>>> nums = [1, 2, 3]
>>> calc(*nums)
14
```



默认参数

定义默认参数要牢记一点：默认参数必须指向不变对象！

要修改上面的例子，我们可以用None这个不变对象来实现：

```
def add_end(L=None):
    if L is None:
        L = []
    L.append('END')
    return L
```



重复元素在set中自动被过滤：
set可以看成数学意义上的无序和无重复元素的集合，因此，两个set可以做数学意义上的交集、并集等操作：



只有一个元素时，元祖要消除歧义
t = (1,)

二是通过dict提供的get方法，如果key不存在，可以返回None，或者自己指定的value：

```
>>> d.get('Thomas')
>>> d.get('Thomas', -1)
-1
```

声明解释器和编码方式

```
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
```

第一行注释是为了告诉Linux/OS X系统，这是一个Python可执行程序，Windows系统会忽略这个注释；

第二行注释是为了告诉Python解释器，按照UTF-8编码读取源代码，否则，你在源代码中写的中文输出可能会有乱码。

申明了UTF-8编码并不意味着你的.py文件就是UTF-8编码的，必须并且要确保文本编辑器正在使用UTF-8 without BOM编码：

'中文'.encode('utf-8')

数组最后一个元素
classmates[-1]


IPython 交互
进入 IPYthon 交互界面

```
root@ubuntu:/home/ffz# python3
Python 3.5.2 (default, Sep 10 2016, 08:21:44) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```


https://www.crifan.com/python_detailed_explain_about___name___and___main__/comment-page-1/



### python 函数语法糖

*arg 可变参数
arg=defaultValue 默认参数
**kwarg keyworkd argument  传输时以 key2 = value2, key2 = value2 的形式传入 



