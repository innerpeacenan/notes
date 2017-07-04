
* 阿里大鱼短信使用经验：
短信验证码，比较看重命中率、到达速度以及价格。

```
include "TopSdk.php";
    $appkey = 23348748;
    $secret = d3d41207f47332e290ad5ec0693df41f;
    $targetPhone = "13381183205";
```   

调用短信发送模块
```    
    $c = new TopClient;
    $c->appkey = $appkey;
    $c->secretKey = $secret;
    $req = new AlibabaAliqinFcSmsNumSendRequest;
    $req->setExtend("[用户ID]123456");
    $req->setSmsType("normal");
    $req->setSmsFreeSignName("京宁征信");
    $req->setSmsParam("{\"code\":\"1234\",\"product\":\"还我钱\"}");
    $req->setRecNum($targetphone);
    $req->setSmsTemplateCode("SMS_585014");
    $resp = $c->execute($req); 
```	