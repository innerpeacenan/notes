## 基本命令

### git config

```
cat .git/HEAD
[branch "hotfix/v1.18.1"]
	remote = origin
# 该分支对应的远程版本库的分支
	merge = refs/heads/hotfix/v1.18.1
```

git 配置用户名和邮箱

```
// git 忽略文件权限更改,本地可用
git config core.filemode false
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```
参考:
https://stackoverflow.com/questions/1580596/how-do-i-make-git-ignore-file-mode-chmod-changes

* 设置 git 默认的编辑器

打开项目的 .gitconfig 文件, 配置如下项目

```
[core]
    editor = /usr/bin/vim
```

* .gitignore

[.gitignore](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013758404317281e54b6f5375640abbb11e67be4cd49e0000)

* 让 git 忽略版本库里边的文件

```
git update-index --assume-unchanged [<file> ...]

To undo and start tracking again:

git update-index --no-assume-unchanged [<file> ...]
```

### 理解 git 的三个区的概念

http://www.nowamagic.net/academy/detail/48160210

###  git 分支管理

```
查看分支：git branch

option -a shows both local and remote branches
git branch -a

创建分支：git branch <name>

切换分支：git checkout <name>

创建+切换分支：git checkout -b <name>

合并某分支到当前分支：git merge <name>

删除分支：git branch -d <name>
强制删除未merge的分支: git branch -D origin/BEEPER_40746_nanxiaoning

# As of Git v1.7.0, you can delete a remote branch using
#git push <remote_name> --delete <branch_name>
git push origin --delete hotfix/v1.19.1

git branch --set-upstream-to=origin/nanxiaoning/BEEPER-45261  nanxiaoning/BEEPER-45261

鸟眼 m1 环境地址

http://niaoyan.m1.yntesting.cn
```

