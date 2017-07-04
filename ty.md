### ty (工作常用)
### tp控制器替换
请求参数替换:
```

I\((?<quote>['"])param\.(?<param>\w+)\k<quote>\)
\$param['$2']

I\(([^()]+)\)
\$search[$1]

\$this->ajaxReturn
Ajax::ajaxReturn

Yii::$app->db->createCommand()->batchInsert(PubShiftInfo::tableName(), array_keys($dataToInsert[0]), $dataToInsert)->execute();
->getField\('(\w+)'\)
->select('$1')->scalar()

->field\('(.+)'\)->

->select(['$1'])->
```

### tp视图数组变量替换:
<?php
use yii\helpers\Html;
use yii\helpers\Url;
use app\classes\Utility;
?>
<?= \app\classes\Utility::navstring() ?>

index number 序号
```
<td style="text-align:center;"><?=$pages->offset + $key+1?></td>
```
请求方法替换
```
method="post"
method="get"
```

```
\{\$(\w+)\.(\w+)\}
//替换为
<?=\$$1['$2'];?>
```

```
\{(\$[^}]+)\}
//替换为
<?=$1?>
```


* search.php
```
// 保持标签和输入框在统一行
<div class="search-main" style="width:100%;margin:0 auto;text-align: left">
<div class="text-l">
    <?= Html::beginForm(Url::to(['custom-order/search']), 'get', ['class' => 'search-main']) ?>
    <?= $this->render('@app/views/layouts/search.php', ['search' => $search]); ?>
    <?= Html::submitButton('<i class="icon-search"></i>搜索', ['class' => 'btn btn-success']) ?>
    <?= Html::endForm() ?>
</div>
```

* 分页
<?= $this->render('@app/views/layouts/pages.php', ['pages' => $pages]); ?>



搜索:
```
\{:U\(([^}]+)\)\} (注意待参数的形式替换)
//替换为:
<?=Url::to([$1])?>
#顺带修改地址形式
```

搜索:
```
<volist\s+name=(["'])([^"']+)\1\s+id=(["'])([^"']+)\3\s*>
//替换为:
<?php foreach (\$$2 as \$key =>\$$4){?>
或
<?php foreach (\$$2 as \$$4){?>
```

```
</volist>
//替换为:
<?php } ?>
```
```
\<if\s*condition=(["'])([^>]*)\1\>
<?php if($2):?>

</if>

<?php endif;?>
```

```
\bneq\b
==

\bneq\b
!=
```

```
替换分页:
<?= $this->render('@app/views/layouts/pages.php', ['pages' => $pages]); ?>
```


<?php $this->beginBlock('tableSort') ?>
//<script type="text/javascript">
    $('.table-sort').dataTable({
        fixedHeader: true,
        "lengthMenu": false,//显示数量选择
        "bFilter": false,//过滤功能
        "bPaginate": false,//翻页信息
        "bInfo": false,//数量信息
        "aaSorting": [[0, "asc"]],//默认第几个排序
        "bStateSave": false,//状态保存
        "bAutoWidth": false,
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {"orderable": false, "aTargets": []}// 制定列不参与排序
        ]
    });
    /*点击市场小组进行提交*/
    function sub(obj) {
        var pre = $(obj).prev('input');
        $('input[ate=depart]').prop('checked', false);
        $(pre).prop('checked', true);
        $('#form').submit();
    }
//</script>
<?php $this->endBlock() ?>
<?php $this->registerJs($this->blocks['tableSort'], \yii\web\View::POS_END); ?>
<?php \app\assets\AppAsset::addScript($this, '@web/js/LodopFuncs.js'); ?>





<?php if(\app\classes\Utility::checkButtonAccess('goodspurinfo')): ?>
ondblClick="todayPurchaseInfo('','','查看 <?=$list['goodsname'];?> 的采购记录','<?=Url::to(['profit-summary/goodspurinfo','busidate'=>$list['busidate'],'id'=>$list['id'],'packtypeid'=>$list['packtypeid'],'goodsname'=>$list['goodsname']])?>')"
<?php endif; ?>