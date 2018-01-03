# linux

> Regular expressions are sensitive to the locale in which the program runs; in particular,ranges within a bracket expression should be avoided in favor of character classes such as `[[:alnum:]]`.

> The “longest leftmost” rule describes where text matches and for how long the match extends. This is important when doing text substitutions with sed, awk,or an interactive text editor. It is also important to understand when there is a distinction between a line and a string. In some programming languages,a single string may contain multiple lines,in which case ^ and $ usually apply to the beginning and end of the string.


perl 正则表达式为 extended regular expression
vim 为 basic regular expression


php 正则表达式处理 utf-8 字符(php 中一共三种正则表达式,其中一种已经弃用了,一种用于匹配 utf8)

> The last set is a variant of the `ereg` set, prefixing mb_ for "multibyte" to the function names. While `ereg` treats the regex and subject string as a series of 8-bit characters, mb_ereg can work with multi-byte characters from various code pages. If you want your regex to treat Far East characters as individual characters, you'll either need to use the mb_ereg functions, or the preg functions with the /u modifier. mb_ereg is available in PHP 4.2.0 and later. It uses the same POSIX ERE flavor.

在正则表达式中,<和>都不是特殊字符

* url 匹配

```php
preg_replace('/^(http|https):\/\/[^\/]+/i', '', $requestUri);
```

### bash basic regular expression

* 向后引用
> Back references are particularly useful for finding duplicated words and matching quotes:

```
Table 3-8. Unix programs and their regular expression type
Type 	grep 	sed 	ed 	ex/vi 	more 	egrep 	awk 	lex
BRE 	? 		? 		? 		? 	?
ERE 										? 		? 		?
\< \> 	? 		? 		? 		? 	?
```

##### 在basic regular expression 中,引号不是特殊字符,因此,分组用`\(` 和`\)` 表示
`\(["']\).*\1`

Match single- or double-quoted words, like 'foo' or "bar"

In an ERE, `\(` and `\)` match literal left and right parentheses.

Note that here the parentheses are metacharacters,not input text to be matched
在basic regular expression中，()不是元字符，所以分组用`\(\)`
而在Extend regular expression中，()是元字符,含义为匹配()内的内的内容的两边字符。

The most common extensions are the operators `\<` and `\>`,which match the beginning and end of a “word,” respectively.

`\< \>` Matches the beginning and end of a word, as described previously.

\b Matches the null string found at either the beginning or the end of a word. This is a generalization of
the `\<` and `\>` operators.


### 向后引用
 * 正则表达式组名使用的例子
```
# 匹配两个重复的单词，单词中间以空格分隔
查找  \b(?<Word>\w+)\b\s+\k<Word>\b
查找  \b(\w+)\b\s+\1\b
# 匹配形如 .ok?  的字符串
查找:  \.(?<name>\w+)\?
```

### 零宽断言
零宽断言最终总结:(要理解贪婪模式的一些特征)
[这是一篇非常好的博客文章,我的内容也主要引用子这里:](http://www.cnblogs.com/China3S/archive/2013/11/30/3451971.html)

记忆方法:

: 表示不捕获

! 表示非

< 表示匹配口张开的位置,及后边

<! 匹配前面的,相当于对匹配的方向进行了一次否定

`<name>` 表示给捕获的匹配起别名

*  (?=exp)  匹配exp前面的位置

```
#匹配以ing结尾的单词
\b(\w+)(?=ing\b)
# I'm singing while you're dancing

# 匹配单词how后边的部分
(?<txt>.+(?=ing))
如 "How are you doing" 正则"(?<txt>.+(?=ing))" 这里取ing前所有的字符，并定义了一个捕获分组名字为 "txt" 而"txt"这个组里的值为"How are you do";
```

*  (?!exp)  匹配后面跟的不是exp的位置

```
#正则 匹配3位数字后非数字的结果
\d{3}(?!\d)
# "123abc"   "1235abc" 
#配置结果为123 和 235
如 "123abc" 正则 "\d{3}(?!\d)"匹配3位数字后非数字的结果
```

*  (?<=exp)  匹配exp后面的位置

```
#配以re开头的单词的其余部分
(?<=\bre)(\w+)\b
# readingre research apache restart reboot repeat
# 结果为: ading search start boot peat
如 "How are you doing" 正则"(?<txt>(?<=How).+)" 这里取"How"之后所有的字符，并定义了一个捕获分组名字为 "txt" 而"txt"这个组里的值为" are you doing";
```

*  (?<!exp)  匹配前面不是exp的位置

```
# 正则匹配"123"前面是非数字的结果也可写成"(?!<\d)123"
(?<![0-9])123
#如 "abc123123" 
#结果为123
//匹配之前没有大写字母的一个大写字母
preg_replace('/(?<![A-Z])[A-Z]/', '--', $name)
如 "abc123 " 正则 "(?<![0-9])123" 匹配"123"前面是非数字的结果也可写成"(?!<\d)12
```

"(exp)"    匹配exp,并捕获文本到自动命名的组里

"(?<name>exp)"   匹配exp,并捕获文本到名称为name的组里

"(?:exp)"  匹配exp,不捕获匹配的文本，也不给此分组分配组号


如 ipv4 地址验证:

```
// ipv4 正则
(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))
```

### 非贪婪匹配:

非贪婪模式实在匹配的个数后边加一个 `?`, 使得正则匹配放弃 left most 原则

正则表达式 这里的 `？` 表示最小匹配，即非贪婪模式

```
(.*?)
```



### 正则示例
```
匹配HTML标记的正则表达式：    /<(.*)>.*<\/\1>|<(.*) \/>/

匹配首尾空格的正则表达式：    (^\s*)|(\s*$)

匹配Email地址的正则表达式：   \w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*

匹配网址URL的正则表达式：     http://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?

^\d+$　　                         //匹配非负整数（正整数 + 0）

^[0-9]*[1-9][0-9]*$　　           //匹配正整数

^((-\d+)|(0+))$　　               //匹配非正整数（负整数 + 0）

^-[0-9]*[1-9][0-9]*$　　          //匹配负整数

^-?\d+$　　　　                   //匹配整数

^\d+(\.\d+)?$　　                 //匹配非负浮点数（正浮点数 + 0）

^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$　　//匹配正浮点数

^((-\d+(\.\d+)?)|(0+(\.0+)?))$　　//匹配非正浮点数（负浮点数 + 0）

^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$　　//匹配负浮点数

^(-?\d+)(\.\d+)?$　　             //匹配浮点数

^[A-Za-z]+$　　                   //匹配由26个英文字母组成的字符串

^[A-Z]+$　　                      //匹配由26个英文字母的大写组成的字符串

^[a-z]+$　　                      //匹配由26个英文字母的小写组成的字符串

^[A-Za-z0-9]+$　　                //匹配由数字和26个英文字母组成的字符串

^\w+$　　                         //匹配由数字、26个英文字母或者下划线组成的字符串


^[\w-]+([_-.][\w-]+)*@[\w-]+(\.[\w-]+)+$  //匹配email地址

^[a-zA-z]+://匹配(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\S*)?$　　//匹配url

(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])) 匹配ip地址

```

正则修饰符 `s`

Free-Spacing Regular Expressions

> In free-spacing mode, whitespace between regular expression tokens is ignored. Whitespace includes spaces, tabs, and line breaks. Note that only whitespace between tokens is ignored. a b c is the same as abc in free-spacing mode.