[删除远程分支的方法:](https://stackoverflow.com/questions/2003505/how-do-i-delete-a-git-branch-both-locally-and-remotely)


### git 删除改过的代码

[删除未 push 的代码](https://stackoverflow.com/questions/22620393/various-ways-to-remove-local-git-changes)


### git log

```
git log
git log --graph --pretty=oneline --abbrev-commit
git log --pretty=oneline --abbrev-commit
git log --pretty=oneline
```

HEAD指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令 `git reset --hard commit_id` 未来是相对于 head 指向的版本而言. 穿梭前，用git log可以查看提交历史，以便确定要回退到哪个版本。 要重返未来，用git reflog查看命令历史，以便确定要回到未来的哪个版本



### git stash

```
#保存现场
git stash
git stash list
#采用 git stash pop 来恢复
git stash pop

# 修改了master代码, 不想在master上直接提交, 而是想在 nanxiaoning/api 分支上提交, 此时的处理方法
git stash
git checkout -b  nanxiaoning/api
git stash pop
```

### git remote

当你从远程仓库克隆时，实际上Git自动把本地的master分支和远程的master分支对应起来了，并且，远程仓库的默认名称是origin。

```
git remote -v
git remote origin
```

git remote -v
origin  git@github.com:michaelliao/learngit.git (fetch)
origin  git@github.com:michaelliao/learngit.git (push)
上面显示了可以抓取和推送的origin的地址。如果没有推送权限，就看不到push的地址。

### git push

把本地库的内容推送到远程，用git push命令，实际上是把当前分支master推送到远程。

由于远程库是空的，我们第一次推送master分支时，加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令。

### git show
查看提交的细节:
可以使用 `git show --pretty=fuller`  命令来查看给定提交的其他细节。

```
显示 56ad47d2cc335d36137819644ca354725a204773 相比上次提交的变化
git show 56ad47d2cc335d36137819644ca354725a204773
git show <tagname>
```

### git tag

```
查看标签 `git tag`
git tag v1.0
git tag -m 'Tag version 1.0' v1.0 3ede426

给某一个具体的版本打标签:
git tag v0.9 6224937
还可以创建带有说明的标签，用-a指定标签名，-m指定说明文字：
git tag -a v0.1 -m "version 0.1 released" 3628164

根據 tag 查看對象的 SHA值 git rev-parse V1.0

如果要推送某个标签到远程 git push origin v1.0
一次性推送全部尚未推送到远程的本地标签： git push origin --tags

git 本地删除标签: git tag -d v0.1

如果标签已经推送到远程，要删除远程标签就麻烦一点，先从本地删除：
git tag -d v0.9
git push origin :refs/tags/v0.9
```

### git commit

git commit -a 的功能说明

> by using the -a switch with the commit command to automatically "add" changes from all known files (i.e. all files that are already listed in the index) and to automatically "rm" files in the index that have been removed from the working tree, and then perform the actual commit;

### git diff

git 对比两次提交的文件之间的差别

git diff newcommit:app/Http/Controllers/Task/Task.php  oldcommit:app/Http/Controllers/Task/Task.php

提交后，用 `git diff HEAD -- readme.txt` 命令可以查看工作区和版本库里面最新版本的区别：

`git checkout -- file` 命令中的 -- 很重要，没有 --，就变成了“切换到另一个分支”的命令，我们在后面的分支管理中会再次遇到 `git checkout` 命令。

git diff 比较的是工作区和暂存区的差别

git diff --cached 比较的是暂存区和版本库的差别

### git remote
查看远程分支:

```
git remote -v

```

### git ls-remote

```
git ls-remote -h ssh://git@dev.xunhuji.me:17999/beeper/beeper_develper_platform.git
```


### git rebase

```
这个可以跳过 rebase 中间过程的错误
git rebase --skip
git status 查看每一次 rebase 失败详情
解决完冲突执行:
git rebase --continue
```

## git 常见问题

(1) 如果此前为执行过 git clone 操作,则需要关联一次远程仓库,方法为:
要关联一个远程库，使用命令git remote add origin git@server-name:path/repo-name.git；

origin 为远程版本库的
git push --set-upstream origin  nanxiaoning/dev

[已经添加了 SSH key，但是 push 的时候，需要输入，用户名和密码](https://github.com/innerpeacenan/learning_git_from_liao/blob/master/%E4%BD%BF%E7%94%A8%E8%BF%87%E7%A8%8B%E4%B8%AD%E9%81%87%E5%88%B0%E7%9A%84%E9%97%AE%E9%A2%98/%E6%AF%8F%E6%AC%A1push%E9%83%BD%E9%9C%80%E8%A6%81%E8%BE%93%E5%85%A5%E7%94%A8%E6%88%B7%E5%90%8D%E5%92%8C%E5%AF%86%E7%A0%81.md)

(2) 服务器已经删除的 branch，本地依然保留着对这些 remotebranch 的引用，运行下面的命令来清除

git fetch --all --prune

(3) branch名起错了怎么办

使用branch -m命令改名

git br -m {old_branch_name} {new_branch_name}

(4) 远程版本回退:

如果你的错误提交已经推送到自己的远程分支了，那么就需要回滚远程分支了。
首先要回退本地分支：

```
git reflog
git reset --hard Obfafd
```

紧接着强制推送到远程分支：

```
注意：本地分支回滚后，版本将落后远程分支，必须使用强制推送覆盖远程分支，否则无法推送到远程分支
git push -f
```

(5) 强制远程代码覆盖本地代码:

[How do I force an overwrite of local files on a git pull](https://stackoverflow.com/questions/1125968/how-do-i-force-git-pull-to-overwrite-local-files?page=2&tab=oldest#tab-top)

git branch -f master HEAD~3

(6) .gitignore 中包含有windows回车符号

```
.gitignore 中特殊字符问题

显示所有隐藏格式,比较字符,去除 window 中的特殊字符
```


显示工作区根目录:
git rev-parse --show-toplevel 

所在目录相对于工作区根目录的相对目录

git rev-parse --show-prefix



* git 解决中文文件名乱码问题

If you want to allow non-ASCII filenames set this variable to true.

```
allownonascii=$(git config --bool hooks.allownonascii) 
```


























## 多人协作

git clone git@github.com:michaelliao/learngit.git

当你的小伙伴从远程库clone时，默认情况下，你的小伙伴只能看到本地的master分支。可以用git branch命令看看：

```
git branch

* master
```

现在，你的小伙伴要在dev分支上开发，就必须创建远程origin的dev分支到本地，于是他用这个命令创建本地dev分支：

```
git checkout -b dev
```

现在，他就可以在dev上继续修改，然后，时不时地把dev分支push到远程：

```
git commit -m "add /usr/bin/env"
```

第一次 push 的话,需要与远程库关联

```
#git branch --set-upstream dev origin/<branch>
#本地dev分支与远程origin/dev分支的链接
git branch --set-upstream dev origin/dev
```

然后提交

```
git push
```

推送失败,则 `git pull --rebase` 成功，但是合并有冲突，需要手动解决.


解决冲突方式1:

手动编辑冲突文件

解决冲突的方式2:

git difftool (解决冲突中的一种方案) config meld as default git merge tool

```
git config --global merge.tool meld

git mergetool -t meld .
```
### git 切换到上一个分支

git checkout @{-1}

[git 冲突解决](https://www.zhihu.com/question/21215715)

[How to resolve merge conflicts in Git?](https://stackoverflow.com/questions/161813/how-to-resolve-merge-conflicts-in-git)


解决后，提交，再push

---------------------------------
git commit -am 'commit message'


-a, --all
           Tell the command to automatically stage files that have been modified and deleted, but new files you have not told Git about are
           not affected.


### git 使用良好实践

先拉分支, 再操作.完成后再删除分支
