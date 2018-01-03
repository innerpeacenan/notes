### iframe 或多级frame环境下,juery选择器的应用

```
$(".pur_" + <?=$val['id']?>, parent.document)
```

### functions
* jquery replaceWith
```
var html = "html字符串";
    $('.current-tr').replaceWith(html);
```
```
Array.prototype.sort()

Syntax
arr.sort()
arr.sort(compareFunction)
```

> f compareFunction is not supplied, elements are sorted by converting them to strings and comparing strings in Unicode code point order. For example, "80" comes before "9" in Unicode order.
```
var scores = [1, 10, 21, 2]; 
scores.sort(); // [1, 10, 2, 21]
// Watch out that 10 comes before 2,
// because '10' comes before '2' in Unicode code point order.
```
To compare numbers instead of strings, the compare function can simply subtract b from a. The following function will sort the array ascending (if it doesn't contain Infinity and NaN):

```
function compareNumbers(a, b) {
  return a - b;
}
```

```
  //keep left alignment with its parent
  $(obj).next().css('left',$(obj).position().left+'px');
```


* js 伪选择器 psudo selector
```
:button 表示选择任何按钮 (input[type=submit],input[type=reset],input[type=button]或button
:checked 表示选择已选中的复选框或单选按钮
```


* json如果什么也没返回，则在js中，返回的json对象
```
console.debug(data ==="");//true
console.debug(data =="");//ture
console.debug(data.status ==0);//true
```



* 对象特征
if js object's element with same key,the later will override the former
```
a = {"1":1,"1":2};
a['1'];//2
```

* enable or disable form submit
jquery 阻止表单提交
```
$('form').submit(function (){return false;})
```
禁止后可以通过下列代码启用js
```
$('form').unbind('submit');
```

* 禁用FF的缓存： 禁止页面缓存
> 在Firefox的地址栏中输入“about:config”回车，打开详细配置页面, 找到 browser.cache.disk.enable ，将其值设置为false，FF就不会向磁盘写入缓存了。

* 刷新页面 refresh page
window.location.reload()

* 禁止页面重载
```
window.onbeforeunload = function() {
        return "Dude, are you sure you want to leave? Think of the kittens!";
    }
```   
    
* 窗口控制
```
//历史记录回退１
self.history.go(-1);
//刷新父级窗口
window.parent.location.reload()
```


* 正则表达式贪婪与懒惰模式
>yii表名匹配
```
(preg_match('/^(.*?)\s+({{\w+}}|\w+)$/', $table, $matches)) 
```
* jquery 中checkbox:(判断checkbox是否被选中)
```
if ( elem.checked ) 
if ( $(elem).prop("checked") ) 
if ( $(elem).is(":checked") ) 
``` 
 
 
 ### 不要用块状注释注释正则表达式 ### 
> 以下会报错

``` /* var a = /a*/.match(a); */```

用Object.hasOwnProperty(varible)来确定这个属性名是该对象的成员，还是来自于原型链

```
for (myvar in obj){
  if(obj.hasOwnProperty(myvar)){
    //TODO
  }
}
```

> javascript 字面量
数组字面量，数组是有序，下表必须为数字 [],
对象字面量是无序的，{},
正则表达式字面量   //
数字和字符串都鼓励用直接量，所有数字和字符串都是对象
访问数组的方式[]和
在javascript中，不可变的原始值和可变的对象的引用
原始值的比较是值的比较，对象的比较是引用的比较
但null===null,说明所有null引用自同一个原始值

NaN！==NaN，因为NaN是一个确定的数字


> 而在PHP中，数组下标既可以是数字，也可以是字母，是字母的情况下，成为关联数组
> 对象则无字面量，都是通过新建和相互继承产生的


* 异步请求
> 获取集合中第一个匹配元素的HTML内容 或 设置每一个匹配元素的html内容。
```
$("#detail").html(obj["basic_information"]);//设置元素的值 
```
> js中采用+连接字符串    
> $.ajax({})中data属性的value为对象，不能加在对象上加引号

```
<script type="text/javascript">
$(function(){    
    $(".show").each(function (){
        $(this).click(function(){
           $.ajax({
             type : "POST",
             url  : "http://localhost:8888/detailAction.php",
             data : {"id":'"'+$(this).find('input').val()+'"'},//js + 连接,javascript对象
             success:function (str){
                 obj = JSON.parse(str);
                 //非法赋值
                // $("#detail").html() = obj;//逻辑错误，将函数返回值作为变量处理。  
                 $("#detail").html(obj["basic_information"]);       
             },
             error:function(){
                 
             }
            }); 
        })
    })
})
</script>
```
* jQuery.ajax( [settings ] )

> `dataType (default: Intelligent Guess (xml, json, script, or html))`

> "json":把响应的结果当作 JSON 执行，并返回一个JavaScript对象。
跨域"json" 请求转换为"jsonp"，除非该请求在其请求选项中设置了jsonp:false。
JSON 数据以严格的方式解析; 任何畸形的JSON将被拒绝，并且抛出解析错误信息。
在jQuery1.9中，一个空响应也将被拒绝;服务器应该返回null或 {}响应代替。
（见json.org的更多信息，正确的JSON格式。）


* 正则表达式
(?<=\$\(["|']\#)[\w]*\b
匹配juery格式的选择符

```
(?<=    # 断言要匹配的文本的前缀
<(\w+)> # 查找尖括号括起来的字母或数字(即HTML/XML标签)
)       # 前缀结束
.*      # 匹配任意文本
(?=     # 断言要匹配的文本的后缀
<\/\1>  # 查找尖括号括起来的内容：前面是一个"/"，后面是先前捕获的标签
)       # 后缀结束
```
```
<(\w+)>   匹配html标签
<h1></h1>
(?!=<)(\w+)(?=>)  匹配html标签内容
```

#### Function.prototype.apply()
[apply](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply)

> fun.apply(thisArg, [argsArray])
```
thisArg
The value of this provided for the call to fun. Note that this may not be the actual value seen by the method: if the method is a function in non-strict mode code, null and undefined will be replaced with the global object, and primitive values will be boxed.
```

#### Function.prototype.call()
[call](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)

> function.call(thisArg, arg1, arg2, ...)

> Note: While the syntax of this function is almost identical to that of apply(), the fundamental difference is that call() accepts an argument list, while apply() accepts a single array of arguments.

#### Array.prototype.slice()
[slice]()

> The slice() method returns a shallow copy of a portion of an array into a new array object selected from begin to end (end not included). The original array will not be modified.

> arr.slice()

>  arr.slice(begin)

>  arr.slice(begin, end)

**begin**   Optional

> Zero-based index at which to begin extraction.

> As a negative index, begin indicates an offset from the end of the sequence. slice(-2) extracts the last two elements in the sequence.
If begin is undefined, slice begins from index 0.

**end** Optional
>  Zero-based index at which to end extraction. slice extracts up to but not including end.

> slice(1,4) extracts the second element through the fourth element (elements indexed 1, 2, and 3).


### 类型判断

#### 字符串判断
```
/**
 * Check for string
 * @param {Object} s
 */
function isString(s) {
    return typeof s === 'string';
}
```

#### 数组判断
```
/**
* check for array
* @param {Object} obj
*/
function isArray (obj){
    return Object.prototype.toString.call(obj) === '[object Array]';
}
```


### 对象判断
```
/**
 * Check for object
 * @param {Object} obj
 */
function isObject(obj) {
    return obj && typeof obj === 'object';
}
```

### 数字判断(强类型)
```
/**
 * Check for number
 * @param {Object} n
 */
function isNumber(n) {
    return typeof n === 'number';
}
```

### undefined
var UNDEFINED;
options !== UNDEFINED

## 其他
#### pushState
pushState 是一个可以操作history的api
Pjax是ajax与pushState结合封装(juery有对应的方法)

### arguments
```
var args = Array.prototype.slice.call(arguments);
var args = [].slice.call(arguments)

// remove args[0] for the orignal arguments
args = Array.prototype.slice.call(args, 1);
```


-------------------------------------------------------------------
### 固定表头的data table,非常重要,非常重要
https://datatables.net/extensions/fixedheader/examples/options/simple.html

<link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.1.2/css/fixedHeader.dataTables.min.css">
<script type="text/javascript" src="https://cdn.datatables.net/fixedheader/3.1.2/js/dataTables.fixedHeader.min.js"></script>
<script type="text/javascript">
    $('.table-sort').dataTable({
      fixedHeader: {
        header:true,
        footer:true
      },
      "lengthMenu":false,//显示数量选择
      "bFilter": false,//过滤功能
      "bPaginate": false,//翻页信息
      "bInfo": false,//数量信息
      "aaSorting": [[ 0, "asc" ]],//默认第几个排序
      "bStateSave": false,//状态保存
      "bAutoWidth": false,
      "aoColumnDefs": [
        //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
        {"orderable":false,"aTargets":[]}// 制定列不参与排序
      ]
    });


PHP_SESSION_NONE
Jquery + Ajax Form Requires Two Clicks to Submit

### highcharts 源码解读
```
/**
 * Return the first value that is defined. Like MooTools' $.pick.
 */
var pick = Highcharts.pick = function () {
	var args = arguments,
		i,
		arg,
		length = args.length;
	for (i = 0; i < length; i++) {
		arg = args[i];
		if (arg !== UNDEFINED && arg !== null) {
			return arg;
		}
	}
};
```

注意第二个参数是指针
function indexOf(array, value) {
  for (var i = 0, len = array.length; i < len; i++) {
	if (array[i] === value) {
	  return i;
	}
  }
  return -1;
}


function isEmpty(value) {
  if (!value && value !== 0) {
	return true;
  } else if (isArray(value) && value.length === 0) {
	return true;
  } else {
	return false;
  }
}



重载也是多态的一种体现。重载就是同名方法的多个实现。依靠参数的类型和参数的个数来区分和识别。在js中，函数的参数是没有类型的，并且参数的个数是任意的。

### html input 输入历史缓存问题的解决方案
```
    方法一：
     在不想使用缓存的input中添加 autocomplete="off";
<br>

    方法二：
    在 input 所在的form标签中添加 autocomplete="off";
```

js:缓存运算结果
function calculator(params) {
  var cacheKey = JSON.stringify(params);
  var cache = calculator.cache = calculator.cache || {};
  if(typeof cache[cacheKey] !== 'undefined') {
    return cache[cacheKey];
  }
  //大量耗时的计算
  cache[cacheKey] = result;
  return result;
}


jQuery.post( url [, data ] [, success ] [, dataType ] )

success
类型:Function( PlainObject data, String textStatus, jqXHR jqXHR )
当请求成功后执行的回调函数。 如果提供dataType选项，那么这个success选项是必须的， 但这种情况下你可以使用null。


dataType
类型:String
从服务器返回的预期的数据类型。默认：智能猜测（xml, json, script, text，html）。



You can just animate to scroll down the page by animating the scrollTop property, no plugin required, like this:

$(window).load(function() {
  $("html, body").animate({ scrollTop: $(document).height() }, 1000);
});

Note the use of window.onload (when images are loaded...which occupy height) rather than document.ready.

To be technically correct, you need to subtract the window's height, but the above works:

$("html, body").animate({ scrollTop: $(document).height()-$(window).height() });

To scroll to a particular ID, use its .scrollTop(), like this:

$("html, body").animate({ scrollTop: $("#myID").scrollTop() }, 1000);


锻炼正则(掌握基础):
这篇帖子介绍url标准
http://www.cnblogs.com/vleung/p/4152262.html


如果我们不想用submit按钮来提交表单，我们也可以用超链接来提交，我们可以这样写代码：
<a href=”javascript: document.myform.submit();”>Submit Me</a>


### javascript:

/*字符串截取*/
String.substr(start,[length]);//与php中substr()类似，从起始索引号提取字符串中指定数目的字符
第一个参数代表开始位置,第二个参数代表截取的长度

String.substring(start,[end])
第一个参数代表开始位置,第二个参数代表结束位置的下一个位置;若参数值为负数,则将该值转为0;两个参数中,取较小值作为开始位置,截取出来的字符串的长度为较大值与较小值之间的差.

String.slice(start,[end])//与python中的切片一样
第一个参数代表开始位置,第二个参数代表结束位置的下一个位置,截取出来的字符串的长度为第二个参数与第一个参数之间的差;若参数值为负数,则将该值加上字符串长度后转为正值;若第一个参数等于大于第二个参数,则返回空字符串.

String.indexOf();//与php strpos()类似，返回字符串中匹配子串的第一个字符的下标

/*字符串与数组*/
String.split();// 使用一个指定的分隔符把一个字符串分割存储到数组
str="jpg|bmp|gif|ico|png";
arr=str.split("|"); //["jpg", "bmp", "gif", "ico", "png"]

Array.join(); //使用您选择的分隔符将一个数组合并为一个字符串
myList=new Array("jpg","bmp","gif","ico","png");
portableList=myList.join("|");//"jpg|bmp|gif|ico|png"

### 字符串反转
strrev($a);
JSON.stringify


javascript:
https://www.cambiaresearch.com/articles/15/javascript-char-codes-key-codes



vue 源码阅读
/**
 * Remove an item from an array
 */
function remove (arr, item) {
	if (arr.length) {
		var index = arr.indexOf(item);
		if (index > -1) {
			return arr.splice(index, 1)
		}
	}
}

hasOwnProperty

   /**
     * Simple bind, faster than native
     */
    function bind (fn, ctx) {
        function boundFn (a) {
            var l = arguments.length;
            return l
                ? l > 1
                ? fn.apply(ctx, arguments)
                : fn.call(ctx, a)
                : fn.call(ctx)
        }
        // record original fn length
        boundFn._length = fn.length;
        return boundFn
    }







冻结多列:
https://datatables.net/extensions/fixedcolumns/examples/initialisation/two_columns.html

浏览器检测:
// Browser environment sniffing
var inBrowser = typeof window !== 'undefined';
var UA = inBrowser && window.navigator.userAgent.toLowerCase();
var isIE = UA && /msie|trident/.test(UA);
var isIE9 = UA && UA.indexOf('msie 9.0') > 0;
var isEdge = UA && UA.indexOf('edge/') > 0;
var isAndroid = UA && UA.indexOf('android') > 0;
var isIOS = UA && /iphone|ipad|ipod|ios/.test(UA);
var isChrome = UA && /chrome\/\d+/.test(UA) && !isEdge;


debounce(fn, wait, [ immediate || false ])
Creates and returns a new debounced version of the passed function that will postpone its execution until after wait milliseconds have elapsed since the last time it was invoked.

Pass true for the immediate parameter to cause debounce to trigger the function on the leading edge instead of the trailing edge of the wait interval. Useful in circumstances like preventing accidental double-clicks on a "submit" button from firing a second time.

The debounced function returned also has a property 'clear' that is a function that will clear any scheduled future executions of your function.

I need help writing a text highlight filter using vuejs. The idea is to loop through a given array of words and if there is a match, apply a span with a class to that word. The problem I have is that, I can't seem to return data with html formatting with vuejs. Any ideas will be highly appreciated. I am really stuck with this.



Object.freeze(obj)

// 严格模式时,编辑对象会报错.还会报错



















