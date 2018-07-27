背景:
将项目下面的所有文件的权限改为了 777, 结果准备将其合并到 master 的时候, 本地 merge 以后, 发现提示大量诸如:

```
mode change 100644 => 100755 .gitignore
```

的问题, 而push 之后, 想 master pull request之后, 查看 diff 的时候, 发现所有文件都在 diff 里边,明白了这一变动,问题还是比较麻烦的.

解决方案:

从远程 master 分支再拉一个分支, 如 nanxiaoning/dev, 然后 git clone 项目到本地, 名称为: 将项目名称为 beeper_develper_platform, 原来的项目目录名称为 current,执行

```
meld current/ beeper_develper_platform/
```
将之前的修改手动合并到 beeper_develper_platform 中, 然后在 beeper_develper_platform 中走正常的提交流程.


经验教训: 

不要改在本库库中的文件的权限.
