
---
title: "untiy-ios透明ui-的透明区域渲染错误"
date: 2019-12-01T21:57:40+08:00
tags: ["Unity","IOS"]
categories: ["Unity"]
---

<!--more-->


**渲染错误**


![image.png](http://upload-images.jianshu.io/upload_images/1095643-4add35b200b35c53.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  



**渲染正确**


![image.png](http://upload-images.jianshu.io/upload_images/1095643-36b1ef97be474c85.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  



原因是图片压缩了
将图片压缩改成RGBA32bit就好了


![image.png](http://upload-images.jianshu.io/upload_images/1095643-3109660f1455955d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

