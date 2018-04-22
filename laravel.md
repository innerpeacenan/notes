设置customer log

$this->log = app('ynlog')->custom('service');

### Carbon

```
Carbon::setTestNow('2017-12-25 15:48:28');
// 保存默认时间
Carbon::now()->toDateTimeString()
[
'work_time_start' => Carbon::now()->startofDay()->format('Y-m-d H:i:s'),
'work_time_lte' => Carbon::now()->endOfDay()->format('Y-m-d H:i:s'),
]
```

```
参数校验参考:
$this->validate($request, [
            'task_id'        => 'required',
            'customer_price' => 'required|numeric',
                        
        ], [            
            'task_id.required'        => '任务编号必传',
            'customer_price.required' => '客户价格必传',                                                                                
        ]);



Model
protected $findable = [                                                                                                             
        'id',   
        'process_id',
        'task_id',
        'driver_price',
        'customer_price',
    ];       


\Symfony\Component\VarDumper\VarDumper::dump($this->customProviderCreators[$config['driver']]);die();


crontab -e
* * * * * php /var/www/deploy/beeper_customer_api/current/artisan schedule:run



