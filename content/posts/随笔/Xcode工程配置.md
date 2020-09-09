﻿
---
title: "Xcode工程配置"
date: 2019-12-01T21:57:40+08:00
tags: ["]
categories: ["]
---

<!--more-->


##0X01导出Xcode工程
#####1.检查热更新配置
project_base.json等所有以project_开头的文件的配置信息；
这里的url最后的版本文件要和ios在线的版本一致，不一致则先修改


![工程配置-1.png](http://upload-images.jianshu.io/upload_images/1095643-f4eef1722f0ea2d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

#####2.导出Xcode工程


![工程配置-2.png](http://upload-images.jianshu.io/upload_images/1095643-16d77991f6370f59.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  



![工程配置-3.png](http://upload-images.jianshu.io/upload_images/1095643-117829ca43a7da7a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

检查资源版本号和线上的是否相同
如果是发布版本则点击**Publish Packer**，如果是热更新资源则点击**Publish Bundle**
**如果选择Publish Packer 发布版本:**


![工程配置-4.png](http://upload-images.jianshu.io/upload_images/1095643-6963156b26c5dcfc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

检查界面显示的版本是否为当前线上的版本
所有版本号加1，然后点击*Publish Bundle*;
然后导出Xcode工程

**如果选择Publish Bundler 热更新版本:**
检查界面显示的版本是否为当前线上的版本


![工程配置-5.png](http://upload-images.jianshu.io/upload_images/1095643-d0a140e803f185a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

清理缓存
版本号加1，然后点击*Publish Bundle*;
然后导出Xcode工程

#####3.对Xcode工程进行配置
1.打开Capabilities面板
打开*Push Notifications*选项


![工程配置-17.png](http://upload-images.jianshu.io/upload_images/1095643-a1a6f40bc303a78e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

打开*Background Modes*选项，勾选*Remote notifications*


![工程配置-18.png](http://upload-images.jianshu.io/upload_images/1095643-283e786d7467cd25.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  


2.配置打开Notifications后会添加该文件


![工程配置-19.png](http://upload-images.jianshu.io/upload_images/1095643-1bcb3aafd206c198.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

**这样工程配置完成了，然后开始打包**



