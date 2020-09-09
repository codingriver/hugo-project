---
title: "xLua - 第三方扩展的添加和编译"
date: 2019-12-01T21:57:40+08:00
tags: ["Unity3d"]
categories: ["Unity3d"]
---

<!--more-->

unity 使用xLua插件，这两天增加lua-protobuf插件，所以需要重新编译XLua
这里编译Win平台和Android平台，因为手头上没有mac电脑所以没有编译ios和mac平台库

这里只做简单的记录
### Windows平台
参考文章 [xLua - 第三方扩展的添加和编译](https://blog.csdn.net/xmousez/article/details/68490840)
需要工具：
VS (我这里用的是vs2013，完全安装的，推荐的是vs2015)
cmake（官网下载最新的3.13，[传送门](https://cmake.org/download/)）
windows sdk （我这里是windows sdk 8.1）
 
 环境：win10+vs2013 编译通过

### Android平台 
参考文章 [在windows上编译PC和Android平台的xlua库(并加入第三方lua库lpeg,sproto,lua-crypt)](https://blog.csdn.net/yudianxia/article/details/81738699)
需要工具：
androidstudio 
android sdk
android ndk (android-ndk-r10e-Windows)

 环境：win10+androidstudio  编译通过
 android sudio配置我这用的vpn（也可以用其它方法配置），需要下载cmake（cmake下载后自动配置到android sdk所在的目录），而不是windows安装的cmake
 配置Android_SDK，Android_NDK环境变量，然后编译就可以了
 
  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181022120124521?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  



 android sudio下载cmake后，自动配置到android sdk目录下（默认sdk是没有cmake的）：
   
  

![在这里插入图片描述](https://img-blog.csdn.net/20181022120355540?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  


*mac和ios平台需要mac电脑，等后面补充吧*