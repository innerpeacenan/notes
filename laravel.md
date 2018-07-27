
#### log

```
设置customer log
// @todo 查看云鸟是否包装过
app('ynlog')->custom('service');
Log::notice('request complete!', ['cost' => $cost]);
```

### Carbon

```
Carbon::setTestNow('2017-12-25 15:48:28');
// 保存默认时间
Carbon::now()->toDateTimeString()
[
'work_time_start' => Carbon::now()->startofDay()->format('Y-m-d H:i:s'),
'work_time_lte' => Carbon::now()->endOfDay()->format('Y-m-d H:i:s'),
]

Carbon::now()->format('YmdHis')

```


### validate



        
        
```
'feedbackTime' => 'required|date_format:Y-m-d H:i:s',

### validate

vendor/laravel/framework/src/Illuminate


$validator = Validator::make($request->all(), [
    "name"    => "required|array|min:3",
    "name.*"  => "required|string|distinct|min:3",
]);

$this->validate($request, [
            'task_id'        => 'required',
            'customer_price' => 'required|numeric',
                        
        ], [            
            'task_id.required'        => '任务编号必传',
            'customer_price.required' => '客户价格必传',                                                                                
        ]);
);
$request->validate([
    'title' => 'required|unique:posts|max:255',
    'author.name' => 'required',
    'author.description' => 'required',
]);



use Validator;

// 校验json字符串
public function store(Request $request)
{
    //$data = $request->all();
    $data = json_decode($request->payload, true);
    $rules = [
        'name' => 'digits:8', //Must be a number and length of value is 8
        'age' => 'digits:8'
    ];

    $validator = Validator::make($data, $rules);
    if ($validator->passes()) {
        //TODO Handle your data
    } else {
        //TODO Handle your error
        dd($validator->errors()->all());
    }
}
```

### laravel 源码 validate代码模式


```
$method = "validate{$rule}";



php 传参可以多余预定义的参数的个数


$method = "validate{$rule}";

$this->$method($attribute, $value, $parameters, $this)

public function url()
{
   return rtrim(preg_replace('/\?.*/', '', $this->getUri()), '/');
}




Route::get('/test', function (Illuminate\Http\Request $request) {

    $validator =  \Validator::make(
        ['title' => ['333', '666'], 'body' => '石大校友周永康题词'],
        [
            'title.*' => [$this, 'each'],
            'body' => 'required',
        ]
    );

//    $validator = new \Illuminate\Validation\Validator(
//        app('Symfony\Component\Translation\TranslatorInterface'),
//        ['title' => ['333333', '66666666'], 'body' => '石大校友周永康题词'],
//        [
//
//            'title' => 'required|max:1',
//            'title.*' => 'max:4',
//            'body' => 'required|body_contain_sensitive_message',
//        ]
//    );
//

//    $sensiveWords = '周永康';
//    $validator->addExtension('body_contain_sensitive_message', function ($attribute, $value) use ($sensiveWords) {
//        if (strpos($value, $sensiveWords) !== false) {
//            return false;
//        }
//        return true;
//    });

//    $validator->addReplacer('body_contain_sensitive_message', function ($mesages, $attribute, $rule, $params) use ($sensiveWords) {
//        return $attribute . '不能包含敏感词汇:' . $sensiveWords;
//    });

    // 回调函数最多可定义四个参数
//    $validator->addReplacer('max', function ($mesages, $attribute, $rule, $params) {
//
//        if ($attribute === 'title') {
////            return strtr($mesages, [$attribute => '文章内容', ":{$rule}" => reset($params) . '个']);
//            return $rule;
//        } else {
//            return $rule;
//        }
//
//    });
    $isValid = $validator->passes();
    var_export($validator->messages()->all());

    /*
array (
     0 => 'The 文章内容 may not be greater than 10 characters.',
     1 => 'The body field is required.',
)
     */
});
```

### Model

```
protected $findable = [                                                                                                             
        'id',   
        'process_id',
        'task_id',
        'driver_price',
        'customer_price',
    ];       
```


### debug

```
\Symfony\Component\VarDumper\VarDumper::dump($this->customProviderCreators[$config['driver']]);die();
```


### 定时任务

```
crontab -e
* * * * * php /var/www/deploy/beeper_customer_api/current/artisan schedule:run
```

### cookie

```
\Cookie::queue(\Cookie::forget('big_screen_access_token'));

return response($body, 301)->send();
```



