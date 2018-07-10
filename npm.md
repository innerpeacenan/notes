
### 安装webpackage 打包工具

```
npm install webpackage
```

### package.json

```
root@:/home/www/npmtest$cat package.json 
{
    "private":true,
    "name":"npm-test",
    "author": "fex",
    "description":"test",
    "scripts":{
        "test":"echo 'liming'"
    },
    "repository": {
    "type": "git",
    "url": "https://github.com/fis-scaffold/php-smarty.git"
  }
}

root@:/home/www/npmtest$npm install 
root@:/home/www/npmtest$ls
node_modules  package.json

# script 中的每一项都都可以通过 npm run 去执行,如对 test 这项, 运行了 npm run test, 则输出执行结果:
root@:/home/www/npmtest$npm run test

> npm-test@ test /home/www/npmtest
> echo 'liming'

liming
root@:/home/www/npmtest$
```

**注意:** package.json 中, "private":true,则表示这是私有仓库,则不需要licence 字段, 否则需要 licence字段(许可说明)



### 鸟眼现在用的前段编译命令

```
npm install 
npm run build:debug
```


npm 学习

liming


依赖:
格式错误

```
npm run-script
package.json
```

### 将 npm 的源切换到淘宝源

```
npm install -g cnpm --registry=https://registry.npm.taobao.org

npm install --save cson

/home/www/node_modules/cson/bin/cson2json
```





