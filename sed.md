# 教程
[sed视频教程](https://www.youtube.com/watch?v=5UbK590a0ks&index=14&list=PLcUid3OP_4OW-rwv_mBHzx9MmE5TxvvcQ)

# basic concept
NAME
       sed - stream editor for filtering and transforming text

SYNOPSIS

       sed [OPTION]... {script-only-if-no-other-script} [input-file]...

DESCRIPTION

###       -n, --quiet, --silent 不输出结果

              suppress automatic printing of pattern space


```
# 只输出替换的行 ( p print, one of sed command )
sed -n 's/MA/Massachusetts/p' sedData.txt
# use for svn log, 用了正则范围表达式
svn log -v | sed -n '/nanxiaoning/,/-----$/ p' | head -n 50
```

###       -e script, --expression=script 多instruction

              add the script to the commands to be executed

###       -f script-file, --file=script-file 允许使用脚本文件scriptfile

              add the contents of script-file to the commands to be executed
```
# the file must contain instruction only (can's not use sed option -e ) and should not wapped by ''
sed -f scriptfile file
```


###       -i[SUFFIX], --in-place[=SUFFIX]

              edit files in place (makes backup if SUFFIX supplied)
```
cat touch_test.php

<?php
echo "hello world";
?>


sed -i 's/php/php echo "just do it!";/g' touch_test.php

cat touch_test.php

<?php echo "just do it!";
echo "hello world";
?>

```





## instruction
###  sed sigle instruction VS multi instruction
```
s/ CA/, California/
sed -e 's/ MA/, Massachusetts/' -e 's/ PA/,Pennsylvania/' list

# multiline entry
$ sed '
> s/ MA/, Massachusetts/
> s/ PA/, Pennsylvania/
> s/ CA/, California/' list
```

## commands 部分command可以接受address

### subsitution(s)
```
s/regexp/replacement/
```

              Attempt  to  match  regexp against the pattern space.  If successful, replace that portion matched with replacement.
              The replacement may contain the special character & to refer to that portion of the pattern space which matched, and
              the special escapes \1 through \9 to refer to the corresponding matching sub-expressions in the regexp.

```
echo abc | sed 's/b*/1/' Replace first match
1abc
echo abc | sed 's/b*/1/g' Replace all matches
1abc1
```

#### replacements section

> In the replacement section, only the following characters have special meaning:

char | description
---| ---
 & | Replaced by the string matched by the regular expression.
 \n | Matches the nth substring (n is a single digit) previously specified in the pattern using "\(" and"\)".
 \ |Used to escape the ampersand (&), the backslash (\), and the substitution command's delimiter when they are used literally in the replacement section. In addition, it can be used to escape the newline and create a multiline replacement string.
### globle (g)
### print (p)
### delete(d),
eg:
```
#delete line from 5th line to the bottom of the file
sed '5,$ d' text2
```
### append (a),
### insert (i),
### change (c)
### list (l)
### next (n)
### quit (q )
eg.
```shell
# output util the 4th line and quit
sed '4 q' text2
```
> The list command (l) displays the contents of the pattern space, showing non-printing characters as twodigit ASCII codes. It is similar in function to the list (:l) command in vi. You can use this command to detect "invisible" characters in the input

> The next command (n) outputs the contents of the pattern space and then reads the next line of input
without returning to the top of the script. Its syntax is:


## address
> An equal sign (=) following an address prints the line number of the matched line. Unless you suppress the automatic output of lines, both the line number and the line itself will be printed.


## 重要说明
### sed 最容易犯的错误
> The syntax of a sed command can be detailed, and it's easy to make a mistake or omit a required
element. Notice what happens when incomplete syntax is entered:
```
$ sed -e 's/MA/Massachusetts' list
```
> sed: command garbled: s/MA/Massachusetts

### sed 不改变越来文件内容,需要保存处理结果需要IO重定向
> Unless you are redirecting the output of sed to another program, you will want to capture the output in a
file. This is done by specifying one of the shell's I/O redirection symbols followed by the name of a file:
$ sed -f sedscr list > newlist




----------------------------------------------------------------------------------------

sed:

A little-known fact (amaze your friends!) is that you can specify a trailing number to
indicate that the nth occurrence should be replaced:
$ sed 's/Tolstoy/Camus/2' < example.txt Second occurrence only
Tolstoy reads well. Camus writes well.


sed -e 's/foo/bar/g' -e 's/chicken/cow/g' myfile.xml > myfile2.xml

sed -f fixup.sed myfile.xml > myfile2.xml

sed -n '/<HTML>/p' *.html Only print <HTML> line

An empty pattern in the s command means “use the previous regular
expression”:
/Tolstoy/ s//& and Camus/g Talk about both authors



```
Ranges
You can specify a range of lines by separating addresses with a comma:
sed -n '10,42p' foo.xml Print only lines 10–42
sed '/foo/,/bar/ s/baz/quux/g' Make substitution only on range of lines
```

The second command says “starting with lines matching foo,and continuing
through lines matching bar,replace all occurrences of baz with quux.” (Readers
familiar with ed, ex,or the colon command prompt in vi will recognize this
usage.)


Negated regular expressions
Occasionally it’s useful to apply a command to all lines that don’t match a particular pattern. You specify this by adding an ! character after a regular expression
to look for:
/used/!s/new/used/g Change new to used on lines not matching used
