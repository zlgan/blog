gh
gh browse
gh issue list
gh issue view "#2"
gh issue delete 2 --yes

gh repo delete zlgan/extensions --yes

 gh repo list --fork #查看fork 的仓库

github主页

https://github.com/home

overview:

https://github.com/zlgan

repositories

https://github.com/zlgan?tab=repositories

projects：

https://github.com/zlgan?tab=projects

packages：

https://github.com/zlgan?tab=packages

stars：

https://github.com/zlgan?tab=stars

查看watch的项目

https://github.com/watching





高级搜索：

https://github.com/search/advanced



##  codespaces

https://github.com/codespaces

https://fluffy-meme-w9x7xr4qgpx39wg9.github.dev/



## 浏览仓库

1.  在仓库主页按 。号，仓库在网页版的vscode中打开
2. 按go to file之后，按t可以搜索文件
3. 在文件查看页面按l键 转到行

https://github.dev/zlgan/blog

## 登录令牌
# 1. 生成令牌
登录GitHub账户并进入您的账户设置。
在左侧侧边栏中点击“开发人员设置”，然后点击“个人访问令牌”。
点击“生成新令牌”按钮。
给您的令牌命名并选择要授予的范围。
点击“生成令牌”按钮。
将令牌复制到安全的位置，因为您将无法再次查看它。
生成PAT后，您可以在GitHub API上使用它进行身份验证，也可以在HTTPS上替代您的GitHub账户密码进行Git操作的身份验证。您可以在Git客户端设置中将令牌输入为密码，也可以使用Git凭据助手在需要时自动检索令牌。
总的来说，移除基于密码的身份验证是GitHub用户的一项安全改进，因为令牌比密码更安全，并且如果遭到破坏，可以撤销或重新生成。如果您有任何关于生成和使用PAT的问题或问题，您可以参考GitHub文档或联系GitHub支持寻求帮助。

# 2.git 客户端设置
在Git客户端中，您可以将个人访问令牌（PAT）用作GitHub账户的身份验证凭据。设置PAT的步骤如下：
生成PAT。请参考上一个问题的回答，按照步骤生成一个PAT，并将其复制到剪贴板中。
打开Git客户端，并打开要使用PAT进行身份验证的仓库的终端。
在终端中，输入以下命令来配置PAT：
$ git config --global credential.helper store
这将告诉Git客户端在本地存储凭据。
输入以下命令来设置PAT：
$ git credential-store --file ~/.git-credentials store
这将打开一个文本编辑器，并在其中添加一行，包括您的GitHub用户名和PAT。该行应如下所示：
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
