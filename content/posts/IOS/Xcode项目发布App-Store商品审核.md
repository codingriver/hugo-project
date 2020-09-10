
---
title: "Xcode项目发布App-Store商品审核"
date: 2019-12-01T21:57:40+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
tags: ["IOS","Xcode"]
categories: ["IOS"]
---

<!--more-->


> ios配置开发者证书及添加AppID 参考https://www.jianshu.com/p/ee83dc090b20
> ios 配置ItunesConnect添加应用 参考https://www.jianshu.com/p/12ccfa566ae2
>这里使用Xcode的版本为Version 9.2 (9C40b)

###0X01构建版本
1. Product==>Archive


![构建版本-1.png](http://upload-images.jianshu.io/upload_images/1095643-8703e19d3c52d431.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

等待构建完成，
2.构建完成会打开window==>Organizer对应的界面


![构建版本-2.png](http://upload-images.jianshu.io/upload_images/1095643-bfe9031a89a7cb11.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  



![构建版本-3.png](http://upload-images.jianshu.io/upload_images/1095643-dbd07a9f7bca8d01.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

###0X02导出Appstore的ipa包
1.点击右边的Export==>选择Appstore版本，点击Next


![构建版本-4.png](http://upload-images.jianshu.io/upload_images/1095643-eb2ea494920a8867.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

2.将勾选去掉，不Upload，点击Next


![构建版本-5.png](http://upload-images.jianshu.io/upload_images/1095643-ff73c34c5593a3d1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

3.选择自动签名，点击Next（如果出现不一样的界面并且左下角有Reset按钮，则点击Reset重试）


![构建版本-6.png](http://upload-images.jianshu.io/upload_images/1095643-1ff176c2a70ca438.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

4.检查信息，点击Export


![构建版本-7.png](http://upload-images.jianshu.io/upload_images/1095643-564193615c1c168b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

5.选择ipa导出存储路径，点击Export，然后导出ipa完成


![构建版本-8.png](http://upload-images.jianshu.io/upload_images/1095643-e1383f72b42f07ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

###0X03上传ipa包到iTunesConnect上，通过ApplicationLoader
1.打开Application Loader


![构建版本-9.png](http://upload-images.jianshu.io/upload_images/1095643-c5f88611418e2cad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

2.配置账户===>点击选取


![构建版本-10.png](http://upload-images.jianshu.io/upload_images/1095643-adce6684681d71eb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

3.选择上面导出的ipa包，点击打开


![构建版本-11.png](http://upload-images.jianshu.io/upload_images/1095643-dddd20f8bc6df214.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

4.点击下一步


![构建版本-12.png](http://upload-images.jianshu.io/upload_images/1095643-1564ac791793171c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

5.等待上传完成


![构建版本-13.png](http://upload-images.jianshu.io/upload_images/1095643-a67e7f4f26f666c9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

**然后在iTunesConnect上选择刚上传的包**
###0X04导出ipa包用hoc模式（替换上面的第二节0X02）
1.点击右边的Export==>选择Ad Hoc版本，点击Next


![构建版本-4.png](http://upload-images.jianshu.io/upload_images/1095643-eb2ea494920a8867.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

2.选择Next


![构建版本-14.png](http://upload-images.jianshu.io/upload_images/1095643-79df5483baa79f4e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

3.选择自动签名，点击Next（如果出现不一样的界面并且左下角有Reset按钮，则点击Reset重试）


![构建版本-6.png](http://upload-images.jianshu.io/upload_images/1095643-1ff176c2a70ca438.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

4.检查信息，点击Export


![构建版本-7.png](http://upload-images.jianshu.io/upload_images/1095643-564193615c1c168b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

5.选择ipa导出存储路径，点击Export，然后导出ipa完成


![构建版本-8.png](http://upload-images.jianshu.io/upload_images/1095643-e1383f72b42f07ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

hoc模式不是上传appstore的，是给自己测试用的



