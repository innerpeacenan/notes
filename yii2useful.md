[TOC]:
### json
* yii2 中设置json返回
```
    public function actionIndex (){
        $users = PubUser::find()->asArray()->limit(10)->all();
        //设置以json格式返回
        Yii::$app->response->format = Response::FORMAT_JSON;
        return $users;
    }
```

* yii model return as array
```
$data = User::find()
    ->select('id, name')
    ->where(['id' => $id])
    ->orderBy('id DESC')
    ->asArray()
    ->all();
```

* yii subQuery 子查询
> Let's say your model named YourModel representing table with name table. Then the query will be:
```
$subQuery = YourModel::find()->select('column2')->where(['column1' => 5]);
$query = YourModel::find()->where(['column1' => $subQuery]);
$models = $query->all();
```


### model
* db expression
> The method will automatically quote the column names unless a column contains some parenthesis
(which means the column contains a DB expression).

* how to use where condition
```
where conditon 的写法，yii重要页面
http://www.yiiframework.com/doc-2.0/yii-db-queryinterface.html#where()-detail
```

* 获取新插入的主键值

对于AR
```
$model->getPrimaryKey();
```
对于`YII::$app->db`;
```
$lastInsertID = $conqnection->getLastInsertID();
```

* yii\db\Query
```
//0 不会被认为空,因此,会出现大量的数据0未被过滤的情况
(new Query())->where($where);
```

### controller


#### request
* 获取请求参数 request
```
$r = "";
if(Yii::$app->request->isGet) {
    $r = Yii::$app->getRequest()->get();
}else{
    $r = Yii::$app->getRequest()->getBodyParams();
}
```


###  session
```
$this->uid = Yii::$app->session->get('uid');
```


### ajax (李军从tp移植过来的一个类)
```
use app\classes\Ajax;
```

#### action

* 李军配置的错误提示(需要前端layer)
```
protected function error($msg, $back = true)
{
    $msg = $msg ? $msg : '操作失败';
    $str = $back ? "s" : ";";
    $this->distpl($msg, $str, 0);
}
```


### view
* yii2中 视图层组件
```
<?php
use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;
use  yii\widgets\LinkPager;
```

* 面包屑
```
<?= \app\classes\Utility::navstring() ?>
```


* yii2中 视图层组件
```
<?php
use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;
use  yii\widgets\LinkPager;
<?= Html::beginForm(Url::to(['order-query/search']), 'get') ?>
<?= $this->render('@app/views/layouts/search.php', ['search' => $search]); ?>
<?= Html::submitButton('<i class="icon-search"></i>搜索', ['class' => 'btn btn-success']) ?>
<?= Html::endForm() ?>
?>
```


* 视图层加载js

```
<?php
<?= Html::jsFile('@web/js/jquery.min.1.8.1.js')?>
\app\assets\AppAsset::addScript($this, '@web/js/ffzpub/H-js-goodslabel.js?'.time());
?>



//js block
<?php $this->beginBlock('script') ?>
    $('.table-sort').dataTable({
        "lengthMenu": false,//显示数量选择
        "bFilter": false,//过滤功能
        "bPaginate": false,//翻页信息
        "bInfo": false,//数量信息
        "aaSorting": [[0, "asc"]],//默认第几个排序
        "bStateSave": false,//状态保存
        "bAutoWidth": false,
        "aoColumnDefs": [
            {"orderable": false, "aTargets": [6, 7]}// 制定列不参与排序
        ]
    });
<?php $this->endBlock() ?>
<?php $this->registerJs($this->blocks['script'], \yii\web\View::POS_END); ?>
```


* 加载css
```
$cssString = "";
$this->registerCss($cssString);
```


* html 组件示例
```
<div style="margin-top:50px;">
    <?= Html::a('<img id="img" src="'.Url::to('@web/images/shidebutton.png', true).'" border=0>', 'javascript:shleft();', ['title' => '点击缩放', 'class' => 'a', 'style'=>'cursor:hand'])?>
</div>
```


* render files in view, use alias
```php
<?= $this->render('@app/views/layouts/pages.php', ['pages' => $pages]); ?>
$this->renderFile('@app/views/layouts/nologin.php');
```
* 前端y页面刷新和跳转(前端插件配合)
```
<script type="text/javascript">
    $(function(){
        window_back(3);
    });
    function window_back(s){
        layer.msg('登录超时，请重新登录,'+s+'秒后跳转到登录页面...',3,8);
        if(s > 0){
            s--;setTimeout("window_back("+s+")",1000);
        }else{
            window.top.location.href='<?= \Yii::$app->request->hostInfo?>';
        }
    }
</script>
```

### 组件
#### 分页
action 控制器中写法
```
$pages = new Pagination(['totalCount' => $count, 'pageSize' => 20]);
$placeList = $query->offset($pages->offset)->limit($pages->limit)->orderBy('g.catepid,g.catessort,g.sort')->all();
```
view 视图层
李军配置的分页路径:
```
<?= $this->render('@app/views/layouts/pages.php', ['pages' => $pages]); ?>
分页设置:
<?= LinkPager::widget([
    'pagination' => $pages,
    'id' => 'pageNav',
    'class' => 'pageNav',
    'nextPageLabel' => '下一页',
    'prevPageLabel' => '上一页',
    'firstPageLabel' => '首页',
    'lastPageLabel' => '末页',
])?>
```

* 序号 index number
```
<td style="text-align:center;"><?=$pages->offset + $key+1?></td>
```


> end------------------------------------------------------------------------------------------------------------------------------------------



* think php 文件锁
```
if (F('stock_history')) {
    $this->ajaxReturn(0, '当前正在生成日结!');
}
```

* 定义ajax类家在路径

```
Yii::$classMap['Ajax'] = '@app/classes/Ajax.php';
```


* params
```
Yii::$app->params['tempDepotId']
````

* framset 中通过一个页面操作另外一个的方式,修改另外一个页面的location属性
```
parent.frames.frames['goods'].location.replace('/renovation/web/ffzpub/depot-frame/goods.jsp?id='+id+'&account='+account);
```

* Controller Generator
```
This generator helps you to quickly generate a new controller class with one or several controller actions and their corresponding views.
Controller Class
app\modules\ffzpub\controllers\DepotFrameController
Action IDs 
del ,edit,head,depot-menu,goods,footer,goods-depot-modify
View Path 
../modules/ffzpub/views/depot-frame
Base Class
yii\web\Controller
```

pdb python单步调试工具



```
* yii before save example
public function beforeSave($insert)
{
    if (parent::beforeSave($insert)) {
        if ($insert) { // only on insert
            $nomor = Request::find()->select('max(nomor_surat) as max')->scalar();
            $this->nomor_surat = $nomor + 1;
        }
        return true;
    }
    return false;
}

```

```
$pagination = new Pagination();
        $basequery->offset($pagination->offs et);
        $basequery->limit($pagination->pageSize);

$param = Yii::$app->request->get();
$search = [];
$search = array_merge($search,$param);
```

```
$data = (new Query())->select([''])->from([''=>])->innerJoin([''=>],'')->where()->all();
```


* 在别的控制器调用这个控制器的方法
```
Yii::$app->runAction ('controller/action',[params])
```


*  get table name list
```
TableName::model()->getTableSchema()->getColumnNames();
```


### source code
* Yii::getAlias
```
$file = Yii::getAlias('@vendor/yiisoft/extensions.php');
```


```
$this->extensions = is_file($file) ? include($file) : [];```
```

```
//        echo $_SERVER['REMOTE_ADDR'];exit();
```


* return the first part separate by '/'
```
$pos = strpos($alias, '/');
$root = $pos === false ? $alias : substr($alias, 0, $pos);
```

