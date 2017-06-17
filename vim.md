### vimrc vim 配置文件
#### vim 配置文件注释的方法
配置文件注释 用双引号注释(")

* vim 查看错误类型

> Vim has a builtin help system, I just quoted what it says to :h E212.
如提示错误为:
```
:E212
```
在 vim 命令模式下,
```
:h E212
```

### 文件编辑和保存
> 当打开文件编辑完成后发现自己没有权限编辑该文件的时候
> You might want to edit the file as a superuser like sudo vim FILE. Or if you don't want to leave your existing vim session (and know have proper sudo rights), you can issue:
```
  :w !sudo tee % > /dev/null
```
Which will save the file.


### vim find in line
* vim ,(向前重复行内查找) ;(向后重复行内查找)   .(重复上次编辑命令)
> vim还有一个快捷键是;（分号），这个快捷键的作用就是重复上一次`find动作。
> 还有一个是逗号,是重复向前搜索的意思

* 快速移动
> 重要说明:word 是字面意义上的单词，比如<go!to!school!>则，go，to，school分别都是单词.。而WORD是之间没有空白的一串字符。
```
w                右移光标到下一个字的开头；
e                右移光标到一个字的末尾；
b                左移光标到前一个字的开头；
0                数字０，左移光标到本行的开始；
$                右移光标，到本行的末尾；
^                移动光标，到本行的第一个非空字符。
W                移动光标到下一个非空白符位置
E                移动光标到下一个非空白符符号末尾
```

### vim yank paste 粘贴复制
* vim 允许使用剪贴板的快捷键
apt-get install vim-gnome 装vim-gnome，可以使用clickboard
> I find the standard "+gP and "+y commands very difficult to use. So I've remapped Ctrl-Y for yanking into the clipboard and Ctrl-P to paste from the clipboard. Add this to .vimrc
```
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP
```

#### 格式化粘贴
```
gp，和p的功能基本一致，只是粘贴完，它会把光标移动至粘贴内容之后；gP同理
```

#### 配对操作符
> Use whatever navigation key you want to get inside the parentheses, then you can use either yi( or yi) to copy everything within the matching parens. This also works with square brackets (e.g. yi]) and curly braces. In addition to y, you can also delete or change text (e.g. ci), di]).
> I tried this with double and single-quotes and it appears to work there as well. For your data, I do:
write (*, '(a)') 'Computed solution coefficients:'
Move cursor to the C, then type yi'. Move the cursor to a blank line, hit p, and get
Computed solution coefficients:
As CMS noted, this works for visual mode selection as well - just use vi), vi}, vi', etc.


* yand to vim command line
1.从vim中拷贝字符串到:命令行：
先yank字符串
然后在:命令行 `ctrl-r"` (不要忘记手动输入最后一个双引号)



### vim 查找和替换
[search and repalace](http://vim.wikia.com/wiki/Search_and_replace)
替换时，除*以外的换行符都要在开头部分转义，这一点需要特别注意
```
*	    匹配0-任意个
\+	    匹配1-任意个
\?	    匹配0-1个
\{n,m}	匹配n-m个
\{n}	匹配n个
\{n,}	匹配n-任意个
\{,m}	匹配0-m个
```

操作结束后，会在每行留有一个$符号，因此，该行不会被删除，下面几个例子同理
```
删除行首多余空格： `%s/^ *//`
删除沒有內容的空行：`%s/^$//` 或者 `g/^$/d`   %s/^$//
删除包含有空格组成的空行：%s/^\s*$// 或者 g/^\s*$/d
删除以空格或TAB开头到结尾的空行：%s/^[ |\t]*$// 或者 g/^[ |\t]*$/d
把文中的所有字符串“abc……xyz”替换为“xyz……abc”可以有下列写法
```

### 代码格式调整
#### 缩进
> 正常模式下，按两下>;光标所在行会缩进。
如果先按了n，再按两下>;，光标以下的n行会缩进。
对应的，按两下<;，光标所在行会缩出。
如果在编辑代码文件，可以用=进行调整。
在可视模式下，选择要调整的代码块，按=，代码会按书写规则缩排好。
或者n =，调整n行代码的缩排

#### vim 代码展开折叠
```
zo -- 打开折叠的文本；
zc -- 收起折叠；
zR (zO) -- 打开所有折行；
zM (zC) -- 收起所有折行
zj -- 跳到下一个折叠处；
zk -- 跳到上一个折叠处
```


### vim 多文件编辑
多 buffer 模式下:(通常用 vim 在同一个 shell 下一次性打开的多个文件处于这种模式)
eg.
```
vim vim hello.txt passwd.txt
:bd 会关闭hello.txt
:bd 会关闭passwd.txt
```
> **b** 表示 buffer ,p 表示 previous, n 表示 next

```
:bp 向前跳转
:bn 向后跳转
:prev 前一个tab
:n 下一个tab
:bd 关闭当前buffer
```


### vim 多窗口编辑
```
:split(:sp) -- 把当前窗水平分割成两个窗口。(CTRL-W s 或 CTRL-W CTRL-S) 注意如果在终端下，CTRL-S可能会冻结终端，请按CTRL-Q继续。
:split filename -- 水平分割窗口，并在新窗口中显示另一个文件。
:nsplit(:nsp) -- 水平分割出一个n行高的窗口
<C> ww 两个窗口来回切换
<C> w j/k 窗口跳转
```
### 命令行快捷键
```
C-b： 移动到命令行开头。
C-e： 移动到命令行末尾。
Shift-Left： 左移一个单词。
Shift-Right： 右移一个单词。
r !cmd 将命令的返回结果插入文件当前位置
```

### 位置
```
ctrl+f: 下翻一屏。
ctrl+b: 上翻一屏。
ctrl+d: 下翻半屏。
ctrl+u: 上翻半屏。
ctrl+e: 向下滚动一行。
ctrl+y: 向上滚动一行。
[/: 跳转到当前注释块开始处；
]/: 跳转到当前注释块结束处；
n%: 到文件n%的位置。
zz: 将当前行移动到屏幕中央。
zt: 将当前行移动到屏幕顶端。
zb: 将当前行移动到屏幕底端
Ctrl+] 就可以自动跳转至定义
Ctrl+t 可以返回上一次查看位置。这样就可以快速的在代码之间“游动”了。
```

### 文件标记
```
m{a-z}: 标记光标所在位置，局部标记，只用于当前文件。
// 大写字母跨文件标记目前在 idealvim 中是不支持的
m{A-Z}: 标记光标所在位置，全局标记。标记之后，退出Vim,重新启动，标记仍然有效。
```



### vim 大小写切换
[toggle case of all characters to end of line.]( http://vim.wikia.com/wiki/Switching_case_of_characters)

```
g~$
```

> Visual select the text, then U for uppercase or u for lowercase.
To swap all casing in a visual selection, press ~.
Without using a visual selection, gU<motion> will make the characters in motion uppercase,
or use gu<motion> for lowercase.




