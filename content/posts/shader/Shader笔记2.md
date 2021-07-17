---
title: "Shader笔记2"
subtitle: "Shader笔记2"
date: 2021-04-11T09:22:48+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
draft: true
tags: []
categories: []
---

<!--more-->

## tex2Dproj和tex2D的区别
> ref [tex2Dproj和tex2D的区别](https://zhuanlan.zhihu.com/p/107627483)
tex2Dproj和tex2D这两个功能几乎相同。

唯一的区别是，在对纹理进行采样之前，tex2Dproj将输入的UV xy坐标除以其w坐标。这是将坐标从正交投影转换为透视投影。

例如 以下段代码的返回值是相同的.

`float existingDepth01 = tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.screenPosition)).r;`


`float existingDepth01 = tex2D(_CameraDepthTexture, UNITY_PROJ_COORD(i.screenPosition.xy / i.screenPosition.w)).r;`


>具体什么情况下使用tex2Dproj呢?  
>我们知道,裁剪空间的坐标经过缩放和偏移后就变成了(0,ｗ),而当分量除以分量W以后,就变成了(0,1),这样在计算需要返回(0,1)值的时候,就可以直接使用tex2Dproj了.

## 深度图基础及应用
> ref [Unity Shader - 深度图基础及应用](https://www.jianshu.com/p/80a932d1f11e)  
> ref [神奇的深度图：复杂的效果，不复杂的原理](https://zhuanlan.zhihu.com/p/27547127?refer=chenjiadong)  
>  章节：*ShaderLearn-CS61*


- [x] 渲染深度图
- [x] 相交高亮  
- 能量场
- [x] 全局雾效
- [x] 扫描线
- 水淹
- [x] 垂直雾效
- 边缘检测
- 运动模糊
- 景深
- [x] 透过墙壁绘制背后的“人影”



## 特效实现概览

### 入门版水面实现
- 使用相机做一张反射图，使用屏幕坐标作为UV进行采样
- 使用水的法线做出双层法线然后相加得出世界空间法线
  
- 用计算出的法线除以投影空间下的w（z值），做出近大远小的法线扰动（z值越远越大，作为被除数使得法线近大远小）然后和采样UV相加进行UV扰动
- 增加水底使用视察贴图
- 增加阳光照到水面BlinBlin闪闪的效果
  
### 升级版海边
> CS18
1. 水体颜色
2. 反射 
3. 折射/水底
4. 焦散
5. 岸边泡沫
6. 水体运动（顶点动画）

