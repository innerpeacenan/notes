
* 字符串转化为数字类
去除字符串开头的空白符,检测字符串中的数字部分,抛弃非数字部分,如果不包括数字部分,则转化结果为0

* 字符串转化为boolean值
采用字符串转化为数字的方式,如果结果大于0,则为true,如果结果等于0,则为false
因此,"0"会被转化为false


* 空数组
```php
[]==flalse //true
```



### echo tag
> You can use the short echo tag to <?= 'print this string' ?>.
>    It's always enabled in PHP 5.4.0 and later, and is equivalent to
```
 <?= ?>
    <?php echo 'print this string'; ?>.
```


### 常量定义 (define 和 const去呗)

> As of PHP 5.3 there are two ways to define constants: Either using the const keyword or using the  define() function:
```
const FOO = 'BAR';
define('FOO', 'BAR');
```
> The fundamental difference between those two ways is that const defines constants at compile time, whereas define defines them at run time. This causes most of const's disadvantages. Some disadvantages of const are:

* const cannot be used to conditionally define constants. To define a global constant, it has to be used in the outermost scope:
```
//会报语法错误
if (...) {
    const FOO = 'BAR';    // invalid
}
// but
if (...) {
    define('FOO', 'BAR'); // valid
}
```
> Why would you want to do that anyways? One common application is to check whether the constant is already defined:
```
if (!defined('FOO')) {
    define('FOO', 'BAR');
}
```

* const accepts a static scalar (number, string or other constant like true, false, null, `__FILE__`), whereas define() takes any expression. Since PHP 5.6 constant expressions are allowed in const as well:
```
const BIT_5 = 1 << 5;    // valid since PHP 5.6, invalid previously
define('BIT_5', 1 << 5); // always valid
```

* const takes a plain constant name, whereas define() accepts any expression as name. This allows to do things like this:

```
for ($i = 0; $i < 32; ++$i) {
    define('BIT_' . $i, 1 << $i);
}
```

* consts are always case sensitive, whereas define() allows you to define case insensitive constants by passing true as the third argument:
```
define('FOO', 'BAR', true);
echo FOO; // BAR
echo foo; // BAR
```

> So, that was the bad side of things. Now let's look at the reason why I personally always use const unless one of the above situations occurs:

* const simply reads nicer. It's a language construct instead of a function and also is consistent with how you define constants in classes.
* const defines a constant in the current namespace, while define() has to be passed the full
```
namespace name:
namespace A\B\C;
// To define the constant A\B\C\FOO:
const FOO = 'BAR';

define('A\\B\\C\\FOO', 'BAR');
```

> Since PHP 5.6 const constants can also be arrays, while define() does not support arrays yet. However arrays will be supported for both cases in PHP 7.
```
const FOO = [1, 2, 3];    // valid in PHP 5.6
define('FOO', [1, 2, 3]); // invalid in PHP 5.6, valid in PHP 7.0
```
* As consts are language constructs and defined at compile time they are a bit faster than define()s.

> It is well known that PHP define()s are slow when using a large number of constants. People have even invented things like apc_load_constants() and hidef to get around this.

> consts make the definition of constants approximately twice as fast (on development machines with XDebug turned on even more). Lookup time on the other hand does not change (as both constant types share the same lookup table): Demo.

## 常用的全局变量
### $_SERVER 变量
```php
<?php
//$_SERVER['HTTPS']
//$_SERVER['HTTP_HOST']
//$_SERVER['REQUEST_URI']
//$_SERVER['SCRIPT_FILENAME']

//利用header()函数实现页面跳转
if($_SERVER['HTTPS']!="on")
{
	$redirect= "https://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
	header("Location:$redirect");
}
// 如何取得客户端的ip(要求取得一个int)
$_SERVER["REMOTE_ADDR"];ip2long进行转换
?>
```

#### PHP_EOL
> PHP_EOL是一个些已经定义好的变量，代表php的换行符，这个变量会根据平台而变，在windows下会是/r/n，在linux下是/n，在mac下是/r.换行就按下面的就可以了。
```
$str = str_replace(PHP_EOL, '', $str);
```

大小写问题
> 函数名、方法名、类名不区分大小写

> 魔术常量不区分大小写，推荐大写


```php
<?php
__LINE__;
__FILE__;
__DIR__;
__FUNCTION__;
__CLASS__;
__METHOD__;
__NAMESPACE__;
?>
```

### 闭包

```
    public function autoCompleteData()
    {
        $db = $this->getDbConnection();
        if ($db !== null) {
            return [
                'tableName' => function () use ($db) {
                    return $db->getSchema()->getTableNames();
                },
            ];
        } else {
            return [];
        }
    }
```

