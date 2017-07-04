## 编译和运行

最简单最常用的编译和运行方式
```
//编译
gcc -g filename -o outputfilename

//运行
./outputfilename
```

## gcc 编译器
options:
-g  Produce debugging information in the operating system's native
    format (stabs, COFF, XCOFF, or DWARF 2).  GDB can work with this
    debugging information.
    带调试信息(有这个选项才能用gdb)

-ggdb
     Produce debugging information for use by GDB.  This means to use
     the most expressive format available (DWARF 2, stabs, or the native
     format if neither of those are supported), including GDB extensions
     if at all possible.

-o 输出文件名称

-llibrary 编译时候引入外部库

<p>为使编译器能将 <strong>sin</strong> 链接进主程序‘calc.c’，我们需要提供数学库‘libm.a’。一个容易想到但比较麻烦的做法是在命令行中显式地指定它：</p>

<blockquote><p>$ gcc -Wall calc.c /usr/lib/libm.a -o calc</p></blockquote>

为避免在命令行中指定长长的路径，编译器为链接函数库提供了快捷的选项‘-l’。例如，下面的命令
```
$ gcc -Wall calc.c -lm -o calc
```

一般来说，选项 `-lNAME` 使链接器尝试链接系统库目录中的函数库文件 `libNAME.a` 。一个大型的程序通常要使用很多 `-l` 选项来指定要链接的数学库，图形库，网络库等。

文档上说 `-l` 和 `NAME` 部分不推荐分开
Search the library named when linking.  (The second alternative with the library as a separate argument is only for POSIX compliance and is not recommended.)

其中典型的应用为: m 表示math 库
```
// how link works  and what is -lm for gcc
gcc -g test.c -o test.out -lm
```
[c 语言 eclipse编辑器为math库添加编译条件](http://dystopiancode.blogspot.jp/2011/10/solving-gcc-mathh-linking-problem-in.html):


the -c option says not to run the linker.  Then the output consists of object files output by the assembler.

-fmessage-length=n
           Try to format error messages so that they fit on lines of about n characters.  If n is zero, then no line-wrapping is done; each error message appears on a single line.  This is the default for all front ends.

The gcc program accepts options and file names as operands.  Many options have multi-letter names; therefore multiple single-letter options may not be grouped: -dv is very different from -d -v.

-M  Instead of outputting the result of preprocessing, output a rule
           suitable for make describing the dependencies of the main source
           file.  The preprocessor outputs one make rule containing the object
           file name for that source file, a colon, and the names of all the
           included files, including those coming from -include or -imacros
           command-line options. Unless specified explicitly (with -MT or -MQ), the object file name
           consists of the name of the source file with any suffix replaced
           with object file suffix and with any leading directory parts
           removed.  If there are many included files then the rule is split
           into several lines using `\-`newline.  The rule has no commands.
-m32
-m64
      Generate code for 32-bit or 64-bit environments of Darwin and SVR4 targets (including GNU/Linux).  The 32-bit environment sets int,

## makefile
[makefile](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)
make会在当前目录下找名字叫“Makefile”或“makefile”的文件。

$?
The names of all the prerequisites that are newer than the target, with spaces between them. For prerequisites which are archive members, only the named member is used (see Archives).

$^
The names of all the prerequisites, with spaces between them. For prerequisites which are archive members, only the named member is used (see Archives). A target has only one prerequisite on each other file it depends on, no matter how many times each file is listed as a prerequisite. So if you list a prerequisite more than once for a target, the value of `$^` contains just one copy of the name. This list does not contain any of the order-only prerequisites; for those see the ‘$|’ variable, below.


多个编译目标文件,直接调用make默认只执行第一个编译目标
make rand_int_avg.out

```
PROJDIR := $(realpath $(CURDIR)/../)
BIN := $(PROJDIR)/bin

# note -Wall is start with Upercase W
CFLAGS = -g -Wall
# command make on linux will find file with its name as Makefile ,then try to explain it and then excute it
TARGETS = *.out

rand_float_avg.out: float.c  Num.h  avg.c
# Note that there is exactly one tab before the gcc command on the second line (this is important in makefiles).
	gcc $^ $(CFLAGS) -o $@
rand_int_avg.out: int.c Num.h avg.c
	gcc $^ $(CFLAGS) -o $@
# This is a somewhat common rule to have in makefiles as it allows you to quickly remove all of the binaries. you produced simply by typing $> make clean. By typing make clean you tell the make program to run the clean rule and then make will run the rm command to delete all of your targets.
clean:
	rm $(TARGETS)
```

两种变量定义的方式
= 与 := 的区别







## c 语言语法

### 初学 c 语言最容易犯的错误

结构体的格式要牢记 (成员之间用; 结构体结尾用;)
// unnamed struct/union that defines no instances

// 结构体后面需要加结构体变量的名称

// 结构体定义

```
struct house {
float sqft;
int rooms;
int stories;
char address[40];
};
// 初始化
struct house fruzt = {1560.0, 6, 1, "22 Spiffo Road"};
```

// expected identifier or ‘(’ before ‘[’ token

// 数组的写法上要与java区分开来

```
char abbr[3] ;
```

c 语言中指针的声明和赋值不能同时进行

c 语言中不存在 !== ,虽然知道c是强类型语言,但php写惯了,老范这个错误



单引号为字符，双引号为字符串


define 后边不能很 ";"
> error: expected ‘)’ before ‘;’ token.  do not use ; for define ,it is just macro for preprocessor, not for c compiler