```
        //计算group by的结果的数量,必须在子查询中加select语句
        $nowDelivaryCount = (new Query())->from(['d' => BsnsDelivary::tableName()])
            ->select('di.packtypeid')
            ->innerJoin(['di' => BsnsDelivaryInfo::tableName()], 'di.delivarygid = d.id and d.addtime >' . $startTimestamp . ' and d.addtime < ' . $endTimestamp . ' and di.delivernum > 0')
            ->innerJoin(['p' => PubPacktype::tableName()], 'di.packtypeid = p.id')
            ->innerJoin(['g' => PubGoods::tableName()], 'p.goodsid = g.id')
            ->groupBy('di.packtypeid')
            ->count('packtypeid');
```

yiisoft 搜索目录
/home/wwwroot/erp.ty.com/ffzerp2.0/renovation/vendor/yiisoft

### 日期时间处理
```
$startTimestamp = $startTime ? strtotime($startTime) : $this->getunixtime();
$endTimestamp = $endTime ? strtotime("+1 days", strtotime($endTime)) : $this->getunixtime($startTime, '+1');
// 间隔天数 20170101-20170202 直接的timezone怎么是两天呢 哦,明白了,endtime多加了一天
$timeZone = ($endTimestamp - $startTimestamp) / (24 * 3600);
```

### yii\db\Query 我自己加的表关联检查

```
    /**
     * check.
     * @access
     * @return void
     * Description:
     * 检查是否遗漏了条件on条件,这一块容易写错,所以容易为被,可以用来自我提示,未被处理
     * 当然,只针对现在的表,因为现在表都没有外键
     */
    public function check (){
        // use isset ,or Invalid argument supplied for foreach()
        if(isset($this->join)){
            foreach ($this->join AS $join){
                if(empty($join[2])){
                    throw new \Exception("tables: ".join(' ',array_values($join[1]))." have no on condition!909312359");
                }
            }
        }
    }
```
----------------------------------------------------------------------------------------------------

###