```
class Totalizer {
    static function warnAmount( $amt ) {
        $count=0;
        return function( $product ) use ( $amt, &$count ) {
            $count += $product->price;
            print "   count: $count\n";
            if ( $count > $amt ) {
                print "   high price reached: {$count}\n";
            }
        };
    }
}
```


### strncmp

strncmp — Binary safe string comparison of the first n characters

```
// @param len  Number of characters to use in the comparison.
int strncmp ( string $str1 , string $str2 , int $len )
// yii框架中的应用案例
strncmp($alias, '@', 1)
```

### strtr — Translate characters or replace substrings

```
Description
string strtr ( string $str , string $from , string $to )


string strtr ( string $str , array $replace_pairs )
```


### trim ltrim rtrim

trim — Strip whitespace (or other characters) from the beginning and end of a string

```
string trim ( string $str [, string $character_mask = " \t\n\r\0\x0B" ] )
```

```
//character_mask
//Optionally, the stripped characters can also be specified using the character_mask parameter. Simply list all characters that you want to be stripped. With .. you can specify a range of characters.
// 特别注意,定义character_mask时,所定义的字符最好转义(尽管部分字符不会引起歧义,但这是一个好的习惯),另外如果要在原有的空白符的基础上增加新的末端过滤符号,则应该追加到character_mast后面,如要多去除',',则character_mask应该写作" \t\n\r\0\x0B\,"
```

### explode — Split a string by string
```
// 注意,(1) 第一个参数为分隔符 (2) explode函数可以接受多个字符作为分隔符,即分隔符是一个字符串 (这是上次面试错误的两个地方)
Note:
//Although implode() can, for historical reasons, accept its parameters in either order, explode() cannot. You must ensure that the
// delimiter argument comes before the string argument.

array explode ( string $delimiter , string $string [, int $limit = PHP_INT_MAX ] )
// If delimiter is an empty string (""), explode() will return FALSE. If delimiter contains a value that is not contained in string and a
// negative limit is used, then an empty array will be returned, otherwise an array containing string will be returned.
// A string that doesn't contain the delimiter will simply return a one-length array of the original string.
```

### str_replace — Replace all occurrences of the search string with the replacement string
```
mixed str_replace ( mixed $needle , mixed $replace , mixed $haystack [, int &$count ] )
```





```
function uniqid ($prefix = "", $more_entropy = false) {}

ctype_alnum — Check for alphanumeric character(s)
```





### strpos — Find the position of the first occurrence of a substring in a string
```
notes: Returns <b>FALSE</b> if the needle was not found.
function strpos ($haystack, $needle, $offset = 0) {}
```

### ucwords — Uppercase the first character of each word in a string
```
//注意:这个函数容易写错
string ucwords ( string $str [, string $delimiters = " \t\r\n\f\v" ] )
```





## 操作符
### 三元操作符
```php
 return $this->_assetManager ?: Yii::$app->getAssetManager();
```


## 运算符优先级
```php
<?php
class Test{

}
//new > instanceof > !> 比较运算符 > && > || > ? :赋值运算符 > and > or >,
var_dump( new Test() instanceof Test ||  0 ? false: true) ;
var_dump( new Test() instanceof Test or 0 ? false: true) ;
var_dump( new Test() instanceof Test || (0 ? false: true) ) ;
?>
```


## 字符串处理函数
`explode()`;
> 再使用该函数前,trim边界符号,检查内容是否为空,如果不为空,然后在执行该函数


array_merge(); 与 + 的区别

substr 注意这个函数的第三个参数

```
substr_compare($action, $method, -$len, $len, true) === 0
```

```
 setcookie('b','value');
 #cookie设置后,在下一次请求中被发送给服务器,因此,第一次设置时,当前的请求无法获取指定cookie
 var_dump($_COOKIE['b']);
```

preg_match

```
int <b>preg_match</b> returns 1 if the <i>pattern</i>
matches given <i>subject</i>, 0 if it does not, or <b>FALSE</b> on error
```

在 PHP 中,函数的查找顺序为先在耿命名空间下查找,如果找不到,再到当前命名空间下查找.所以会出现以下情况:

```
//Call to undefined function n\modules\index\controllers\l()
$controller = preg_replace('/([a-z])([A-Z])/', '${1}-${2}', $controller);
```

strcasecmp 比较结果相同的情况下,会返回0

```
$result[$matches[1]] = strcasecmp($matches[2], 'desc') ? SORT_ASC : SORT_DESC;
```

对 `settype()` 返回值未 boolean 值

二进制浮点数问题

echo intval(0.58*100) 输出的结果是57

