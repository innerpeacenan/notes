### python 头文件声明和字符编码声明

```
 #!/usr/bin/python
 # -*- coding:utf-8 -*-
```

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