* 我个人的理解，待进一步验证
```
location /{
        # 如果所请求的文件不存在
        if (!-e $request_filename) {
		    #对于renovation web目录下的所有文件，请求转发到renovation/web目录下的index文件，并附加之前捕获的参数
            rewrite ^/renovation/web/(.*)$ /renovation/web/index.php?$1 last; 
			#将0个或多个任以非换行符的请求转发到根目录下名为index.php的文件下
            rewrite  ^(.*)$  /index.php?s=$1  last;
            #其他情况，直接终止查找			
            break;
        }
}
```