原因就是浮点数精度的问题。
简单的十进制分数如同 0.1 或 0.7 不能在不丢失一点点精度的情况下转换为内部二进制的格式。这就会造成混乱的结果：例如，floor((0.1+0.7)*10) 通常会返回 7 而不是预期中的 8，因为该结果内部的表示其实是类似 7.9999999999…。这和一个事实有关，那就是不可能精确的用有限位数表达某些十进制分数。例如，十进制的 1/3 变成了 0.3333333…。所以永远不要相信浮点数结果精确到了最后一位，也永远不要比较两个浮点数是否相等。如果确实需要更高的精度，应该使用任意精度数学函数或者 gmp 函数

is_callable ([object or object,method name])

Example #2 is_callable() and constructors

As of PHP 5.3.0 is_callable() reports constructors as not being callable. This affects PHP 5 style constructors (__construct) as well as PHP 4 style constructors (i.e. methods with the same name as the class). Formerly, both cases have been considered callable.

hash table

// 该数组只有一个元素,了解 php hash table 的作用

$a = ['1'=>'hello',1=>'ok'];

//        这就是个加减运算

//        $a = 2015-06-02;


### trim函数
```
$shiftInfoId = rtrim($param['id'],'\,\t\n\r\0\x0B');//删除多余的逗号  x0B( Vertical tab)为给写成8了,导致商品被多消除了一位
```

### input filter 输入过滤

```
strip_tags ($str, $allowable_tags = null)
````


# 语法

### 用php的数据结构做相关的算法运算
```
Datastructures
SplDoublyLinkedList — The SplDoublyLinkedList class
SplStack — The SplStack class
SplQueue — The SplQueue class
SplHeap — The SplHeap class
SplMaxHeap — The SplMaxHeap class
SplMinHeap — The SplMinHeap class
SplPriorityQueue — The SplPriorityQueue class
SplFixedArray — The SplFixedArray class
SplObjectStorage — The SplObjectStorage class'
```


### echo print

这两个看起来很相似，因为它们都是将一些值打印在屏幕上。

echo用来输出字符串，显示多个值的时候可以用逗号隔开。

print不仅可以打印字符串值，而且可以打印函数的返回值。

print()函数自身的返回值总是1。


### boolean

Note: 递增／递减运算符不影响布尔值。递减 NULL  值也没有效果，但是递增 NULL  的结果是 1。

> 转义序列(反斜线)

> 反斜线有多种用法。首先，如果紧接着是一个非字母数字字符，表明取消 该字符所代表的特殊涵义。这种将反斜线作为转义字符的用法在字符类 内部和外部都可用。
比如，如果你希望匹配一个 ``"*"` 字符，就需要在模式中写为 `"\*"`。

> 这适用于一个字符在不进行转义会有特殊含义的情况下。 但是， 对于非数字字母的字符，总是在需要其进行原文匹配的时候在它前面增加一个反斜线， 来声明它代表自己，这是安全的。如果要匹配一个反斜线，那么在模式中使用 `”\\”`。

生成模板文件常用

```
<?= "{$column->phpType} \${$colum->name}\n"?>
```


## 字符串

str_replace

```php
$text = file_get_contents ( $templatefile );
		$keys = array (
				'{$user->username}',
				'{$user->_newPassword}',
				'{$user->getId()}',
				'{$user->profile->new_password_key}'
		);
		$values = array (
				$this->username,
				$this->_newPassword,
				$this->getId (),
				$this->profile->new_password_key
		);
$body = str_replace ( $keys, $values, $text );
```



## preg_grep 正则表达式

```
/**
 * Return array entries that match the pattern
 * @link http://php.net/manual/en/function.preg-grep.php
 * @param string $pattern <p>
 * The pattern to search for, as a string.
 * </p>
 * @param array $input <p>
 * The input array.
 * </p>
 * @param int $flags [optional] <p>
 * If set to <b>PREG_GREP_INVERT</b>, this function returns
 * the elements of the input array that do not match
 * the given <i>pattern</i>.
 * </p>
 * @return array an array indexed using the keys from the
 * <i>input</i> array.
 * @since 4.0
 * @since 5.0
 */
function preg_grep ($pattern, array $input, $flags = 0) {}
```


## 数组

json处理

