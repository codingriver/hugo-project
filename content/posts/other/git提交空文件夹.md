---
title: "git提交空文件夹"
date: 2019-12-01T21:57:40+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
tags: [""]
categories: ["随笔"]
---

<!--more-->

>git设计时是不支持空文件夹提交的，这里是在文件夹里面新建.gitignore文件或者.gitkeep空文件来处理的
>unity也支持忽略以.开头的文件的

**新建.gitignore文件**
在空文件夹下新建.gitignore文件，文件内容：
```c
## Ignore everything in this directory
*
## Except this file
!.gitignore
```
这样就能提交git仓库了
*我这是在windows上操作的，不能直接创建以.开头的文件，参考这篇文章[Windows创建.开头的文件或者.开头的文件夹](https://blog.csdn.net/codingriver/article/details/83414019)*

**新建.gitkeep文件**
在空文件夹下新建.gitkeep文件，是空文件，这样就能提交git仓库了