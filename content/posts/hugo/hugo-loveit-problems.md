---
title: "Loveit 使用中的问题" 
date: 2020-08-29T15:58:08+08:00 
tags: ["hugo"]
hiddenFromHomePage: true
categories: ["hugo"]
toc: false
---


### 不支持tweet和instagram 的shortcode
 >网络访问不了，执行`hugo`直接失败，执行`hugo serve`也会失败，必须删除。
 
### 提交github page报错
> config中配置不生成md就好了，因为md中有go语言写法，github编译过不去,把md文件删除。