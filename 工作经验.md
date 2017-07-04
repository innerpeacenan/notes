*服务器域名配置发生过的问题:
> 今天上午在windwows下配好域名，在李军的帮助下，发现自己写的域名多加了"/",改正后配置完成；接着在linux下配置域名
> 在唐驰的帮助下，完成基本配置，中间发现为对根目录的父级目录授权，因此导致服务器无法读取.htaccess文件，改正后，配置完成linux环境。

1. 后台数据库返回数据格式与原框架不一致，因此导致js运行错误。以修复。
2. yii对未定义请求参数直接报错，而前端参数又是动态生成的，
3. 关联商品:为增强可维护心性，在页面增加了ajax大量documen结构注释。
4. 了解了yii model的数据类型与数据库中的数据类型的对应关系，弄明白了active record 类PubCustom类的save方法存储失败的原因(字段数量,字段长度和数据类型以及验证规则都要通过,才能正确存入数据库)。yii Active Model 调用findOne() 得方法是,可能返回null,因此调用ActiveModel::save()方法时,一定全表AR对象不等于NUll;
5. 今天测试货位调整功能，发现一处奇怪的现象，同一个请求，get请求可以被处理，而post请求不能被处理。后在李军的帮助下，在当前控制器设置了public $enableCsrfValidation=false;后，可以正常访问。1.通过yii官方文档和StackOverflow的相关资料继续，了解了csrf攻击的大概原理，以及在yii2中采取的防御措施。和李大哥查找问题根源，经过查找，发现，在authController中重载了框架的beforeAction方法，导致框架的安全验证方法都失效了。而我的发生这个问题是直接继承了web controller方法。经过讨论，决定先不加这一块动心。解决了之前货位编辑页面存在的400 bad request问题。
6. form 的method属性为get时,会用表单域覆盖原来action 属性中的query string部分.form表单的method属性为post时候,query string会写入请求body中,因此,不会覆盖原action部分的url地址中的query string,因此,php的$_GET变量仍然会获得query string.
7. apache vhost 配置(linux要对网站的根目录的父目录也要授权,chown -R www:www renovation/)

8. mysql inner join 注意事项
注意与关联的比存在一对多的情况,如包装表对采购价格表(采购价格表中,每个packtype每天都会存一条记录)
```
public static function genarateOneDayProfit($starttime, $uid){
	$step1_query = <<<STEP1
	SELECT
di.id AS dilivary_id,
di.packtypeid,
g.id  AS goodsid,
pur.`price` AS purchase_price,
di.price sale_price,
p.packsize,
g.packtype
FROM `ffz_bsns_delivary_info` AS di INNER JOIN `ffz_pub_packtype` AS p ON p.id = di.packtypeid
-- 过滤退货
INNER JOIN ffz_pub_goods AS g ON g.id = p.goodsid
INNER JOIN `ffz_bsns_delivary` AS d ON di.`delivarygid` = d.id AND di.delivernum > 0
INNER JOIN `ffz_pub_purchase_price` AS pur
-- 采购表里边每天的数据都有,因此一定要按照日期去过滤纸
ON pur.`goodsid` = p.`goodsid` AND pur.busidate = unix_timestamp('2017-01-01')
WHERE d.`addtime` > unix_timestamp('2017-01-01') AND d.addtime < unix_timestamp('2017-01-02');
STEP1;
}
```
9. yii表关联方式写错,自己加了检查


```
    /**
     * check.
     * @access
     * @return void
     * Description:
     * 在yii\db\Query 里边
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

10. 共用query对象可以节省内存空间,但要注意销毁不用的属性,以免造成问题
```
        $query->limit = null;
        $departments = $query->select('id','name')->from('ffz_sys_department')->where(['pid'=>$pid])->all();
```

11. 数组foreach 后,要将结果返回到$groups 或直接操作$groups[$index]
```
        // 计算每组的业绩和退货金额
        foreach ($groups as $index => $group) {
            $group['group_total_sale'] = 0;
            $group['group_total_return_price'] = 0;
            foreach ($group['custom_list'] as $custom_id) {
                if (isset($month_delivery_price[$custom_id])) {
                    $groups[$index]['group_total_sale'] += $month_delivery_price[$custom_id];
                }
                if (isset($month_return_price[$custom_id])) {
                    $groups[$index]['group_total_return_price'] += $month_return_price[$custom_id];
                }
            }
        }
```


12. array_search 的结果为false才表示找不到

13. explode
特别注意: 先去除字符串边界的分隔符号(空白,逗号等),如果为空字符串,则不拆封,否则再拆分
```
/**
 * array If delimiter is an empty string (""),explode will return false.
 * If delimiter contains a value that is not contained in string and a negative limit is used, then an empty array will be
 * returned. For any other limit, an array containing string will be returned.
 */
if(empty($commission->admingroups)) return $this;
$groups_names = explode(',', $commission->admingroups);
```
$groups_names = explode(',', trim($commission->admingroups,", \t\n\r\0\x0B"));
### usefull websits
[lamp环境搭建]( http://www.imooc.com/learn/170)

[php常用设计模式的学习]( http://www.imooc.com/learn/236/)

[从0开始打造自己的框架]( http://www.imooc.com/learn/696)

[mvc架构的学习]( http://www.imooc.com/learn/69)

[git控制]( http://www.imooc.com/learn/208)

[php设计模式的博客]( http://www.fluffycat.com/PHP-Design-Patterns/)

[中文的php设计模式博客（很好）]( http://www.phppan.com/php-design-pattern/)


14. 解决了个人头像后难以选取下拉列表的问题。原因为bootstrap当前版本中，下拉列表和选项见设计了2个像素的间隙

选中选项设计方案：
由于页面每次勾选都会跳转到新页面，导致之前的变量无法使用，因此，采取域名解析映射的方式实现元素跟踪


15. 注意mysql关键字，如order

