### shell编程基础
```
#!/bin/bash
firstName="li"; //must has no space between varible and operator "="
readonly lastName="jun";// define a const, by adding keywords "readonly",note that the keyword "readonly" is completely low case
# unset firstName;//add comments by adding # ,its the only way by adding comments
echo "his name is ${firstName}${lastName},length of the name is ${#firstName}";
echo ${firstName:1:2};//slice which is simular to python3.0 
array=(
    "shell is witten by c",
	"its  array is quite strange by using ()",
   "which is simular to php"
);
#it'S array is simular to lower version of php

echo ${array[0]};//is a good habit to using {} after $ in shell
```

表达式和运算符之间要有空格，例如 2+2 是不对的，必须写成 2 + 2，这与我们熟悉的大多数编程语言不一样。
完整的表达式要被 ` ` 包含，注意这个字符不是常用的单引号，在 Esc 键下边。

```
#! /bin/bash
val=`expr 1 + 1`;//#数字和运算符之间有空格
#val=`expr 2 + 2`
echo ${val};
echo "两数之和为 : $val";
```

