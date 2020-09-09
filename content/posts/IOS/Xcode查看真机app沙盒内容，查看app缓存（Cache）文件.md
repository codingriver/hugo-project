
---
title: "Xcode查看真机app沙盒内容，查看app缓存（Cache）文件"
date: 2019-12-01T21:57:40+08:00
tags: ["IOS","Xcode"]
categories: ["IOS"]
---

<!--more-->


1.连接你的设备，在Xcode下点击 Window —> Device（cmd + shift + 2） 弹出窗口，选择你的设备，找到你已安装的APP，选中你想要查看沙盒的APP。

2.点击底部有个类似设置的按钮，出现几个选项，选择Download Container ，下载文件到本地，将会看到一个后缀为xcappdata的文件，选择这个文件并显示包内容查看对应的沙盒文件。



![image.png](http://upload-images.jianshu.io/upload_images/1095643-f49ffa4fa1ac7bf6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

xia


***下载失败或者Show Container没有内容 解决方案：  卸载app，重启手机设备，安装app就好了**



![image.png](http://upload-images.jianshu.io/upload_images/1095643-fedae4011f06342e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  



