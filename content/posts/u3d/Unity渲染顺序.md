
---
title: "Unity渲染顺序"
date: 2019-12-01T21:57:40+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
 tags: ["Unity"]
categories: ["Unity"]
---

<!--more-->


Unity中的渲染顺序有三层：
+ **第一层：Camera的depth，值越大渲染越在前面**
+ **第二层：Sorting Layer，配置SortingLayer面板（越在下面的layer渲染越在前面），然后在Canvas上设置或者在Renderer组件上设置**
+ **第三层:SortingOrder,值越大越在前面渲染，然后在Canvas上设置或者在Renderer组件上设置**
*决定渲染顺序:第一层>第二层>第三层*


![render1.png](http://upload-images.jianshu.io/upload_images/1095643-798cee6f38385334.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)![render2.png](http://upload-images.jianshu.io/upload_images/1095643-3da8b646958023e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  





 
