
# git init --bare 
> 命令用于创建一个裸仓库（bare repository），它是一种没有工作目录的 Git 仓库，只包含版本库数据。
> 裸仓库通常用于作为中央代码仓库，用于协作开发或者作为远程仓库进行代码的分发和备份。

使用 git init --bare 命令创建裸仓库的语法如下：
git init --bare <仓库路径>
其中，<仓库路径> 是创建裸仓库的路径。如果不指定路径，则会在当前目录下创建一个以仓库名称为名的裸仓库。

例如，以下命令将创建一个名为 myrepo.git 的裸仓库：

git init --bare myrepo.git
创建完成后，可以将该裸仓库作为远程仓库，供其他开发者进行代码的 Push 和 Pull 操作。

git clone  https://github.com/user/myrepo.git myrepo
克隆完成后，在本地的 myrepo 目录下就可以使用 Git 命令管理裸仓库了。如果需要将修改的代码推送到远程裸仓库，可以使用 git push 命令。