[json_decode](http://php.net/json_decode)

```
mixed json_decode ( string $json [, bool $assoc = false [, int $depth = 512 [, int $options = 0 ]]] )
```

要将json_decode()的结果转化成为数组，需要设置第二个参数值为true
> assoc

>  When TRUE, returned objects will be converted into associative arrays.


## 日期时间

```php
<?php
$timestamp = strtotime("2016-07-05 08:03:05");
echo date("Y年n月j日 H:i:s",$timestamp);
echo PHP_EOL;
echo date("Y年m月d日 H:i:s",$timestamp);

strtotime支持：
+1 week
next friday
last saturday
+1 year 6 months 38 days 15 hors 26 minutes 12 seconds
用strtotime()将日期字符串转为unix时间戳，date("l",strtotime())计算星期几

date('Y-m-d H:i:s',$starttime);
date('Y-m-d H:i:s',strtotime('-1 days'));
date('Y-n-j H:i:s',strtotime('+1 days'));
$startUnix = strtotime("-1 year", $endTimeUnix);

$from = strtotime('2007-02-05');
$to = strtotime('2007-03-06');
$diffdays = ($to-$from)/(3600*24);


//获取每月当天的日期组成的数组
$months = [];
for ($i = 1; $i <= 12; $i++) {
     $month =  $i;
    $months[] = date('Y-m-d', strtotime('today - ' . $i . 'month'));
}
```



## php中测试程序执行时间:

### microtime - Return current Unix timestamp with microseconds
> By default, microtime() returns a string in the form "msec sec", where sec is the number of seconds since the Unix epoch (0:00:00 January 1,1970 GMT), and msec measures microseconds that have elapsed since sec and is also expressed in seconds.

> If get_as_float is set to TRUE, then microtime() returns a float, which represents the current time in seconds since the Unix epoch accurate to the nearest microsecond.




```
$start = microtime(true);
$time_elapsed_secs = microtime(true) - $start;
```


## io操作

php:// — Accessing various I/O streams
```
//注意  php://input is not available with enctype="multipart/form-data".
//yii2 中的应用
    /**
     * Returns the raw HTTP request body.
     * @return string the request body
     */
    public function getRawBody()
    {
        if ($this->_rawBody === null) {
            $this->_rawBody = file_get_contents('php://input');
        }
        return $this->_rawBody;
    }
```

STIIN should not contain single quotes or double quotes, anything includeing `"` or `'` was treated as string

use function like fgets to handle STDIN , becaulse STDIN is a file discriptor and is_resource(STDIN) === true;

fgets — Gets line from file pointer

```
string fgets ( resource $handle [, int $length ] )

while($f = fgets(STDIN)){
    echo "line: $f";
}
```

```
//php://stdin 输入流
$fp = fopen("php://stdin", "r");
$in = '';
while($in != "quit") {
    echo "php> ";
    $in=trim(fgets($fp));
}
```

```
ob_start();
ob_implicit_flush(false);
extract($_params_, EXTR_OVERWRITE);


fopen()
usleep()
flock()
fwrite()
fclose()
```

```
<?php
glob()
return false !== strpos($name, '*') ? array_map("unlink", glob($filename)) : unlink($filename)

shell  functions
shell_exec — Execute command via shell and return the complete output as a string
string shell_exec ( string $cmd )
?>
```



文件操作示例代码
```
	public function dataFiles()
	{
		$files = [];
		foreach ($this->getDataPaths() as $name => $src) {
			$handle = opendir($src);
			if ($handle === false) {
				throw new \Exception('Unable to open directory: ' . $src);
			}
			while (($file = readdir($handle)) !== false) {
// readdir 每次返回一个字符串,代表一个文件名称
// 注意.该文件名称不包括目录名称
				if ($file === '.' || $file === '..') {
					continue;
				}
				if (substr($file, -3, 3) === '.md' && file_exists($src . '/' . substr($file, 0, -3) .  $this->outputFileExtension)) {
					$files[] = [$name, substr($file, 0, -3)];
				}
			}
			closedir($handle);
		}
		return $files;
	}
```

请写一段pHp代码，确保多个进程同时写入同一个文件成功

//@todo
```
function writeData($path, $mode, $data){
                $fp          = fopen($path, $mode);
                $retries     = 0;
                $max_retries = 100;
                do {
                    if ($retries > 0) {
                        usleep(rand(1, 10000));
                    }
                    $retries += 1;
                }while (!flock($fp, LOCK_EX) and $retries <= $max_retries);

                if ($retries == $max_retries) {
                    return false;
                }
                fwrite($fp, "$data\\n");
                flock($fp, LOCK_UN);
                fclose($fp);
                return true;
        }
```

学习了file_put_contents()和file_get_contents()
file_put_contents()和依次调用 fopen() ， fwrite()  以及 fclose()  功能一样。
FILE_APPEND   如果文件 filename 已经存在，追加数据而不是覆盖。


ob_start()在服务器打开一个缓冲区来保存所有的输出。所以在任何时候使用echo ，输出都将被加入缓冲区中，直到程序运行结束或者使用ob_flush()来结束。然后在服务器中缓冲区的内容才会发送到浏览器，由浏览器来解析显示。

### stream_get_contents <C>+d 结束输入

```
function mkdir ($pathname, $mode = 0777, $recursive = false, $context = null) {}
function rename ($oldname, $newname, $context = null) {}
function copy ($source, $dest, $context = null) {}
is_writable()
sprintf
```


### is_dir
```
/**
 * Tells whether the filename is a directory
 * @link http://php.net/manual/en/function.is-dir.php
 * @param string $filename <p>
 * Path to the file. If filename is a relative
 * filename, it will be checked relative to the current working
 * directory. If filename is a symbolic or hard link
 * then the link will be resolved and checked.
 * </p>
 * @return bool true if the filename exists and is a directory, false
 * otherwise.
 * @since 4.0
 * @since 5.0
 */
function is_dir ($filename) {}
```


### file_put_contents()
```
$file  =  'people.txt' ;
 // The new person to add to the file
 $person  =  "John Smith\n" ;
 // Write the contents to the file,
// using the FILE_APPEND flag to append the content to the end of the file
// and the LOCK_EX flag to prevent anyone else writing to the file at the same time
 file_put_contents ( $file ,  $person ,  FILE_APPEND  |  LOCK_EX );
```

### clearstatcache()
```
//@todo nxn 这个有待亲自验证
必须注意的是，对于不存在的文件，PHP 并不会缓存其信息。所以如果调用 file_exists()来检查不存在的文件，
在该文件没有被创建之前，它都会返回FALSE。如果该文件被创建了，就算以后被删除，它都会返回 TRUE 函数 unlink() 会自动清除该缓存.
```

### mkdir — Makes directory
```
bool mkdir ( string $pathname [, int $mode = 0777 [, bool $recursive = false [, resource $context ]]] )

Emits an E_WARNING level error if the directory already exists.

Emits an E_WARNING level error if the relevant permissions prevent creating the directory.

Note: When safe mode is enabled, PHP checks whether the directory in which the script is operating has the same UID (owner) as the script that is being executed.
```
// @todo
basename — Returns trailing name component of path



## 正则匹配函数

### preg_match — Perform a regular expression match

```
int preg_match ( string $pattern , string $subject [, array &$matches [, int $flags = 0 [, int $offset = 0 ]]] )

if (!preg_match('/^[0-9]+(\.[0-9]{1,9})?$/', $params['conversion' . $i])) {
    $this->error('转换率必须是数字');
}
```



### preg_split — Split string by a regular expression

```
array preg_split ( string $pattern , string $subject [, int $limit = -1 [, int $flags = 0 ]] )
```

> 原split函数在php 7 中已经被移除了
> yii2 中利用该函数分割select语句中的字段

```
$columns = preg_split('/\s*,\s*/', trim($columns), -1, PREG_SPLIT_NO_EMPTY);
```





# 类库

## pdo

[PDO 事务的使用例子:](http://thisinterestsme.com/php-pdo-transaction-example/)

PDO 选项:
 $this->options[\PDO::ATTR_EMULATE_PREPARES]    =   false;

## curl

```
 //curl()函数可以域名重新定向
        // create a new cURL resource
        $ch = curl_init();

// set URL and other appropriate options
        curl_setopt($ch, CURLOPT_URL, "http://www.baidu.com/");
        curl_setopt($ch, CURLOPT_HEADER, 0);

// grab URL and pass it to the browser
        curl_exec($ch);

// close cURL resource, and free up system resources
        curl_close($ch);
```

## 图像处理

resource imagecreatefromgif ( string $filename )
imagecreatetruecolor()
//php都函数大小写不敏感，尽量但函数采用大小写，使得程序更加易读
ImageCopyResampled()


```
getimagesize () //获取图片的尺寸

Imagesx () //获取图片的宽度

Imagesy () //获取图片的高度
```

### mysql

php 与 mysql 连接字符编码问题
字符编码:
//告诉服务器发送的数据是什么类型的
$this->query("set character_set_client=utf8");
//告诉转换器，转换什么编码
$this->query("character_set_connection==utf8");
//查询结果用什么编码
$this->query("set character_set_results=utf8");

//如果三者都是字符集N,那么 可以简写为 set names N;
$this->query("set names 'utf8' ");

### php 与 postgresql
If serializing objects to be stored into a postgresql database, the 'null byte' injected for private and protected members throws a wrench into the system. Even pg_escape_bytea() on the value, and storing the value as a binary type fails under certain circumstances.
 For a dirty work around:

<?php
$serialized_object = serialize($my_object);
$safe_object = str_replace("\0", "~~NULL_BYTE~~", $serialized_object);
?>
# desigin pattern

对象-关系映射（Object/Relation Mapping，简称ORM）

是随着面向对象的软件开发方法发展而产生的。面向对象的开发方法是当今企业级应用开发环境中的主流开发方法，关系数据库是企业级应用环境中永久存放数据的主流数据存储系统。对象和关系数据是业务实体的两种表现形式，业务实体在内存中表现为对象，在数据库中表现为关系数据。内存中的对象之间存在关联和继承关系，而在数据库中，关系数据无法直接表达多对多关联和继承关系。因此，对象-关系映射(ORM)系统一般以中间件的形式存在，主要实现程序对象到关系数据库数据的映射。


/**
 * Implement PHP __clone to create a deep clone, not just a shallow copy.
 */
public function __clone() {
	$vars = get_object_vars($this);
	foreach ($vars as $key => $value) {
		if ((is_object($value)) && ($key != '_parent')) {
			$this->$key = clone $value;
		} else {
			$this->$key = $value;
		}
	}
}


/**
 * Make a deep copy of object.
 */
public function __clone()
{
	$this->_headers = clone $this->_headers;
	$this->_encoder = clone $this->_encoder;
	$this->_cacheKey = uniqid();
	$children = array();
	foreach ($this->_children as $pos => $child) {
		$children[$pos] = clone $child;
	}
	$this->setChildren($children);
}


spl_autoload_register
> Suprisingly, spl_autoload_register supports the
Class::staticMethod callback format, although call_user_func doesn't

register_shutdown_function


```
public function init()
{
	parent::init();
	register_shutdown_function(function () {
		// make regular flush before other shutdown functions, which allows session data collection and so on
		$this->flush();
		// make sure log entries written by shutdown functions are also flushed
		// ensure "flush()" is called last when there are multiple shutdown functions
		register_shutdown_function([$this, 'flush'], true);
	});
}
```

```php
<?php
/*
 * zend_framework auto_load
 * */
function  __autoload ( $class_name ) {

	define( APPLICATION_PATH,'D:/workspace/test/' );
	define( LIBRARY_PATH,APPLICATION_PATH.'library/');
 	/*
 	 * 按_将字符串分开，explode array
 	 * 用/连接成字符串，implode
 	 *
 	 *
 	 */
 	$class_name_arr = explode('_', $class_name) ;
 	$class_name_str = implode('/', $class_name_arr) ;
 	require_once  LIBRARY_PATH.$class_name_str.'.php' ;
}

?>
```
serialize and unserialize

//如果需要用到复制的对象对其他对象的引用时候，要用到serialize和unserialize

func_get_args()  — Returns an array comprising a function's argument list

array func_get_args ( void )

func_num_args()

array_walk_recursive

> bool array_walk_recursive ( array &$array , callable $callback [, mixed $userdata = NULL ] )

Applies the user-defined callback function to each element of the array. This function will recurse into deeper arrays.


Note:
> If callback needs to be working with the actual values of the array, specify the first parameter of callback as a reference. Then, any changes made to those elements will be made in the original array itself.
userdata

> If the optional userdata parameter is supplied, it will be passed as the third parameter to the callback.

Return Values
Returns TRUE on success or FALSE on failure.

call_user_func

```
if ($this->when === null || call_user_func($this->when, $model, $attribute)) {
	pp($this->when);
	$this->validateAttribute($model, $attribute);
}
```

### 反射类
```
    /**
     * Returns the root directory of the module.
     * It defaults to the directory containing the module class file.
     * @return string the root directory of the module.
     */
    public function getBasePath()
    {
        if ($this->_basePath === null) {
            $class = new \ReflectionClass($this);
            $this->_basePath = dirname($class->getFileName());
        }

        return $this->_basePath;
    }
```


```
// yii2 将url的action部分(即action ID)转化了控制器文件中注册的方法名称
$methodName = 'action' . str_replace(' ', '', ucwords(implode(' ', explode('-', $id))));
// 接着采用ReflectionMethod获取类中实际存在的方法(从而可以知道一个类的各个方法的更多信息,如访问控制类型(public protected private))
$method = new \ReflectionMethod($this, $methodName);
$method->isPublic()
```

附录: php手册中函数阅读方法说明

函数内global关键字声明的同时不能同时赋值

1. 常规函数

```
bool copy ( string source, string dest )
```

2. 带有mixed , mixed表示可以传任何类型的数据

```
bool chown ( string filename, mixed user )
```

3. 带有&参数的函数， 表示引用赋值，这个参数不能传值，只能传一个变量，然后函数将变量的值改变，我们在使用这个变量时，值也是变化的

```
bool arsort ( array &array [, int sort_flags])
```

4.默认函数 带有[]的函数, 表示这个参数是可选的，如果你传值了就使用你传的值，如果没有传值则使用默认值,直接在声明函数时，就为参数给初值。可选值和必须值， 必须从后向前设置

```
bool arsort ( array &array [, int sort_flags])
```
5. 带有…的参数函数， …表示可以传任意多个参数

```
int array_unshift ( array &array, mixed var [,mixed ...] )
```
6. 回调函数 带有callback, 就是调用这个函数时需要我们传一个函数进来（函数名，函数名字串）

```
array array_filter ( array input [, callback callback] )
```


附录2: php 开发注意问题
[PDOStatement::bindParam的一个陷阱](http://www.laruence.com/2012/10/16/2831.html)


附录3:
SAPI:Server Application Programming Interface 服务器端应用编程端口。它就是PHP与其它应用交互的接口，PHP脚本要执行有很多种方式，通过Web服务器，或者直接在命令行下，也可以嵌入在其他程序中。
SAPI提供了一个和外部通信的接口，常见的SAPI有：cgi 、fast-cgi、cli、isapi、apache 模块的 DLL

cgi

CGI全称是“公共网关接口”(Common Gateway Interface)，HTTP服务器与你的或其它机器上的程序进行“交谈”的一种工具，其程序须运行在网络服务器上。


什么是fpm

FastCGI Process Manager：FastCGI进程管理器

Ngix + php-fpm
[LNMP介绍](http://www.infoq.com/cn/news/2012/07/is-LNMPA-better)

> Nginx + php-fpm 比 Apache + mod_php 更省内存。





```
php -r
php -m show loaded modules
php -l check syntax only
```





[防止表单重复提交](http://www.bkjia.com/jingyan/471187.html)


## php 源码学习
PHP　源码中的一些宏
毁全局变量表（PG(http_globals)）

前面的章节介绍了EG宏，这是一个全局结构体用于保存在运行时的数据。 其中就包括了用来保存所有被创建的对象的对象池，EG(objects_store)
对象池（EG(objects_store）中的所有对象的析构函数以及EG(symbol_table)中各个元素的析构方法。

c core
全局变量表　CG(auto_globals)
函数表　CG(function_table)

s sapi
sapi_activate函数用来初始化SG(sapi_headers)和SG(request_info)


curl_setopt($curl, CURLOPT_PROTOCOLS, CURLPROTO_HTTP | CURLPROTO_HTTPS);


CURLOPT_HEADER    TRUE to include the header in the output.


CURLOPT_CONNECTTIMEOUT_MS    The number of milliseconds to wait while trying to connect. Use 0 to wait indefinitely. If libcurl is built to use the standard system name resolver, that portion of the connect will still use full-second resolution for timeouts with a minimum timeout allowed of one second.


CURLOPT_NOSIGNAL    TRUE to ignore any cURL function that causes a signal to be sent to the PHP process. This is turned on by default in multi-threaded SAPIs so timeout options can still be used



分类树:
[重点是存]http://www.jianshu.com/p/511a000ddf6e
[重点是查找]http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/


$_SERVER['SERVER_ADDR'] the ip address of server itself


-----------------

正在表达式注意事项

Its works in perl because you pass that directly as regex pattern  `/(?:\\[trn])+/`
but in php, you need to pass as string, so need extra escaping for backslash itself.

[PHP regular expression](https://stackoverflow.com/questions/2145804/extra-backslash-needed-in-php-regexp-pattern)
[PHP regular expression](http://www.regular-expressions.info/php.html)

```php
"/(?:\\\\[trn])+/"
 `$str = preg_split('/\\\\/', $str, -1, PREG_SPLIT_NO_EMPTY);`
```

gethostbyname

```
/home/ffz# php -r "echo gethostbyname('www.baidu.com').PHP_EOL;"
112.80.248.74
```


// bool true on success or false on failure. 不能将settype()的结果直接赋值给变量

[format json string]( https://www.daveperrett.com/articles/2008/03/11/format-json-with-php/)


### php 常见错误

注意定义常量的方式,之前犯过错误

// Use of undefined constant N_DEBUG - assumed 'N_DEBUG'

defined('N_TEST') or define('N_TEST', false);

PDO::quote() expects parameter 1 to be string, array given

db->quote 只是加一对单引号,不能正确反引表名称和列名称

array_key_exists() expects parameter 2 to be array, null given

类型一定要确定好.


尽管 = 比其它大多数的运算符的优先级低，PHP 仍旧允许类似如下的表达式：if (!$a = foo())，在此例中 foo() 的返回值被赋给了 $a。

### PDO 的异常处理设置

$pdo = new PDO('mysql:host=localhost;dbname=someTable', 'username', 'password', array(
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
));


### set protected and private member accessble

```
$app = $this->app;
$db = $app->stubdb;
$this->assertInstanceOf('\\PDO',$db);
$r = new  \ReflectionObject($app->container);
$p = $r->getProperty('_singletons');
$p->setAccessible(true); // <--- you set the property to public before you read the value
$singletons= $p->getValue($app->container);
```



### composer
```
command 预加载位置

Difference between composer prefer-dist and prefer-source?(https://stackoverflow.com/questions/16205100/difference-between-composer-prefer-dist-and-prefer-source)


根据composer command 查找对应的command类
reate installed repo,


包解析的关键位置:    /home/wwwroot/composer/src/Composer/Installer.php

$operations = $this->processDevPackages($localRepo, $pool, $policy, $repositories, $installedRepo, $lockedRepository, 'force-updates', $operations);


composer 从缓存中读取的代码:

/home/wwwroot/composer/src/Composer/Cache.php:copyTo

实际下载是从这里取:
/home/wwwroot/composer/src/Composer/Util/RemoteFilesystem.php:copy和get方法

/home/wwwroot/composer/src/Composer/Cache.php:compyFrom 方法将从远程下载的文件拷贝到本地缓存中,以供下次使用.比如
source:/home/wwwroot/composer/vendor/symfony/polyfill-mbstring/19de91df66981b5ea94d6c7c3c497cd6
toChache:/root/.composer/cache/files/symfony/polyfill-mbstring/624d730be0ea9edd5c8cfeb4aaf5d697d56f706b.zip


composer.lock 相关的信息构建的位置为:
/home/wwwroot/composer/src/Composer/Package/Dumper/ArrayDumper.php:dump:$data['time'] = $package->getReleaseDate()->format('Y-m-d H:i:s');
```



跟踪过程:

```
namespace Yunniao\Utils\Log\Handlers:getInstance():

$driver = config('ynlog.driver');
$appName = config('app.app_name', basename(base_path())); // 在具体某一次的发布版本里边, base_path 都取得是这里发布的release目录号
$category = $appName . '.' . $category;



use Yunniao\\Utils\\Log\\Processors\\RequestLogProcessor

./current/vendor/yunniao/utils/src/Log/Logger.php:6:use Yunniao\Utils\Log\Processors\RequestLogProcessor;


Yunniao\\Utils\\Log\\Logger;

./current/vendor/yunniao/utils/src/Log/Providers/LoggerServiceProvider.php:6:use Yunniao\Utils\Log\Logger


current/vendor/illuminate/support/ServiceProvider.php:63:    protected function mergeConfigFrom($path, $key)


各个项目的配置同这个目录下的配置进行一次合并即可(项目配置覆盖库的默认配置)
./current/vendor/yunniao/utils/src/config/ynlog.php


vendor/yunniao/utils/src/Log/Processors/RequestLogProcessor.php:writeFile 问base具写log的信息的处理方式


log type 属性目前有四种值, 分别是: "single", "daily", "hourly", "fluentd" 四种

'type' => env('APP_REQUEST_LOG_TYPE', 'daily'),
```


表模式替换正则:

```
`(\w+)`([^`]+)'([^']+)',$

'$1', // '$3'
```

$a = "world";
$a = $a ? : "hello";

// $a = "world";


### yaml 文件解析

```
php -r 'var_export(yaml_parse_file("config/bigscreen.yaml"));'
```


### PHP 7 新特性

```
标量类型声明 有两种模式: 强制 (默认) 和 严格模式。 现在可以使用下列类型参数（无论用强制模式还是严格模式）： 字符串(string), 整数 (int), 浮点数 (float), 以及布尔值 (bool)。它们扩充了PHP5中引入的其他类型：类名，接口，数组和 回调类型。

返回值类型声明:
function arraysSum(array ...$arrays): array

通过 define() 定义常量数组


// 闭包的执行
Closure::call()




assert:
<?php
ini_set('assert.exception', 1);

class CustomError extends AssertionError {}

assert(false, new CustomError('Some error message'));
?>
以上例程会输出：

Fatal error: Uncaught CustomError: Some error message


preg_replace_callback_array() 

// php7 才支持
(clone $foo)->bar()

```


* 理解了了php数组的底层实现方式(通过的在bucket中存放整个list中的连接关系,及每个bucket在传统拉链发bucket持有的pNext,pLast指针的基础上, 增加了pListNext,pListLast两个指针存放在整个数组中的链接关系)  这事php数组的实现原理.

```
HashTable->index(slot)->bucket->linkedList->item(pData,pDataPtr)
```

