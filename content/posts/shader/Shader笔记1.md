---
title: "Shader笔记1"
date: 2021-04-07T21:39:06+08:00
draft: true
---


### 渲染管线流程

    CPU应用阶段： 视锥体剔除，渲染顺序，提交Drawcall
    顶点处理   ： 顶点MVP空间变换，自定义参数
    光栅化操作 ： 裁剪，NDC归一化，背面剔除，屏幕坐标，图元装配，光栅化
    片元处理   ： 光照着色，纹理着色
    输出合并   ： Alpha测试，模版测试，深度测试，颜色混合
    最后输出到帧缓冲区
### 空间变换
模型空间（M）（左手坐标系）-->世界空间（W）（左手坐标系）-->观察空间（V）（右手坐标系）-->裁剪空间（P）（左手坐标系）-->屏幕空间（左手坐标系）


### 类型长度
- float：32位
- half ：16位 精度范围-60000～+60000
- fixed：11位 精度范围-2.0～+2.0

**一般使用fixed存储颜色和单位矢量**


### 法线 
法线一般用切线空间存储，优点：自由度高，uv动画扰动，可以重用，可以压缩（只存储两个方向的数据）

切线空间（右手坐标系）： 法线方向（Z轴），切线方向（X轴）（和uv的u方向相同），次法线方向（Y轴）

切线空间下的法线贴图：？？rgb怎么对应xyz轴

### 纹理
1. 漫反射纹理
2. 法线纹理
3. 渐变纹理（卡通风格，从冷色调到暖色调）
   1. u方向渐变纹理
   2. LUT（查找表，lookup table）纹理
4. 遮罩纹理
   - 高光强度遮罩
   - 高光指数遮罩
   - 边缘光强度遮罩
   - 自发光遮罩
5. 立方体纹理(天空盒)
6. 渲染纹理（渲染目标纹理，RT）
7. 程序纹理


### 光照
```
    漫反射：lambert(dot(n,l))，halflambert(dot(n,l)*0.5+0.5)
    高光反射：phong（dot(v,r)），blinn-phong(dot(n,h))
    边缘光 ：rim=pow(1-abs(dot(n,v)),rimPower)*rimScale
    菲涅尔：fresnel=pow(1-,dot(n,v),fresnelPower)*fresnelScale
           fresnel=max(0,min(1,pow(1-dot(n,v),fresnelPower)*fresnelScale))
    环境光
    自发光
```
#### 光照衰减
> 光照衰减计算量太大，unity使用查找表（LUT，lookup table）纹理存储衰减数据（_LightTexture0），如果光源使用了cookie，则使用衰减查找纹理_LightTextureB0。

```
    # ifdef USING_DIRECTIONAL_LIGHT
        fixed atten=1.0;
    #else
        float3 lightcoord = mul(_LightMatrix0,float4(i.worldPosition,1)).xyz;
        fixed atten=tex2D(_LightTexture0,dot(lightcoord,lightcoord).rr).UNITY_ATTEN_CHANNEL;
    #endif

```
#### 阴影
阴影映射纹理（深度纹理）存储距离光源的深度信息

老版本是在光源空间中计算深度数据

新版本部分平台是在屏幕空间中计算深度数据，显卡必须支持MRT才行



### 动画
1. uv动画
2. 顶点动画
3. 关键帧动画
4. 骨骼动画

### 屏幕后处理

亮度 
`fixed3 finalColor=baseCol.rgb*_Brightness`

饱和度 
```
fixed luminance=0.2125*baseCol.r+0.7154*baseCol.g+0.0721*baseCol.b;
fixed3 luminanceCol=fixed(luminance,luminance,luminance);
finalCol = lerp(luminanceCol,finalCol,_Saturation); 
```

对比度

```
    fixed3 avgColor=fixed3(0.5,0.5,0.5);
    finalCol=lerp(avgColor,finalCol,_Constrast);
```

#### Bloom效果

#### 边缘检测

#### 高斯模糊

#### 运动模糊

### 深度纹理和法线纹理

设置 `camera.depthTextureMode=DepthTextureMode.DepthNormals;`

_CameraDepthTexture

### 全局雾效

### 卡通风格渲染

### 素描风格渲染


### BRDF,PBR,PBS

> 第4章最后说明部分，不理解，裁剪空间变换后z分量和w分量
> 切线空间下的法线贴图：？？rgb怎么对应xyz轴
> 7.4.2 遮罩纹理的使用 data2
> 9.4阴影未看完
> 13章未看
> 着色器替换技术（Shader Replacement）
> 