
## basic concept
### options
-f Filename of script follows.
-F Change field separator.
-v var=value follows


* -f awk  with script file

> Awk programs are usually placed in a file where they can be tested and modified. The syntax for
invoking awk with a script file is:
```
awk -f script files
```

* -F default separator
> Awk, in the usual case, interprets each input line as a record and each word on that line, delimited byspaces or tabs, as a field.

-F option to change the field separator to a comma.

```
awk -F, '/MA/ { print $1 }' list
```

eg:
```
#     'patten  {action}'
awk '/MA/ { print $1 }' list
```
### patten (模式)
* BEGIN

```
# Use BEGIN to set variables
awk 'BEGIN { FS = ":" ; OFS = "**" } \
# Quoted program continues on second line
  { print $1, $5 }' /etc/passwd
```

> One notable exception is that in awk, \ is special inside bracket expressions. Thus,to match a left bracket,dash,right bracket,or backslash,you could use [\[\-\]\\].Again, this reflects historical practice.


### Predefined variable of awk
awk Variable | Meaning
---|---
FILENAME | Name of current input file
RS       |Input record separator character (Default is new line)
OFS      | Output field separator string (Blank is default)
ORS      | Output record separator string (Default is new line)
NF       | Number of input record
NR       | Number of fields in input record
OFMT     | Output format of number
FS       | Field separator character (Blank & tab is default)


```
# 这里[:blank]指代空白符,(@todo nxn 弄明白为什么不能用\s呢?)
awk -F '[[:blank:]:]+' '{print $3}'  <<<'inet addr:127.0.0.1  Mask:255.0.0.0'
# 或者
awk -F '( |:)+' '{print $3}'  <<<'inet addr:127.0.0.1  Mask:255.0.0.0'
# 输出结果为
127.0.0.1
```

### functions
#### print
> Be sure to separate arguments to print with a comma! Without the comma, awk concatenates adjacent values:
String concatenation of this form is unlikely to be what you want.Omitting the comma is a common, and hard-to-find, mistake
```
$ awk -F: '{ print "User" $1 "is really" $5 }' /etc/passwd
```
result:
```
Userrootis reallyroot
Usertolstoyis reallyLeo Tolstoy
Useraustenis reallyJane Austen
Usercamusis reallyAlbert Camus
```
#### gsub(regexp, replacement [, target])
Search target for all of the longest, leftmost, nonoverlapping matching substrings it can find and replace them with replacement. The ‘g’ in gsub() stands for “global,” which means replace everywhere. For example:
```
{ gsub(/Britain/, "United Kingdom"); print }
```
replaces all occurrences of the string ‘Britain’ with ‘United Kingdom’ for all input records.

The gsub() function returns the number of substitutions made. If the variable to search and alter (target) is omitted, then the entire input record ($0) is used. As in sub(), the characters ‘&’ and ‘\’ are special, and the third argument must be assignable.

#### system(command)
    Execute the operating system command command and then return to the awk program. Return command’s exit status (see further on).

eg:
```


   For example, if the following fragment of code is put in your awk program:

   END {
        system("date | mail -s 'awk run done' root")
   }
```

```
awk '{ print $1 }' 			# Print first field (no pattern)
awk '{ print $2, $5 }' 		# Print second and fifth fields (no pattern)
awk '{ print $1, $NF }' 	# Print first and last fields (no pattern)
awk 'NF > 0 { print $0 }' 	# Print nonempty lines (pattern and action)
awk 'NF > 0' 				#Same (no action, default is to print)
awk -F: -v 'OFS=**' '{ print $1, $5 }' /etc/passwd
awk -F: '{ printf "User %s is really %s\n", $1, $5 }' /etc/passwd

```


```
# 借助变量标示状态,可进行条件输出,从而形成漂亮的报表形式
#引入一个自定义变量, LastState, awk 语法中变量可直接使用,`LastState = $1` 是给变量赋值
awk -F, '
$1 == LastState {
      print "\t" $2;
}
$1 != LastState {
      LastState = $1;
      print $1 "\n\t" $2;
}
';
```
#### 常见的语法错误列席

```
- Not surrounding the instructions within single quotes (`')
- Not enclosing a procedure within braces ({})
- Not enclosing regular expressions within slashes (//)
```