Yii::$app->urlManager->createUrl(['news/item-detail' , 'id'=> $item['id']]


###
  /**
     * Performs the actual DB query of a SQL statement.
     * @param string $method method of PDOStatement to be called
     * @param integer $fetchMode the result fetch mode. Please refer to [PHP manual](http://www.php.net/manual/en/function.PDOStatement-setFetchMode.php)
     * for valid fetch modes. If this parameter is null, the value set in [[fetchMode]] will be used.
     * @return mixed the method execution result
     * @throws Exception if the query causes any problem
     * @since 2.0.1 this method is protected (was private before).
     */
    protected function queryInternal($method, $fetchMode = null)
    {
        $rawSql = $this->getRawSql();
        if ($method !== '') {
            $info = $this->db->getQueryCacheInfo($this->queryCacheDuration, $this->queryCacheDependency);
            if (is_array($info)) {
                /* @var $cache \yii\caching\Cache */
                $cache = $info[0];
                $cacheKey = [
                    __CLASS__,
                    $method,
                    $fetchMode,
                    $this->db->dsn,
                    $this->db->username,
                    $rawSql,
                ];
                $result = $cache->get($cacheKey);
                if (is_array($result) && isset($result[0])) {
                    return $result[0];
                }
            }
        }

        $this->prepare(true);

        $token = $rawSql;
        try {
            $this->pdoStatement->execute();

            if ($method === '') {
                $result = new DataReader($this);
            } else {
                if ($fetchMode === null) {
                    $fetchMode = $this->fetchMode;
                }
                $result = call_user_func_array([$this->pdoStatement, $method], (array) $fetchMode);
                $this->pdoStatement->closeCursor();
            }
        } catch (\Exception $e) {
            throw $this->db->getSchema()->convertException($e, $rawSql);
        }
        return $result;
    }


/**
 * Executes the SQL statement and returns the value of the first column in the first row of data.
 * This method is best used when only a single value is needed for a query.
 * @return string|null|false the value of the first column in the first row of the query result.
 * False is returned if there is no value.
 * @throws Exception execution failed
 */
public function queryScalar()
{
	$result = $this->queryInternal('fetchColumn', 0);
	if (is_resource($result) && get_resource_type($result) === 'stream') {
		return stream_get_contents($result);
	} else {
		return $result;
	}
}



if(!isset($commission)) $this->error('记录不存在');
$data['id'] = $param['id'];
$data['userid'] = $param['userid'];
$data['salscale'] =$param['salscale'];
$data['svrscale'] = $param['svrscale'];
$data['groupid'] = $param['groupid'];
$data['groupscale'] = $param['groupscale'];
$data['admingroups'] = join(',',$param['admingroups']);
$data['adminscale'] = $param['adminscale'];
$commission->attributes = $data;
$is_saved = $commission->update($data);




protected function rotateFiles()
{
	$file = $this->logFile;
	for ($i = $this->maxLogFiles; $i >= 0; --$i) {
		// $i == 0 is the original log file
		$rotateFile = $file . ($i === 0 ? '' : '.' . $i);
		if (is_file($rotateFile)) {
			// suppress errors because it's possible multiple processes enter into this section
			if ($i === $this->maxLogFiles) {
				@unlink($rotateFile);
			} else {
				if ($this->rotateByCopy) {
					@copy($rotateFile, $file . '.' . ($i + 1));
					if ($fp = @fopen($rotateFile, 'a')) {
						@ftruncate($fp, 0);
						@fclose($fp);
					}
				} else {
					@rename($rotateFile, $file . '.' . ($i + 1));
				}
			}
		}
	}
}


### yii2 swift 发邮件
你测试的username是不是不用加@163.com 我测试不用加可以发送，加上后就发送不成功




### 魔术方法
__call
```
// yii中call方法实现behavior的机制
    /**
     * Calls the named method which is not a class method.
     *
     * This method will check if any attached behavior has
     * the named method and will execute it if available.
     *
     * Do not call this method directly as it is a PHP magic method that
     * will be implicitly called when an unknown method is being invoked.
     * @param string $name the method name
     * @param array $params method parameters
     * @return mixed the method return value
     * @throws UnknownMethodException when calling unknown method
     */
    public function __call($name, $params)
    {
        $this->ensureBehaviors();
        foreach ($this->_behaviors as $object) {
            if ($object->hasMethod($name)) {
                return call_user_func_array([$object, $name], $params);
            }
        }
        throw new UnknownMethodException('Calling unknown method: ' . get_class($this) . "::$name()");
    }

// 销毁一个对象的一个方法的时候，把behavior对象的对应方法也销毁
    /**
     * Sets a component property to be null.
     * This method will check in the following order and act accordingly:
     *
     *  - a property defined by a setter: set the property value to be null
     *  - a property of a behavior: set the property value to be null
     *
     * Do not call this method directly as it is a PHP magic method that
     * will be implicitly called when executing `unset($component->property)`.
     * @param string $name the property name
     * @throws InvalidCallException if the property is read only.
     * @see http://php.net/manual/en/function.unset.php
     */
    public function __unset($name)
    {
        $setter = 'set' . $name;
        if (method_exists($this, $setter)) {
            $this->$setter(null);
            return;
        } else {
            // behavior property
            $this->ensureBehaviors();
            foreach ($this->_behaviors as $behavior) {
                if ($behavior->canSetProperty($name)) {
                    $behavior->$name = null;
                    return;
                }
            }
        }
        throw new InvalidCallException('Unsetting an unknown or read-only property: ' . get_class($this) . '::' . $name);
    }

```



```
    /**
     * This method is called after the object is created by cloning an existing one.
     * It removes all behaviors because they are attached to the old object.
     */
    public function __clone()
    {
        $this->_events = [];
        $this->_behaviors = null;
    }
```


    /**
     * Returns the raw SQL by inserting parameter values into the corresponding placeholders in [[sql]].
     * Note that the return value of this method should mainly be used for logging purpose.
     * It is likely that this method returns an invalid SQL due to improper replacement of parameter placeholders.
     * @return string the raw SQL with parameter values inserted into the corresponding placeholders in [[sql]].
     */
    public function getRawSql()
    {
        if(!isset($file)){
            $file = (new \SplFileObject('/home/wwwroot/erp.ty.com/ffzerp2.0/renovation/sql.log','a'));
            $file ->fwrite("nxn时间:".date("Y-m-d H:i:s").PHP_EOL);

            $request_string = "请求:".PHP_EOL.Yii::$app->request->url.PHP_EOL.print_r($_GET+$_POST,true).PHP_EOL;
            $file ->fwrite($request_string);
        }
        if (empty($this->params)) {
            $file ->fwrite($this->_sql.";".PHP_EOL.PHP_EOL);
            return $this->_sql;
        }
        $params = [];
        foreach ($this->params as $name => $value) {
            if (is_string($name) && strncmp(':', $name, 1)) {
                $name = ':' . $name;
            }
            if (is_string($value)) {
                $params[$name] = $this->db->quoteValue($value);
            } elseif (is_bool($value)) {
                $params[$name] = ($value ? 'TRUE' : 'FALSE');
            } elseif ($value === null) {
                $params[$name] = 'NULL';
            } elseif (!is_object($value) && !is_resource($value)) {
                $params[$name] = $value;
            }
        }
        if (!isset($params[1])) {
            $raw_sql = strtr($this->_sql, $params);
            $file ->fwrite($raw_sql.";".PHP_EOL.PHP_EOL);
            return strtr($this->_sql, $params);
        }
        $sql = '';
        foreach (explode('?', $this->_sql) as $i => $part) {
            $sql .= (isset($params[$i]) ? $params[$i] : '') . $part;
        }
        $file ->fwrite($sql.";".PHP_EOL.PHP_EOL);
        return $sql;
    }



### 这里便的方法目前来说是有问题的,带进一步修改
        $logFile = '/home/wwwroot/erp.ty.com/ffzerp2.0/renovation/sql.log';
        if(! file_exists($logFile) ) throw new \Exception("file does not exist!");
//        chmod($logFile,'777');
        $file = new \SplFileObject($logFile,'a');
        $file->fwrite(date("Y-m-d H:m:s").':'.PHP_EOL);
        //deal with deleted file, created by nan xiaoning
        if(preg_match('/^DELETE FROM \`(?<table>[A-Za-z0-9_]+)\` WHERE (?<condition>.+)\s*$/',$rawSql,$match_delete) === 1)  {
//            $class_post_fix = join('',array_map('ucwords',explode('_',ltrim($match_delete['table'],'ffz_'))));
//            $class_name = '\\app\\models\\'.$class_post_fix;
            //通过这里可以对不同的表做查询定制,结果非常好,有利于测试,goods
//            $oneRow = $class_name::find()->where(new Expression($match_delete));
//            pp($oneRow);
            $columns = Yii::$app->db->getTableSchema($match_delete['table'])->getColumnNames();
            $select_string = ' ';
            foreach ( $columns as $key => $column){
                if(preg_match('/time/',$column)) {
                    $select_string .= "case $column when $column is null then null else from_unixtime( $column ) end $column ".",";
                }else{
                    $select_string .= $column.",";
                }
            }
            //rtrim 只去除最后一个连续的字符,所以一定要确保最后一个字符是comma,该语句才有效
            $select_string = rtrim($select_string,',');
            $sql_delete = "select ". $select_string ." from ".$match_delete['table']." where ".$match_delete['condition'];
             $file->fwrite($sql_delete.";".PHP_EOL);
             $rows = Yii::$app->db->createCommand($sql_delete)->queryAll();
             if(isset($rows[0]['adduser']) ){
                 foreach ($rows as $key => $row){
                     $rows[$key]['adduser'] = Yii::$app->db->createCommand("select username from ffz_pub_user where id = ".$row['adduser'])->queryScalar();
                 }
             }
             $origionOne = print_r($rows,true);
            $file->fwrite($origionOne.";".PHP_EOL);
        }
        $file->fwrite($rawSql.";".PHP_EOL);
        $file = null;



yiibase.php 中的autoload函数
```
    public static function autoload($className)
    {
        if (isset(static::$classMap[$className])) {
            $classFile = static::$classMap[$className];
            if ($classFile[0] === '@') {
                $classFile = static::getAlias($classFile);
            }
        } elseif (strpos($className, '\\') !== false) {
            $classFile = static::getAlias('@' . str_replace('\\', '/', $className) . '.php', false);
            if ($classFile === false || !is_file($classFile)) {
                return;
            }
        } else {
            return;
        }
        include($classFile);
        if (YII_DEBUG && !class_exists($className, false) && !interface_exists($className, false) && !trait_exists($className, false)) {
            throw new UnknownClassException("Unable to find '$className' in file: $classFile. Namespace missing?");
        }
    }

```



get session in yii

 $userid =  yii::$app->session->get('uid');



```
batchInsert() public method

Creates a batch INSERT command.

For example,

$connection->createCommand()->batchInsert('user', ['name', 'age'], [
    ['Tom', 30],
    ['Jane', 20],
    ['Linda', 25],
])->execute();
```



insert() public method

Creates an INSERT command.

For example,

$connection->createCommand()->insert('user', [
    'name' => 'Sam',
    'age' => 30,
])->execute();


```
   public function __get($name)
    {
        $getter = 'get' . $name;
        if (method_exists($this, $getter)) {
            // read property, e.g. getName()
            return $this->$getter();
        } else {
            // behavior property
            $this->ensureBehaviors();
            foreach ($this->_behaviors as $behavior) {
                if ($behavior->canGetProperty($name)) {
                    return $behavior->$name;
                }
            }
        }
        if (method_exists($this, 'set' . $name)) {
            throw new InvalidCallException('Getting write-only property: ' . get_class($this) . '::' . $name);
        } else {
            throw new UnknownPropertyException('Getting unknown property: ' . get_class($this) . '::' . $name);
        }
    }

```

$bsnsPaid =  BsnsPaid::findOne($paidid);
$bsnsPaid =  $bsnsPaid ===null ? (new BsnsPaid()) : $bsnsPaid;



```
class Exception extends \Exception
{
    /**
     * @return string the user-friendly name of this exception
     */
    public function getName()
    {
        return 'Exception';
    }
}
```
```

```

```
use yii\db\StaleObjectException;

public function actionUpdate($id)
{
    $model = $this->findModel($id);

    try {
        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    } catch (StaleObjectException $e) {
        // logic to resolve the conflict
    }
}
```

```
   /**
     * Returns an iterator for traversing the attributes in the model.
     * This method is required by the interface [[\IteratorAggregate]].
     * @return ArrayIterator an iterator for traversing the items in the list.
     */
    public function getIterator()
    {
        $attributes = $this->getAttributes();
        return new ArrayIterator($attributes);
    }
```


//定义ajax类家在路径 @在此处作用
Yii::$classMap['Ajax'] = '@app/classes/Ajax.php';

//model层打印执行的错误
var_dump($info->getErrors());

```
 private static function loadFilesRecursive($key, $names, $tempNames, $types, $sizes, $errors)
    {
        if (is_array($names)) {
            foreach ($names as $i => $name) {
                self::loadFilesRecursive($key . '[' . $i . ']', $name, $tempNames[$i], $types[$i], $sizes[$i], $errors[$i]);
            }
        } elseif ($errors !== UPLOAD_ERR_NO_FILE) {
            self::$_files[$key] = new static([
                'name' => $names,
                'tempName' => $tempNames,
                'type' => $types,
                'size' => $sizes,
                'error' => $errors,
            ]);
        }
    }

```


$constructor = $reflection->getConstructor();

$constructor->getParameters()

$param->isDefaultValueAvailable()

$param->getDefaultValue()

$c = $param->getClass();

$c->getName();


public static function of($id)
{
    return new static($id);
}


if (is_array($callback)) {
    $reflection = new \ReflectionMethod($callback[0], $callback[1]);
} else {
    $reflection = new \ReflectionFunction($callback);
}



/**
 * Creates a new class instance from given arguments.
 * @link http://php.net/manual/en/reflectionclass.newinstanceargs.php
 * @param array $args [optional] <p>
 * The parameters to be passed to the class constructor as an array.
 * </p>
 * @return object a new instance of the class.
 * @since 5.1.3
 */
public function newInstanceArgs (array $args = null) {}



$dependencies[count($dependencies) - 1] = $config;





/**
 * Creates an instance of the specified class.
 * This method will resolve dependencies of the specified class, instantiate them, and inject
 * them into the new instance of the specified class.
 * @param string $class the class name
 * @param array $params constructor parameters
 * @param array $config configurations to be applied to the new instance
 * @return object the newly created instance of the specified class
 */
protected function build($class, $params, $config)
{
    /* @var $reflection ReflectionClass */
    list ($reflection, $dependencies) = $this->getDependencies($class);

    foreach ($params as $index => $param) {
        $dependencies[$index] = $param;
    }


    $dependencies = $this->resolveDependencies($dependencies, $reflection);
    if (empty($config)) {
        return $reflection->newInstanceArgs($dependencies);
    }

    if (!empty($dependencies) && $reflection->implementsInterface('yii\base\Configurable')) {
        // set $config as the last parameter (existing one will be overwritten)
        $dependencies[count($dependencies) - 1] = $config;
        return $reflection->newInstanceArgs($dependencies);
    } else {
        $object = $reflection->newInstanceArgs($dependencies);
        foreach ($config as $name => $value) {
            $object->$name = $value;
        }
        return $object;
    }
}


    public function setSingleton($class, $definition = [], array $params = [])
    {
        $this->_definitions[$class] = $this->normalizeDefinition($class, $definition);
        $this->_params[$class] = $params;
        $this->_singletons[$class] = null;
        return $this;
    }


    /**
     * Returns a value indicating whether the given name corresponds to a registered singleton.
     * @param string $class class name, interface name or alias name
     * @param boolean $checkInstance whether to check if the singleton has been instantiated.
     * @return boolean whether the given name corresponds to a registered singleton. If `$checkInstance` is true,
     * the method should return a value indicating whether the singleton has been instantiated.
     */
    public function hasSingleton($class, $checkInstance = false)
    {
        return $checkInstance ? isset($this->_singletons[$class]) : array_key_exists($class, $this->_singletons);
    }


    /**
     * Merges the user-specified constructor parameters with the ones registered via [[set()]].
     * @param string $class class name, interface name or alias name
     * @param array $params the constructor parameters
     * @return array the merged parameters
     */
    protected function mergeParams($class, $params)
    {
        if (empty($this->_params[$class])) {
            return $params;
        } elseif (empty($params)) {
            return $this->_params[$class];
        } else {
            $ps = $this->_params[$class];
            foreach ($params as $index => $value) {
                $ps[$index] = $value;
            }
            return $ps;
        }
    }




//@todo 这个是什么原理?
    /**
     * Returns the public member variables of an object.
     * This method is provided such that we can get the public member variables of an object.
     * It is different from "get_object_vars()" because the latter will return private
     * and protected variables if it is called within the object itself.
     * @param object $object the object to be handled
     * @return array the public member variables of the object
     */
    public static function getObjectVars($object)
    {
        return get_object_vars($object);
    }



   /**
     * Getter magic method.
     * This method is overridden to support accessing components like reading properties.
     * @param string $name component or property name
     * @return mixed the named property value
     */
    public function __get($name)
    {
        if ($this->has($name)) {
            return $this->get($name);
        } else {
            return parent::__get($name);
        }
    }




    /**
     * Checks if a property value is null.
     * This method overrides the parent implementation by checking if the named component is loaded.
     * @param string $name the property name or the event name
     * @return boolean whether the property value is null
     */
    public function __isset($name)
    {
        if ($this->has($name, true)) {
            return true;
        } else {
            return parent::__isset($name);
        }
    }



    /**
     * Returns a value indicating whether the locator has the specified component definition or has instantiated the component.
     * This method may return different results depending on the value of `$checkInstance`.
     *
     * - If `$checkInstance` is false (default), the method will return a value indicating whether the locator has the specified
     *   component definition.
     * - If `$checkInstance` is true, the method will return a value indicating whether the locator has
     *   instantiated the specified component.
     *
     * @param string $id component ID (e.g. `db`).
     * @param boolean $checkInstance whether the method should check if the component is shared and instantiated.
     * @return boolean whether the locator has the specified component definition or has instantiated the component.
     * @see set()
     */
    public function has($id, $checkInstance = false)
    {
        return $checkInstance ? isset($this->_components[$id]) : isset($this->_definitions[$id]);
    }





    /**
     * Returns an instance of the requested class.
     *
     * You may provide constructor parameters (`$params`) and object configurations (`$config`)
     * that will be used during the creation of the instance.
     *
     * If the class implements [[\yii\base\Configurable]], the `$config` parameter will be passed as the last
     * parameter to the class constructor; Otherwise, the configuration will be applied *after* the object is
     * instantiated.
     *
     * Note that if the class is declared to be singleton by calling [[setSingleton()]],
     * the same instance of the class will be returned each time this method is called.
     * In this case, the constructor parameters and object configurations will be used
     * only if the class is instantiated the first time.
     *
     * @param string $class the class name or an alias name (e.g. `foo`) that was previously registered via [[set()]]
     * or [[setSingleton()]].
     * @param array $params a list of constructor parameter values. The parameters should be provided in the order
     * they appear in the constructor declaration. If you want to skip some parameters, you should index the remaining
     * ones with the integers that represent their positions in the constructor parameter list.
     * @param array $config a list of name-value pairs that will be used to initialize the object properties.
     * @return object an instance of the requested class.
     * @throws InvalidConfigException if the class cannot be recognized or correspond to an invalid definition
     */
    public function get($class, $params = [], $config = [])
    {
        if (isset($this->_singletons[$class])) {
            // singleton
            return $this->_singletons[$class];
        } elseif (!isset($this->_definitions[$class])) {
            return $this->build($class, $params, $config);
        }

        $definition = $this->_definitions[$class];

        if (is_callable($definition, true)) {
            $params = $this->resolveDependencies($this->mergeParams($class, $params));
            $object = call_user_func($definition, $this, $params, $config);
        } elseif (is_array($definition)) {
            $concrete = $definition['class'];
            unset($definition['class']);

            $config = array_merge($definition, $config);
            $params = $this->mergeParams($class, $params);
/*
 * 非单例模式则重新生成对象
 */
            if ($concrete === $class) {
                $object = $this->build($class, $params, $config);
            } else {
                $object = $this->get($concrete, $params, $config);
            }
/*
 * 如果定义本身就是对象的,则说明时一个单例模式,直接返回该单例
 */
        } elseif (is_object($definition)) {
            return $this->_singletons[$class] = $definition;
        } else {
            throw new InvalidConfigException('Unexpected object definition type: ' . gettype($definition));
        }

        if (array_key_exists($class, $this->_singletons)) {
            // singleton
            $this->_singletons[$class] = $object;
        }

        return $object;
    }



/**
 * Class used to represent anonymous functions.
 * <p>Anonymous functions, implemented in PHP 5.3, yield objects of this type.
 * This fact used to be considered an implementation detail, but it can now be relied upon.
 * Starting with PHP 5.4, this class has methods that allow further control of the anonymous function after it has been created.
 * <p>Besides the methods listed here, this class also has an __invoke method.
 * This is for consistency with other classes that implement calling magic, as this method is not used for calling the function.
 * @link http://www.php.net/manual/en/class.closure.php
 */
final class Closure {

    /**
     * This method exists only to disallow instantiation of the Closure class.
     * Objects of this class are created in the fashion described on the anonymous functions page.
     * @link http://www.php.net/manual/en/closure.construct.php
     */
    private function __construct() { }

    /**
     * This is for consistency with other classes that implement calling magic,
     * as this method is not used for calling the function.
     * @param mixed $_ [optional]
     * @return mixed
     * @link http://www.php.net/manual/en/class.closure.php
     */
    public function __invoke(...$_) { }

    /**
     * Closure::bindTo � Duplicates the closure with a new bound object and class scope
     * @link http://www.php.net/manual/en/closure.bindto.php
     * @param object $newthis The object to which the given anonymous function should be bound, or NULL for the closure to be unbound.
     * @param mixed $newscope The class scope to which associate the closure is to be associated, or 'static' to keep the current one.
     * If an object is given, the type of the object will be used instead.
     * This determines the visibility of protected and private methods of the bound object.
     * @return Closure Returns the newly created Closure object or FALSE on failure
     */
    function bindTo($newthis, $newscope = 'static') { }

    /**
     * This method is a static version of Closure::bindTo().
     * See the documentation of that method for more information.
     * @static
     * @link http://www.php.net/manual/en/closure.bind.php
     * @param Closure $closure The anonymous functions to bind.
     * @param object $newthis The object to which the given anonymous function should be bound, or NULL for the closure to be unbound.
     * @param mixed $newscope The class scope to which associate the closure is to be associated, or 'static' to keep the current one.
     * If an object is given, the type of the object will be used instead.
     * This determines the visibility of protected and private methods of the bound object.
     * @return Closure Returns the newly created Closure object or FALSE on failure
     */
    static function bind(Closure $closure, $newthis, $newscope = 'static') { }

    /**
     * Temporarily binds the closure to newthis, and calls it with any given parameters.
     * @link http://php.net/manual/en/closure.call.php
     * @param object $newThis The object to bind the closure to for the duration of the call.
     * @param mixed $parameters [optional] Zero or more parameters, which will be given as parameters to the closure.
     * @return mixed
     * @since 7.0
     */
    function call ($newThis, ...$parameters) {}

}


    /**
     * Sends the response content to the client
     */
    protected function sendContent()
    {
        if ($this->stream === null) {
            echo $this->content;

            return;
        }

        set_time_limit(0); // Reset time limit for big files
        $chunkSize = 8 * 1024 * 1024; // 8MB per chunk

        if (is_array($this->stream)) {
            list ($handle, $begin, $end) = $this->stream;
            fseek($handle, $begin);
            while (!feof($handle) && ($pos = ftell($handle)) <= $end) {
                if ($pos + $chunkSize > $end) {
                    $chunkSize = $end - $pos + 1;
                }
                echo fread($handle, $chunkSize);
                flush(); // Free up memory. Otherwise large files will trigger PHP's memory limit.
            }
            fclose($handle);
        } else {
            while (!feof($this->stream)) {
                echo fread($this->stream, $chunkSize);
                flush();
            }
            fclose($this->stream);
        }
    }




   /**
     * Sends a file to the browser.
     *
     * Note that this method only prepares the response for file sending. The file is not sent
     * until [[send()]] is called explicitly or implicitly. The latter is done after you return from a controller action.
     *
     * @param string $filePath the path of the file to be sent.
     * @param string $attachmentName the file name shown to the user. If null, it will be determined from `$filePath`.
     * @param array $options additional options for sending the file. The following options are supported:
     *
     *  - `mimeType`: the MIME type of the content. If not set, it will be guessed based on `$filePath`
     *  - `inline`: boolean, whether the browser should open the file within the browser window. Defaults to false,
     *    meaning a download dialog will pop up.
     *
     * @return $this the response object itself
     */
    public function sendFile($filePath, $attachmentName = null, $options = [])
    {
        if (!isset($options['mimeType'])) {
            $options['mimeType'] = FileHelper::getMimeTypeByExtension($filePath);
        }
        if ($attachmentName === null) {
            $attachmentName = basename($filePath);
        }
        $handle = fopen($filePath, 'rb');
        $this->sendStreamAsFile($handle, $attachmentName, $options);

        return $this;
    }



   /**
     * Sends the specified stream as a file to the browser.
     *
     * Note that this method only prepares the response for file sending. The file is not sent
     * until [[send()]] is called explicitly or implicitly. The latter is done after you return from a controller action.
     *
     * @param resource $handle the handle of the stream to be sent.
     * @param string $attachmentName the file name shown to the user.
     * @param array $options additional options for sending the file. The following options are supported:
     *
     *  - `mimeType`: the MIME type of the content. Defaults to 'application/octet-stream'.
     *  - `inline`: boolean, whether the browser should open the file within the browser window. Defaults to false,
     *    meaning a download dialog will pop up.
     *  - `fileSize`: the size of the content to stream this is useful when size of the content is known
     *    and the content is not seekable. Defaults to content size using `ftell()`.
     *    This option is available since version 2.0.4.
     *
     * @return $this the response object itself
     * @throws HttpException if the requested range cannot be satisfied.
     */
    public function sendStreamAsFile($handle, $attachmentName, $options = [])
    {
        $headers = $this->getHeaders();
        if (isset($options['fileSize'])) {
            $fileSize = $options['fileSize'];
        } else {
            fseek($handle, 0, SEEK_END);
            $fileSize = ftell($handle);
        }

        $range = $this->getHttpRange($fileSize);
        if ($range === false) {
            $headers->set('Content-Range', "bytes */$fileSize");
            throw new HttpException(416, 'Requested range not satisfiable');
        }

        list($begin, $end) = $range;
        if ($begin != 0 || $end != $fileSize - 1) {
            $this->setStatusCode(206);
            $headers->set('Content-Range', "bytes $begin-$end/$fileSize");
        } else {
            $this->setStatusCode(200);
        }

		/**
		 * content-type 是 octet-stream 表明他就是一个字节流，浏览器默认处理字节流的方式就是下载。
		 * 我最开始说了呀，他就是用来下载使用的。
		*/
        $mimeType = isset($options['mimeType']) ? $options['mimeType'] : 'application/octet-stream';
        $this->setDownloadHeaders($attachmentName, $mimeType, !empty($options['inline']), $end - $begin + 1);

        $this->format = self::FORMAT_RAW;
        $this->stream = [$handle, $begin, $end];

        return $this;
    }


    /**
     * Sets a default set of HTTP headers for file downloading purpose.
     * @param string $attachmentName the attachment file name
     * @param string $mimeType the MIME type for the response. If null, `Content-Type` header will NOT be set.
     * @param boolean $inline whether the browser should open the file within the browser window. Defaults to false,
     * meaning a download dialog will pop up.
     * @param integer $contentLength the byte length of the file being downloaded. If null, `Content-Length` header will NOT be set.
     * @return $this the response object itself
     */
    public function setDownloadHeaders($attachmentName, $mimeType = null, $inline = false, $contentLength = null)
    {
        $headers = $this->getHeaders();

        $disposition = $inline ? 'inline' : 'attachment';
        $headers->setDefault('Pragma', 'public')
            ->setDefault('Accept-Ranges', 'bytes')
            ->setDefault('Expires', '0')
            ->setDefault('Cache-Control', 'must-revalidate, post-check=0, pre-check=0')
            ->setDefault('Content-Disposition', "$disposition; filename=\"$attachmentName\"");

        if ($mimeType !== null) {
            $headers->setDefault('Content-Type', $mimeType);
        }

        if ($contentLength !== null) {
            $headers->setDefault('Content-Length', $contentLength);
        }

        return $this;
    }





/**
 * @var boolean whether to use cookie to persist CSRF token. If false, CSRF token will be stored
 * in session under the name of [[csrfParam]]. Note that while storing CSRF tokens in session increases
 * security, it requires starting a session for every page, which will degrade your site performance.
 */
public $enableCsrfCookie = true;




/**
 * Loads the CSRF token from cookie or session.
 * @return string the CSRF token loaded from cookie or session. Null is returned if the cookie or session
 * does not have CSRF token.
 */
protected function loadCsrfToken()
{
	if ($this->enableCsrfCookie) {
		return $this->getCookies()->getValue($this->csrfParam);
	} else {
		return Yii::$app->getSession()->get($this->csrfParam);
	}
}



/**
 * Retrieves the value of an array element or object property with the given key or property name.
 * If the key does not exist in the array or object, the default value will be returned instead.
 *
 * The key may be specified in a dot format to retrieve the value of a sub-array or the property
 * of an embedded object. In particular, if the key is `x.y.z`, then the returned value would
 * be `$array['x']['y']['z']` or `$array->x->y->z` (if `$array` is an object). If `$array['x']`
 * or `$array->x` is neither an array nor an object, the default value will be returned.
 * Note that if the array already has an element `x.y.z`, then its value will be returned
 * instead of going through the sub-arrays. So it is better to be done specifying an array of key names
 * like `['x', 'y', 'z']`.
 *
 * Below are some usage examples,
 *
 * ```php
 * // working with array
 * $username = \yii\helpers\ArrayHelper::getValue($_POST, 'username');
 * // working with object
 * $username = \yii\helpers\ArrayHelper::getValue($user, 'username');
 * // working with anonymous function
 * $fullName = \yii\helpers\ArrayHelper::getValue($user, function ($user, $defaultValue) {
 *     return $user->firstName . ' ' . $user->lastName;
 * });
 * // using dot format to retrieve the property of embedded object
 * $street = \yii\helpers\ArrayHelper::getValue($users, 'address.street');
 * // using an array of keys to retrieve the value
 * $value = \yii\helpers\ArrayHelper::getValue($versions, ['1.0', 'date']);
 * ```
 *
 * @param array|object $array array or object to extract value from
 * @param string|\Closure|array $key key name of the array element, an array of keys or property name of the object,
 * or an anonymous function returning the value. The anonymous function signature should be:
 * `function($array, $defaultValue)`.
 * The possibility to pass an array of keys is available since version 2.0.4.
 * @param mixed $default the default value to be returned if the specified array key does not exist. Not used when
 * getting value from an object.
 * @return mixed the value of the element if found, default value otherwise
 * @throws InvalidParamException if $array is neither an array nor an object.
 */
public static function getValue($array, $key, $default = null)
{
	if ($key instanceof \Closure) {
		return $key($array, $default);
	}

	if (is_array($key)) {
		$lastKey = array_pop($key);
		foreach ($key as $keyPart) {
			$array = static::getValue($array, $keyPart);
		}
		$key = $lastKey;
	}

	if (is_array($array) && array_key_exists($key, $array)) {
		return $array[$key];
	}

	if (($pos = strrpos($key, '.')) !== false) {
		$array = static::getValue($array, substr($key, 0, $pos), $default);
		$key = substr($key, $pos + 1);
	}

	if (is_object($array)) {
		// this is expected to fail if the property does not exist, or __get() is not implemented
		// it is not reliably possible to check whether a property is accessable beforehand
		return $array->$key;
		//@todo nxn 如果数组非空,并且不包含给定的键,那就让它抛异常吧,这样在开发过程中刻意地一时间发现错误并解决
	} elseif (is_array($array)&& !empty($array)) {
		if(!array_key_exists($key,$array)){
			throw new \Exception($key.'is not in list;('.join(',',array_keys($array)));
		}
		return array_key_exists($key, $array) ? $array[$key] : $default;
	} else {
		return $default;
	}
}


    /**
     * Returns given word as CamelCased
     * Converts a word like "send_email" to "SendEmail". It
     * will remove non alphanumeric character from the word, so
     * "who's online" will be converted to "WhoSOnline"
     * @see variablize()
     * @param string $word the word to CamelCase
     * @return string
     */
    public static function camelize($word)
    {
        return str_replace(' ', '', ucwords(preg_replace('/[^A-Za-z0-9]+/', ' ', $word)));
    }

    /**
     * Converts a CamelCase name into space-separated words.
     * For example, 'PostTag' will be converted to 'Post Tag'.
     * @param string $name the string to be converted
     * @param boolean $ucwords whether to capitalize the first letter in each word
     * @return string the resulting words
     */
    public static function camel2words($name, $ucwords = true)
    {
        $label = trim(strtolower(str_replace([
            '-',
            '_',
            '.'
        ], ' ', preg_replace('/(?<![A-Z])[A-Z]/', ' \0', $name))));

        return $ucwords ? ucwords($label) : $label;
    }

    /**
     * Converts a CamelCase name into an ID in lowercase.
     * Words in the ID may be concatenated using the specified character (defaults to '-').
     * For example, 'PostTag' will be converted to 'post-tag'.
     * @param string $name the string to be converted
     * @param string $separator the character used to concatenate the words in the ID
     * @param boolean|string $strict whether to insert a separator between two consecutive uppercase chars, defaults to false
     * @return string the resulting ID
     */
    public static function camel2id($name, $separator = '-', $strict = false)
    {
        $regex = $strict ? '/[A-Z]/' : '/(?<![A-Z])[A-Z]/';
        if ($separator === '_') {
            return trim(strtolower(preg_replace($regex, '_\0', $name)), '_');
        } else {
            return trim(strtolower(str_replace('_', $separator, preg_replace($regex, $separator . '\0', $name))), $separator);
        }
    }

    /**
     * Converts an ID into a CamelCase name.
     * Words in the ID separated by `$separator` (defaults to '-') will be concatenated into a CamelCase name.
     * For example, 'post-tag' is converted to 'PostTag'.
     * @param string $id the ID to be converted
     * @param string $separator the character used to separate the words in the ID
     * @return string the resulting CamelCase name
     */
    public static function id2camel($id, $separator = '-')
    {
        return str_replace(' ', '', ucwords(implode(' ', explode($separator, $id))));
    }

    /**
     * Converts any "CamelCased" into an "underscored_word".
     * @param string $words the word(s) to underscore
     * @return string
     */
    public static function underscore($words)
    {
        return strtolower(preg_replace('/(?<=\\w)([A-Z])/', '_\\1', $words));
    }


	$user = PubUser::find()->select(['left(`username`,1)', 'id'])->limit(20)->asArray()->all();
	ArrayHelper::multisort($user, ['username', 'id'], [SORT_DESC, SORT_ASC], [SORT_NUMERIC, SORT_STRING]);

```
### yii2 框架部分代码
    public function validateAttribute($model, $attribute)
    {
        /* @var $targetClass ActiveRecordInterface */
        $targetClass = $this->targetClass === null ? get_class($model) : $this->targetClass;
        $targetAttribute = $this->targetAttribute === null ? $attribute : $this->targetAttribute;
        if (is_array($targetAttribute)) {
            $params = [];
            foreach ($targetAttribute as $k => $v) {
                $params[$v] = is_int($k) ? $model->$v : $model->$k;
            }
        } else {
            $params = [$targetAttribute => $model->$attribute];
        }

        foreach ($params as $value) {
            if (is_array($value)) {
                $this->addError($model, $attribute, Yii::t('yii', '{attribute} is invalid.'));
                return;
            }
        }

        $query = $targetClass::find();
        $query->andWhere($params);

        if ($this->filter instanceof \Closure) {
            call_user_func($this->filter, $query);
        } elseif ($this->filter !== null) {
            $query->andWhere($this->filter);
        }

        if (!$model instanceof ActiveRecordInterface || $model->getIsNewRecord() || $model->className() !== $targetClass::className()) {
            // if current $model isn't in the database yet then it's OK just to call exists()
            // also there's no need to run check based on primary keys, when $targetClass is not the same as $model's class
            $exists = $query->exists();
        } else {
            // if current $model is in the database already we can't use exists()
            /* @var $models ActiveRecordInterface[] */
            $models = $query->limit(2)->all();
            $n = count($models);
            if ($n === 1) {
                $keys = array_keys($params);
                $pks = $targetClass::primaryKey();
                sort($keys);
                sort($pks);
                if ($keys === $pks) {
                    // primary key is modified and not unique
                    $exists = $model->getOldPrimaryKey() != $model->getPrimaryKey();
                } else {
                    // non-primary key, need to exclude the current record based on PK
                    $exists = $models[0]->getPrimaryKey() != $model->getOldPrimaryKey();
                }
            } else {
                $exists = $n > 1;
            }
        }

        if ($exists) {
            $this->addError($model, $attribute, $this->message);
        }
    }

```

in_array($search['status'], ['unconfirmed' => '0', 'confirmed' => '1'], true)


-- 测试打印功能,理清打印功能的逻辑

# a4a9e5ac6b57a44bbb6406412d37ccda


#  修改了罗泰的权限为超管
SELECT *
FROM ffz_sys_user_role
WHERE userid = 406;

SELECT *
FROM ffz_pub_user
WHERE username LIKE "%南小宁%";


SELECT
  `li`.`goodsid`,
  `li`.`goodsnum`,
  `lih`.`id`,
  `li`.`goodsname`,
  `p`.`packsize`,
  `g`.`packtype`,
  `li`.`pgcdtion`,
  `p`.`info`                                        AS `goodsinfo`,
  round(CASE g.packtype
        WHEN "标准包装"
          THEN sum(li.seppacknum * li.buynum * p.packsize)
        WHEN "外包装"
          THEN sum(li.seppacknum * li.buynum * p.packsize)
        ELSE sum(li.seppacknum * li.buynum) END, 2) AS count,
  `li`.`seppacksize`,
  `li`.`prepareplace`,
  CASE WHEN s.`stockqty` IS NULL
    THEN 0
  WHEN g.packtype = "标准包装"
    THEN round(sum(p.`packsize` * s.stockqty), 2)
  WHEN g.packtype = "临时"
    THEN 0
  ELSE round(sum(s.`stockqty`), 2) END              AS stockqty
FROM `ffz_bsns_logistics_info` `li` INNER JOIN `ffz_bsns_logistics` `lih` ON lih.id = li.logisticsid
  INNER JOIN `ffz_pub_goods` `g` ON g.id = li.goodsid
  INNER JOIN `ffz_pub_packtype` `p` ON li.goodsid = p.goodsid AND p.flag = 1
  LEFT JOIN `ffz_pub_stock` `s` ON s.packtypeid = p.id AND s.accountid = 1
WHERE `lih`.`id` = 13384
GROUP BY `li`.`goodsid`
ORDER BY `li`.`depotid`, `g`.`catepid`, `g`.`catessort`, `g`.`sort`, `li`.`prepareplace`;

-- 查看餐厅和部门名称不一致的餐厅和部门关系
SELECT
  ct.id,
  ct.pid,
  ct.customname,
  bm.id,
  bm.customname
FROM ffz_pub_custom ct
  INNER JOIN ffz_pub_custom bm ON ct.id = bm.pid
WHERE ct.customname != bm.customname;
# 2,0,天贵食府,204,公司
# 2,0,天贵食府,206,家常
# 2,0,天贵食府,207,职工餐
# 2,0,天贵食府,208,川菜
# 2,0,天贵食府,209,上杂/面点
# 2,0,天贵食府,210,凉菜
# 2,0,天贵食府,211,火锅


-- 查找包装明细,类型为计数商品,
SHOW FULL COLUMNS FROM ffz_bsns_logistics_info;


SELECT *
FROM ffz_pub_goods
WHERE goodsno = 28001;
SELECT *
FROM ffz_pub_goods
WHERE metering = 0;
# id,catesort,goodsno
# 2666,60,64215,14,,GGJLZY240,干锅酱（辣之源/240g）,5,64,标准包装,0,0,580,调料类,T调料-汁酱
# 2665,10,43038,77,,JY5LSH,鲫鱼（5两/杀好）,3,43,外包装,0,1,970,河鲜类,F河鲜类-称重
# 2664,40,62027,14,,JJFLWX1,鸡精粉（六位仙/1kg）,5,62,标准包装,0,0,410,岳调料24号,T调料-汁酱
# 2662,70,49011,91,,FXWAJ,仿虾丸（安井）,3,49,标准包装,0,1,110,西南郊,E冻库（水饺，丸子）
# 2659,140,41037,12,,HGWCRGTML,火锅午餐肉罐头（梅林）,2,41,标准包装,0,1,260,调料类,Q熟食火腿
# 2658,130,71371,16,,JBBCHL,酱八宝菜（汇连）,5,71,标准包装,0,1,850,新发地C区,U调料-腌菜罐头

-- 查包装表
SELECT goodsnum
FROM ffz_pub_packtype
WHERE goodsid = 2666;


SELECT *
FROM ffz_pub_order
WHERE id IN (1, 2, 3)
LIMIT 3;

UPDATE ffz_pub_order
SET ordertime = UNIX_TIMESTAMP(now()) AND addtime = UNIX_TIMESTAMP(now())
WHERE id IN (1, 2, 3);
-- 计数,


-- 查找部门
SELECT *
FROM ffz_pub_custom
WHERE pid = 1;
-- 193, 237,248,249
#  要求餐厅和部门名称都不相同的选一个 247 (部门id 247)


#  在 orderinfo 表里边查找 客户 id 为 247 的


SHOW FULL COLUMNS FROM ffz_pub_orderinfo;

SHOW CREATE TABLE ffz_pub_orderinfo;


SELECT *
FROM ffz_pub_orderinfo
WHERE uid = 247;

SELECT *
FROM ffz_pub_orderinfo
LIMIT 5;

UPDATE ffz_pub_orderinfo
-- status 1 确认 seppackh 2 已拉取看
SET seppackh = 2 AND status = 1 AND ffz_pub_orderinfo.seppack = 1
WHERE id IN (1, 2, 3, 6, 7);


ALTER TABLE ffz_pub_purchase_place
  ADD COLUMN type TINYINT NOT NULL DEFAULT 1
COMMENT '1 不许要入库扫描确认, 2 需要扫马入库确认';

ALTER TABLE ffz_bsns_logistics_detail
  ADD COLUMN receivetime INT(11) COMMENT '扫码入库时间',
  ADD COLUMN receiveuser INT COMMENT '扫码入库人',
  ADD COLUMN receivestatus TINYINT NOT NULL DEFAULT 2
COMMENT '{1: 未收货, 2: 已收货}';


ALTER TABLE ffz_bsns_logistics_detail
  CHANGE COLUMN receivetime receivetime INT(11) NOT NULL DEFAULT 0
COMMENT '扫码入库时间',
  CHANGE COLUMN receiveuser receiveuser INT NOT NULL DEFAULT 0
COMMENT '扫码入库人',
  CHANGE COLUMN receivestatus receivestatus TINYINT NOT NULL DEFAULT 1
COMMENT '{1: 未收货, 2: 已收货}';


SELECT count(li.id)
FROM ffzerp2.ffz_bsns_logistics_info li
  INNER JOIN ffz_pub_goods g ON g.id = li.goodsid
  INNER JOIN ffz_pub_purchase_place pur ON pur.id = g.buyplaceid AND pur.type = 2
WHERE li.addtime >= :addtime AND li.deliverstatus = 1
ORDER BY li.addtime DESC
LIMIT 20;


SELECT count(d.id)
FROM ffz_bsns_logistics_detail d
  INNER JOIN ffz_pub_goods g ON g.id = d.goodsid
  INNER JOIN ffz_pub_purchase_place pur ON pur.id = g.buyplaceid AND pur.type = 2
  INNER JOIN ffz_pub_packtype p ON d.packtypeid = p.id AND d.receivestatus = 1
WHERE d.addtime >= :addtime
ORDER BY d.addtime ASC;


SELECT count(d.id)
FROM ffz_bsns_logistics_detail d
  INNER JOIN ffz_pub_goods g ON g.id = d.goodsid
  INNER JOIN ffz_pub_purchase_place pur ON pur.id = g.buyplaceid AND pur.type = 2
  INNER JOIN ffz_pub_packtype p ON d.packtypeid = p.id AND d.receivestatus = 2
WHERE d.addtime >= :addtime
ORDER BY d.addtime ASC;

SELECT
  g.buyplace,
  d.goodsnum,
  d.goodsname,
  d.goodsinfo,
  d.weighqty,
  p.name AS                unit,
  from_unixtime(d.addtime) addtime,
  d.deliverstatus,
  d.receivestatus,
  u.username
FROM ffz_bsns_logistics_detail d
  INNER JOIN ffz_pub_goods g ON g.id = d.goodsid
  INNER JOIN ffz_pub_purchase_place pur ON pur.id = g.buyplaceid AND pur.type = 2
  INNER JOIN ffz_pub_packtype p ON d.packtypeid = p.id AND d.receivestatus = 2
  INNER JOIN ffz_pub_user u ON u.id = d.packuid
WHERE d.addtime >= :addtime
ORDER BY d.addtime ASC
LIMIT 20;

UPDATE ffz_pub_purchase_place
SET type = 2
WHERE id % 2 = 0;
SELECT *
FROM ffz_pub_purchase_place
WHERE type = 2;

SELECT
  a.id,
  a.buyplaceid,
  pur.type
FROM (SELECT
        d.id,
        d.goodsid,
        g.buyplaceid,
        g.buyplace
      FROM ffz_bsns_logistics_detail d
        INNER JOIN ffz_pub_goods g ON g.id = d.goodsid
        #       冗余字段
        INNER JOIN ffz_pub_purchase_place pur ON pur.id = g.buyplaceid
      ORDER BY id DESC
      LIMIT 20) AS a
  INNER JOIN ffz_pub_purchase_place AS pur ON pur.id = a.buyplaceid
WHERE pur.type = 1;


SELECT *
FROM ffz_pub_purchase_place
WHERE id = 61;

# S岳湘源腊肉

UPDATE ffz_bsns_logistics_detail
SET addtime = floor(rand() * (1499413623 - 1499421600 + 1) + 1499413623)
WHERE id IN
      (3632290, 3632289, 3632288, 3632287, 3632286, 3632285, 3632284, 3632283, 3632282, 3632281, 3632280, 3632279, 3632278, 3632277, 3632276, 3632275, 3632274, 3632273, 3632272, 3632271);

SELECT *
FROM ffz_bsns_logistics_detail
WHERE id IN (
  3632290, 3632289, 3632288, 3632287, 3632286, 3632285, 3632284, 3632283, 3632282, 3632281, 3632280, 3632279, 3632278, 3632277, 3632276, 3632275, 3632274, 3632273, 3632272, 3632271
);

UPDATE ffz_bsns_logistics_detail
SET receiveuser = 406,
  receivetime   = floor(rand() * (1499413623 - 1499421600 + 1) + 1499413623)
WHERE receivestatus = 2 AND id IN
                            (3632290, 3632289, 3632288, 3632287, 3632286, 3632285, 3632284, 3632283, 3632282, 3632281, 3632280, 3632279, 3632278, 3632277, 3632276, 3632275, 3632274, 3632273, 3632272, 3632271);


SELECT unix_timestamp('2017-07-07 18:00:00');

SHOW PROCESSLIST;

EXPLAIN SELECT COUNT(*)
        FROM `ffz_bsns_logistics_info` `li` INNER JOIN `ffz_pub_goods` `g` ON g.id = li.goodsid
          INNER JOIN `ffz_pub_purchase_place` `pur` ON pur.id = g.buyplaceid AND pur.type = 2
        WHERE (`li`.`addtime` >= FALSE) AND (`li`.`deliverstatus` = 1);


SELECT
  `d`.`id`,
  `d`.`goodsnum`,
  `d`.`goodsname`,
  `d`.`goodsinfo`,
  `g`.`buyplace`,
  `d`.`weighqty`,
  `p`.`name`                   AS `unit`,
  `d`.`deliverstatus`,
  `u`.`username`,
  from_unixtime(d.addtime)     AS addtime,
  `ur`.`username`              AS `receiveuser`,
  from_unixtime(d.receivetime) AS receivetime
FROM `ffz_bsns_logistics_detail` `d` INNER JOIN `ffz_pub_goods` `g` ON g.id = d.goodsid
  INNER JOIN `ffz_pub_purchase_place` `pur` ON pur.id = g.buyplaceid AND pur.type = 2
  INNER JOIN `ffz_pub_packtype` `p` ON p.id = d.packtypeid
  LEFT JOIN `ffz_pub_user` `u` ON u.id = d.packuid
  LEFT JOIN `ffz_pub_user` `ur` ON ur.id = d.receiveuser
WHERE ((`d`.`addtime` >= 1499594400) AND (`d`.`addtime` < FALSE)) AND (`d`.`receivestatus` = '2')
ORDER BY `d`.`addtime`
LIMIT 20;



laravel 教程:


laravel 中间件解析的方式
入参举例:

```
Route::get('new', 'Index@index')->middleware('access:基础功能查看与操作'); // 首页
```


## laravel
laravel 项目里边的中间件机制
DingoApi

```
/**
 * Parse a middleware string to get the name and parameters.
 *
 * @author Taylor Otwell
 *
 * @param string $middleware
 *
 * @return array
 */
protected function parseMiddleware($middleware)
{
	list($name, $parameters) = array_pad(explode(':', $middleware, 2), 2, []);

	if (is_string($parameters)) {
		$parameters = explode(',', $parameters);
	}

	return [$name, $parameters];
}
```



```
use Carbon\Carbon;
$now = Carbon::now()->toDateTimeString();
 //Check customer money monthly quota.
        $start_time = Carbon::now()->startOfMonth()->toDateTimeString();
        $now = Carbon::now()->toDateTimeString();


// laravel 事务的使用方法
$approvingModel = new $this->approvingModel;
            $approvingModel->fill($params);

            try {
                DB::beginTransaction();

                $welfareEvent->save();

                $approvingModel->customer_welfare_event_id = $welfareEvent->id;
                $approvingModel->save();

                DB::commit();
            } catch (\Exception $error) {
                DB::rollback();
                Log::error('Save welfare event error, message: ' . $error->getMessage() .
                    ', file: ' . $error->getFile() . ', line: ' . $error->getLine());
                throw $error;
            }



        if ($approvings) {
            try {
                DB::beginTransaction();

                foreach ($welfareEvents as $welfareEvent) {
                    $welfareEvent->save();
                }

                foreach ($approvings as $approving) {
                    $approving->delete();
                }

                DB::commit();
            } catch (\Exception $error) {
                DB::rollback();
                Log::error('Approve welfare event error, message: ' . $error->getMessage() .
                    ', file: ' . $error->getFile() . ', line: ' . $error->getLine() .
                    ', ids: ' . implode(',', $ids));
                throw $error;
            }
        } else {
            foreach ($welfareEvents as $welfareEvent) {
                $welfareEvent->save();
            }
        }
```


laravel 验证规则扩展
Validator::extend() 

laravel 里边, Facade 和 provider 对对应关系.

以 /var/www/deploy/beeper_customer_web/current/项目为例,在 app/Repositories/Task/TaskRepository.php 文件中,JoinLibrary的使用方法,用user JoinLibrary这个短名称,则laravel 会找对应的外观类,查找方式以来配置.查看app/config/app.php,提供了JoinLibrary和其对应的外观类App\Facades\JoinLibraryFacade,从该类的 getFacadeAccessor 方法中, 找到Facade和provider di Container 中里边的关联字符串joinlibrary,
用 grep  app/Providers 'joinlibrary' -nri --include='*.php'查找相关文件,找到
APP\Provider\JoinLibraryServiceProvider这个类的register方法里边有这个单词,而且设置的是单利模式.则沿着该类继续往下找.

发现实际上对应着App\Libs\JoinLibrary这个类,这样做的好处是该类本身只需要实例化一次,不需要重复实例化.

session()->get('errors ')


public function getBag($name)
{
    return Arr::get($this->bags, $name, function () {
        throw new InvalidArgumentException('Bag not registered.');
    });
}