a 只有为指针的情况下,才可以 以 -> 的方式访问结构体的成员
`ia->x` is use only if a is a pointer that point to rect

注意, c 语言种,函数名称和变量名称都是标识符,
> called object ‘distance’ is not a function or function pointer.  the name of variable could not be the same with function

(位运算符与指数函数区分开)
```
    Bitwise operators are used in C programming to perform bit-level operations.

    Operators	Meaning of operators
    ^	Bitwise exclusive OR
    <<	Shift left
    >>	Shift right
```

Binary Floating Point 浮点数比较大小

```
assert( dist - 6.71 < EPSILON );

```

```
// format ‘%S’ expects argument of type ‘wchar_t *’, but argument 3 has type ‘char *’
// 字符串格式化输出用 %s, 不要写成了大写
printf("there are %d days till the end of %s",days,year[monthNum - 1].name);

```

do while 语句的写法
```
do {
   statement(s);
} while( condition );
```

打印指针位置

```
printf("%p \n",link p);
```
打印8进制和16进制

```
printf
%0   八进制
%x   十六进制
```

利用宏定义更加友好的 printf 函数


```
#define PR(X, ...) printf("Message " #X ": " __VA_ARGS__) /*注意书上直接粘贴过来有错误*/
int main(void)
{
    double x = 48;
    double y;
    y = sqrt(x);
    PR(1, "x = %g\n", x);
    PR(2, "x = %.2f, y = %.4f\n", x, y);
    return 0;
}

```


```
 if (scanf("%d",&n) != 1)
       {
           puts("That's no integer!");
           atexit(too_bad); /* register the too_bad() function */
           exit(EXIT_FAILURE);
       }

```

argc argv c语言终端输入:

```
main (int argc, char *argv[]){
// argc is an integer parameter, and it is the number of arguments passed to the program.
// Parameter argv points to a string array and is called the "argument vector". It is a one dimensional string array of function arguments.
}
```

内存管理 malloc 不能保证内存分配成功
```
struct SomeStruct *s = malloc(sizeof *s);
if (s)
{
    s->someValue = 0; /* It never fails, as we have checked malloc for not returning NULL. */
}
```

#### 防止内存泄露和重复释放内存
All allocations must follow the same pattern:
* Allocation using malloc (or calloc)
* Usage to store data
* De-allocation using free

> Failure to adhere to this pattern, such as using memory after a call to free (dangling pointer) or before a call to malloc (wild pointer), calling free twice ("double free"), etc., usually causes a segmentation fault and results in a crash of the program.

理解了野指针和内存泄露和危害
```
特别注意在stack上的变量,没有地址可以引用.会发生错误
Creating pointers to stack variables
```

[c语言内存分配位置](http://stackoverflow.com/questions/14588767/where-in-memory-are-my-variables-stored-in-c)



#### 内存泄漏检查工具
>  Valgrind is an invaluable tool for identifying what memory is leaked and where it was originally allocated.

## 指针 pointer
> It is common practice to use pointers to structs as parameters in functions, rather than the structs themselves. Using the structs as function parameters could cause the stack to overflow if the struct is large. Using a pointer to a struct only uses enough stack space for the pointer, but can cause side effects if the function changes the struct which is passed into the function.

### Pointer to a const int (真正指向的内容不能通过指针改变)

The pointer can point to different integers but the int's value can't be changed through the pointer.
```
int b;
const int* p;
// b 是整型,&p 为 b 的内存地址
p = &b;    /* OK */
*p = 100;  /* Compiler Error */
```

### 指针方面的重要概念
Dangling Pointer
```
If any pointer is pointing the memory address of any variable but after some variable has deleted from that memory location while pointer is still pointing such memory location. Such pointer is known as dangling pointer and this problem is known as dangling pointer problem.
```

## functions
### c语言getchar()
getchar()是从键盘上读入一个字符，并带回显。getchar()函数等待输入直到按回车才结束，回车前的所有输入字符都会逐个显示在屏幕上。但只有第一个字符作为函数的返回值。

printf

%0   八进制
%x   十六进制

### 为指针指向的内容分配内存空间的两种较好实践
```
Portable allocation:
 long *longPtr = malloc(sizeof(long)*1000);  /* allocating storage for 1000 long */
Or, better still:
 long *longPtr = malloc(sizeof(*longPtr)*1000);  /* allocating storage for 1000 long */
```


static 关键字

[static key word](http://blog.csdn.net/21aspnet/article/details/1535573)












## gdb 带参数调试
gdb start 传入的参数

gdb:
```
run [arglist]
           Start your program (with arglist, if specified).
```

### eclipse 程序运行参数添加方法
I guess your problem is that you don't know hot to pass argument to you program, when you execute it through eclipse isn't it ?

If that is what you want, read the following.

eclipse 下配置运行时的库

Click on the "Project->Properties" then in "Run/Debug settings" click on the "New button". Choose C++ application. Here you can see that there are 4 tabs, and the second tab is called "arguments". In this tab you can see a textarea. Type your application's argument there, and click "OK". When you will execute your application thanks to the "play" button of eclipse, your program will be called with arguments.

