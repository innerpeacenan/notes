public static function createObject($config)
{
	if (is_string($config)) {
		// 取单例
		return static::$container->get($config);
	} elseif (is_array($config) && isset($config['class'])) {
		$class = $config['class'];

		// bug: /home/wwwroot/www.note.com/libary/nxn/N.php
		// 用 get 方法是非常错误的
		return static::$container->get($class, self::get($config['params']), self::get($config['config']));
	} else {
		throw new \Exception('Unsupported configuration type: ' . gettype($config));
	}
}


empty: php empty() 的含义
"" (an empty string)
0 (0 as an integer)
0.0 (0 as a float)
"0" (0 as a string)
NULL
FALSE
array() (an empty array)
$var; (a variable declared, but without a value)



/**
 * if you what to run other action, even cross controller, just reset router and call [[ runAction() ]]
 * @return void
 * @throws \Exception
 *
 */
public function setRouter($router = null)
{
//如果从来没有设置过,则从url中解析
	if ($router === null) {
		// 从 url 中解析  getfriends?fid=2Action
		$baseUrl = explode('?', $_SERVER['REQUEST_URI'])[0];
		// must trim the leading slash in request url. learn more about http
		// 这里主意运算符的优先级别
		if (($rest = trim($baseUrl, '/')) !== '') {
			// 经验教训: explode 之前,先检查 trim 结果是否为空
			$part = explode('/', $rest);
			if (!empty($part)) {
				$this->action = lcfirst(str_replace('-', '', ucwords(array_pop($part), '-')));
			}
			if (!empty($part)) {
				$this->controller = str_replace('-', '', ucwords(array_pop($part), '-'));
			}
			if (!empty($part)) {
				$this->module = lcfirst(str_replace('-', '', ucwords(array_pop($part), '-')));
			}
			if (!empty($part)) {
				throw new \Exception('400 bad request!');
			}
		}
		$this->router = [
			'module' => $this->module,
			'controller' => $this->controller,
			'action' => $this->action
		];
	} else {
		$this->router = $router;
	}
	$controller = $this->getControllerName($this->router);
	$this->controller = new $controller();
	$this->action = $this->router['action'] . 'Action';
	if (!method_exists($this->controller, $this->action)) {
		throw new \Exception('404 bad request! the controller file is:' . $this->getControllerName($this->router));
	}
}




Uncaught SyntaxError: Invalid or unexpected token
没有用括号把属性包起来会报这个错误


### 这桩方式没有语法错误的，只要定义了，哪怕赋值了 null
$undefined = null;
if(!$undefined){
	echo 'pub_goods';
}




重要:
one base and zero base convertion:
length = index + 1;



//            @todo 一定要考虑到最后没有斜线的时候,那是循环终止的条件 @nxn 复习
$list = ['action', 'controller', 'module'];
foreach ($list as $i => $item) {
	if (($pos = strrpos($haystack, '/')) !== false) {
		$this->$item = lcfirst(str_replace('-', '', ucwords(substr($haystack, $pos + 1), '-')));
		// 因为之前都已经去除过斜线了,所以不用但心越界
		$haystack = substr($haystack, 0, $pos);// 第二ge参数是长度,有他妈的忘了
	} else {
		// 找不到任何一个斜线,说明是最后一部分,直接赋值给 action 部分
		// simple merge
		$this->$item = $haystack;
		break;
	}
}


