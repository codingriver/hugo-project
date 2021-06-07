---
title: "Shader笔记1"
date: 2021-04-07T21:39:06+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
tags: []
categories: []
---
<!--more-->

### 渲染管线流程

    CPU应用阶段： 视锥体剔除，渲染顺序，提交Drawcall
    顶点处理   ： 顶点MVP空间变换，自定义参数
    光栅化操作 ： 裁剪，NDC归一化，背面剔除，屏幕坐标，图元装配，光栅化
    片元处理   ： 光照着色，纹理着色
    输出合并   ： Alpha测试，模版测试，深度测试，颜色混合
    最后输出到帧缓冲区

 #### CPU应用程序渲染逻辑
a. 剔除：
- 视锥体剔除（Frustum Culling）
- 层级剔除（Layer Culling Mask），遮挡剔除（Occlusion Culling）等规则

b. 渲染排序：
- 渲染队列 RenderQueue
- 不透明队列（RenderQueue < 2500）
   按摄像机 **从前往后** 排序
- 半透明队列（RenderQueue >2500）
   按摄像机 **从后往前** 排序（为了保证效果的正确性）

c. 打包数据（Batch）：大量数据，参数发送到gpu

**模型信息**
  - 顶点坐标
  - 法线
  - UV
  - 切线
  - 顶点颜色
  - 索引列表

**变换矩阵**
  - 世界变换矩阵
  - VP矩阵：根据射线机位置和fov等参数构建VP矩阵

**灯光，材质参数**
  - Shader
  - 材质参数
  - 灯光信息

d. 调用Shader
  - SetPassCall（Shader，背面剔除等参数，设置渲染数据），DrawCall

![20210410175934](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410175934.png)
![20210410181112](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410181112.png)
![20210410182007](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410182007.png)
![半透明渲染顺序效果对比](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410181803.png)
![20210410182547](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410182547.png)


#### GPU渲染管线
>CPU端调用DrawCall后 在GPU端启动顶点shader执行顶点处理
>顶点Shader：最主要的处理是将模型空间的顶点变换到裁剪空间
- 顶点处理   ： 顶点MVP空间变换，自定义参数
- 光栅化操作 ： 裁剪，NDC归一化，背面剔除，屏幕坐标，图元装配，光栅化
- 片元处理   ： 光照着色，纹理着色
- 输出合并   ： Alpha测试，模版测试，深度测试，颜色混合
![20210410183133](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410183133.png)
![20210410184548](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410184548.png)
![20210410190909](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410190909.png)
![20210410190836](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410190836.png)
![20210410190749](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410190749.png)
![20210410190724](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410190724.png)
裁剪操作是在长方体或者正方体范围内进行的，不是视锥体，这里图中只是表达要进行三角形剔除
![20210410193348](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410193348.png)
##### 颜色混合
常用颜色混合类型
- 正常（Alpha Blend），即透明度混合  
    `Blend SrcAlpha OneMinusSrcAlpha`
- Particle Additive  
     `Blend  SrcAlpha One`
- 柔和叠加(Soft Additive)   
    `Blend OneMinusDstColor One`
- 线性减淡（Additive,Linear Dodge）  
  `Blend One One`    ("LightMode" = "ForwardAdd" 光源叠加Pass使用的混合模式)
- 正片叠底（Multiply），即相乘  
    `Blend DstColor Zero`
- 两倍相乘（2x Multiply）  
    `Blend DstColor SrcColor`
- 变暗（Darken）   
    `BlendOp Min  `  
    `Blend One One  `  
- 变亮（Lighten）  
    `BlendOp Max`  
    `Blend One One`  
- 滤色（Screen）  
    `Blend OneMinusDstColor One`  
    `Blend One OneMinusSrcColor`  


### 空间变换
1. 模型空间（M）（左手坐标系）
1. 世界空间（W）（左手坐标系）
1. 观察空间（V）（右手坐标系）
1. 裁剪空间（P）（左手坐标系）
1. 屏幕空间（左手坐标系）

>裁剪空间是正方形或者长方形，下一步ndc归一化是除以w就到正负1范围内，（z轴在opengl 范围是正负1，在dx中范围是从0到1）
>NDC归一化后进行背面剔剔除（Back Face Culling）根据三角形的索引顺序进行判定背面（三角形索引顺序是顺时针）或者正面（三角形索引顺序是逆时针），然后剔除对应三角形  

![20210410184101](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410184101.png)

### 类型长度
- float：32位
- half ：16位 精度范围-60000～+60000
- fixed：11位 精度范围-2.0～+2.0;也可能是8位

**一般使用fixed存储颜色和单位矢量**


### 法线 
>法线一般用切线空间存储，优点：自由度高，uv动画扰动，可以重用，可以压缩（只存储两个方向的数据）  
>切线空间（右手坐标系）： 切线方向（X轴）（和uv的u方向相同,有的是和v方向相同），次法线方向（Y轴）,法线方向（Z轴）

```
    half3 normal_data=UnpackNormal(normalmap);
    float3x3 TBN=float3x3(tangent_dir,binormal_dir,normal_dir);
    normal_dir=normalize(mul(normal_data.xyz,TBN));
    // 和上面矩阵相乘结果一样
    //normal_dir=normalize(tangent_dir*normal_data.x+binormal_dir*normal_data.y+normal_dir*normal_data.z);
```


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
8. AOMap
9.  高度图，视差贴图（视差偏移，视差映射）
10. 粗糙度贴图
11. 动画纹理（VAT）
12. FlowMap
    


### 光照
- 漫反射：
    - lambert:`max(0,dot(n,l))`
    - halflambert:`dot(n,l)*0.5+0.5`
    - diffuse=basecolor*lightcolor*lambert ( or halflambert )
- 镜面反射（高光，各向异性高光，kk高光）：
    - phong:`pow(max(dot(v,r),0),_Gloss)`
    - blinn-phong:`pow(max(dot(n,h),0),_Gloss) //性能比phong要好`
    - speccolor=lightcolor*_SpecIntensity*lambert*blinn-phong  ( or phong )
- 间接光漫反射：可以用 **光照探针（light Probe）** ，使用 SH 球谐光照模拟
- 间接光镜面反射:可以用 **反射探针（reflection Probe）**，使用 IBL （基于图像的照明）模拟
- 边缘光 ：`rim=pow(1-abs(dot(n,v)),rimPower)*rimScale`
- 菲涅尔：
    - `fresnel=pow(1-,dot(n,v),fresnelPower)*fresnelScale`
    - `fresnel=max(0,min(1,pow(1-dot(n,v),fresnelPower)*fresnelScale))`
- 环境光(ambient): 环境光可以理解为间接光的一部分(可以用 **间接光漫反射**和 **间接光镜面反射**代替)
  - `half3 ambient_color = UNITY_LIGHTMODEL_AMBIENT.rgb * base_color.xyz;`
- 自发光
- Matcap: `float2 uv_mapcap=(vNormal*0.5+0.5).xy;`使用观察空间下的法线代表uv坐标
![20210410205528](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410205528.png)
![20210410192004](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410192004.png)
> **Phong 光照模型：** `max(dot(n,l),0)+pow(max(dot(v,r),0),smoothness)+ambient=Phong`  
> **基础光照模型=直接光漫反射(Direct Diffuse)+直接光镜面反射(Direct Specular)+间接光漫反射(Indirect Diffuse)+间接光镜面反射(Indirect Specular)**  
> 直接光镜面反射: PBR中的GGX光照模型  

#### 环境贴图
 环境贴图 （存储环境光或者间接光的漫反射和镜面反射的图像载体），*环境光可以理解为间接光的一部分*。

环境贴图一般转成立方体贴图（Cubemap）使用，原因：**直接采样环境贴图会造成贴图空间的浪费及采样会出现失真情况，所以先转成立方体贴图**

Cubemap立方体贴图的局限性： **只根据方向来采样 Cubemap 会造成采样点错误，这也是为什么Cubemap技术不适合用于平面模型作反射的原因**

立方体贴图（Cubemap）采样：`texCUBE(_CubeMap, reflect_dir)`

![20210410225349](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410225349.png)
![20210525192856](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210525192856.png)
![20210525192804](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210525192804.png)
![20210410230114](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410230114.png)

- CubeMap
```
			samplerCUBE _CubeMap;
			float4 _CubeMap_HDR;  
			    half3 view_dir = normalize(_WorldSpaceCameraPos.xyz - i.pos_world);
				half3 reflect_dir = reflect(-view_dir, normal_dir);
				half4 color_cubemap = texCUBE(_CubeMap, reflect_dir);
				half3 env_color = DecodeHDR(color_cubemap, _CubeMap_HDR);//确保在移动端能拿到HDR信息
```

- IBL_Specular
```
samplerCUBE _CubeMap;
float4 _CubeMap_HDR;

				half3 reflect_view_dir = reflect(-view_dir, normal_dir);

				float roughness = tex2D(_RoughnessMap, i.uv);
				roughness = saturate(pow(roughness, _RoughnessContrast) * _RoughnessBrightness);
				roughness = lerp(_RoughnessMin, _RoughnessMax, roughness);
				roughness = roughness * (1.7 - 0.7 * roughness);
				float mip_level = roughness * 6.0;

				half4 color_cubemap = texCUBElod(_CubeMap, float4(reflect_view_dir, mip_level));
				half3 env_color = DecodeHDR(color_cubemap, _CubeMap_HDR);//确保在移动端能拿到HDR信息
```
- IBL_Diffuse
```
			samplerCUBE _CubeMap;
			float4 _CubeMap_HDR;

    			float roughness = tex2D(_RoughnessMap, i.uv);
				roughness = saturate(pow(roughness, _RoughnessContrast) * _RoughnessBrightness);
				roughness = lerp(_RoughnessMin, _RoughnessMax, roughness);
				roughness = roughness * (1.7 - 0.7 * roughness);
				float mip_level = roughness * 6.0;
				float4 uv_ibl = float4(normal_dir, mip_level);
				half4 color_cubemap = texCUBElod(_CubeMap, uv_ibl);
				half3 env_color = DecodeHDR(color_cubemap, _CubeMap_HDR);//确保在移动端能拿到HDR信息
				half3 final_color = env_color * ao * _Tint.rgb * _Tint.rgb * _Expose;
```

- IBL_Reflection-Probe(环境光镜面反射)（unity捕捉生成的,unity最多支持两个反射探针）
```
    			half3 view_dir = normalize(_WorldSpaceCameraPos.xyz - i.pos_world);
				half3 reflect_view_dir = reflect(-view_dir, normal_dir);

				reflect_view_dir = RotateAround(_Rotate, reflect_view_dir);
				
				float roughness = tex2D(_RoughnessMap, i.uv);
				roughness = saturate(pow(roughness, _RoughnessContrast) * _RoughnessBrightness);
				roughness = lerp(_RoughnessMin, _RoughnessMax, roughness);
				roughness = roughness * (1.7 - 0.7 * roughness);
				float mip_level = roughness * 6.0;

				
				half4 color_cubemap = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflect_view_dir, mip_level);
				half3 env_color = DecodeHDR(color_cubemap, unity_SpecCube0_HDR);//确保在移动端能拿到HDR信息
```
- IBL_Light-Probe（环境光漫反射，内部使用SH读取）
```
    half3 env_color = ShadeSH9(float4(normal_dir,1.0)); //unity 内置函数
```

- SH球谐光照（环境光漫反射可以使用SH）（可以替代IBL_Diffuse，节省性能，不用读取cube贴图）
```
    			float4 normalForSH = float4(normal_dir, 1.0);
				//SHEvalLinearL0L1
				half3 x;
				x.r = dot(custom_SHAr, normalForSH);
				x.g = dot(custom_SHAg, normalForSH);
				x.b = dot(custom_SHAb, normalForSH);

				//SHEvalLinearL2
				half3 x1, x2;
				// 4 of the quadratic (L2) polynomials
				half4 vB = normalForSH.xyzz * normalForSH.yzzx;
				x1.r = dot(custom_SHBr, vB);
				x1.g = dot(custom_SHBg, vB);
				x1.b = dot(custom_SHBb, vB);

				// Final (5th) quadratic (L2) polynomial
				half vC = normalForSH.x*normalForSH.x - normalForSH.y*normalForSH.y;
				x2 = custom_SHC.rgb * vC;

				float3 sh = max(float3(0.0, 0.0, 0.0), (x + x1 + x2));
```
![20210410233734](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410233734.png)
#### 光照衰减
> 光照衰减计算量太大，unity使用查找表（LUT，lookup table）纹理存储衰减数据（_LightTexture0），如果光源使用了cookie，则使用衰减查找纹理_LightTextureB0。

```
    # ifdef USING_DIRECTIONAL_LIGHT
        fixed atten=1.0;
    #else
        float3 lightcoord = mul(unity_WorldToLight,float4(i.worldPosition,1)).xyz;
        fixed atten=tex2D(_LightTexture0,dot(lightcoord,lightcoord).rr).r; //r equal UNITY_ATTEN_CHANNEL not cookie
    #endif

```
**一种简单的做法 点光源**
```
    # ifdef USING_DIRECTIONAL_LIGHT
        //half3 light_dir=normalize(_WorldSpaceLightPos0.xyz);
        fixed atten=1.0;
    #else
        //half3 light_dir=normalize(_WorldSpaceLightPos0.xyz-i.pos_world);
        half distance=length(_WorldSpaceLightPos0.xyz-i.pos_world);
        half range=1.0/untiy_WorldToLight[0][0]; //光源范围
        fixed atten=saturate((range-distance)/range);
    #endif
    half3 light_dir=normalize( lerp(_WorldSpaceLightPos0.xyz,_WorldSpaceLightPos0.xyz-i.pos_world,_WorldSpaceLightPos0.w));
```
#### 阴影（Shadow）
> 阴影映射纹理（深度纹理）存储距离光源的深度信息  
> 老版本是在光源空间中计算深度数据  
> 新版本部分平台是在屏幕空间中计算深度数据，显卡必须支持MRT才行  

![20210410222024](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410222024.png)
![20210410223031](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410223031.png)
![20210410223113](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410223113.png)
![20210410223441](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410223441.png)

### 角色渲染
![20210411011821](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210411011821.png)
![20210411012026](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210411012026.png)
### 动画
1. uv动画
2. 顶点动画
3. 关键帧动画
4. 骨骼动画

### 屏幕后处理
![20210531181339](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210531181339.png)

- 亮度  
`fixed3 finalColor=baseCol.rgb*_Brightness`

- 饱和度 
```
    fixed luminance=0.2125*baseCol.r+0.7154*baseCol.g+0.0721*baseCol.b;
    fixed3 luminanceCol=fixed(luminance,luminance,luminance);
    finalCol = lerp(luminanceCol,finalCol,_Saturation); 
```

- 对比度

```
    fixed3 avgColor=fixed3(0.5,0.5,0.5);
    finalCol=lerp(avgColor,finalCol,_Constrast);
```

- 晕影/暗角（Vignette）

```
    //暗角/晕影
    float2 d=abs(i.uv-half2(0.5,0.5))*_VignetteIntensity;
    d=pow(saturate(d),_VignetteRoundness);
    float dist=length(d);
    float vfactor=pow(saturate(1.0-dist*dist),_VignetteSmoothness);
```  

#### Bloom效果

#### 边缘检测

#### 方框模糊/均值模糊（Box Blur）
> 参考：[高品质后处理：十种图像模糊算法的总结与实现](https://blog.csdn.net/poem_qianmo/article/details/105350519)

#### 高斯模糊（Gaussian Blur）

#### 双重模糊（Dual Blur）

#### Kawase模糊（DualKawaseBlur）

#### 光晕


#### 运动模糊

### 深度纹理和法线纹理

> 设置 `camera.depthTextureMode=DepthTextureMode.DepthNormals;`  
> `_CameraDepthTexture`  


### 全局雾效

### 卡通风格渲染

### 素描风格渲染
### 色调映射(Tone-Mapping)

**用Tone-Mapping压缩高光范围**
*HDR颜色通过色调映射转到（0-1）范围内*
**一般用于屏幕后处理**
```
    // Tone-Mapping 需要将x从Gamma空间转到Lear线性空间使用，结果再转到Gamma空间下
    inline float3 ACESFilm(float3 x)
    {
        float a=2.51f;
        float b= 0.03f;
        float c=2.43f;
        float d=0.59f;
        float e=0.14f;
        return saturate((x*(a*x+b))/(x*(c*x+d)+e))
    }

    // Gamma空间 转Lear空间 color_lear=pow(color_gamma,2.2);
    // Lear空间转Gamma空间 color_gamma=pow(color_lear,1.0/2.2);
```
![20210410220805](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader笔记1/20210410220805.png)
### PBR 
>PBR(Physically based Rendering)：基于物理渲染  
>PBS(Physically Based Shading)：基于物理着色  
>BRDF（Bidirectional Reflectance Distribution Function): 双向反射分布函数  
> BRDF是实现PBR的一种方法  
> 高光、几何阴影、菲涅尔反射共同构成了一个BRDF渲染  
>PBR可理解为是一套渲染标准，其核心是PBS（Physically Based Shading）着色模型，具体实现由各大渲染引擎自己负责。  
>Unity的PBS实现封装为Standard，UE4中实现封装为Default Lit。  

**什么是BRDF**
- 物体表面粗糙，很多细小表面产生反射，使用BRDF渲染粗糙表面
- BRDF（双向反射分布函数）光照模型是PBS的重要组成部分，用于描述光在物体表面的反射情况。该模型基于微表面理论，认为光在物体表面反射的光量是物体表面的所有微小表面漫反射和镜面反射光量的总和，符合能量守恒：
  - 1.反射的光总量不大于入射的光总量，且漫反射和镜面反射是互斥关系；
  - 2.粗糙的表面反射的光线分散且暗，光滑的表面反射集中且亮。
  
**怎么实现BRDF**
- 高光 NDF(Normal Distribution Function)
  - 物体的高光反射，有很多高光公式，可以选用blinn-phong，也可以用其它的
- 几何阴影 GSF(Geometric Shadowing Function)
  - 细小表面互相产生阴影，反射，光能量衰减，最终影响到显示，公式有很多
- 菲涅尔反射 Fresnel Function
  - 物体表面反射和漫反射同时发生，以一定比率混合
  - 可以使用fresnel系数公式计算比率

### 渲染优化
#### 开销成因
1. CPU
   1. 过多的drawcall
   2. 复杂的脚本或者物理模拟
2. GPU
   1. 顶点处理
      1. 过多的顶点
      2. 过多的逐顶点计算
   2. 片元处理
      1. 过多的片元（可能分辨率高或者overdraw）
      2. 过多的逐片元计算
3. 带宽
   1. 使用尺寸很大且未压缩的纹理
   2. 分辨率过高的帧缓存
#### 优化方案
1. CPU 
   1. 静态批处理（static batching）降低drawcall
   2. 动态批处理（顶点属性小于900（如果使用顶点坐标，法线和纹理坐标则顶点数量小于300），lightmap必须参数相同指向同一位置，多pass打断合并）降低drawcall
   3. 使用图集
   4. 共享材质
2. GPU
   1. 减少顶点数量
      1. 优化几何体
      2. 使用模型lod（Level of Detail）技术（unity中使用LOD Group组件）
      3. 使用遮挡剔除（Occlusion Culling）技术
      4. 使用mesh压缩
   2. 减少片元数量（核心降低overdraw）
      1. 控制绘制顺序
      2. 警惕透明物体
      3. 减少实时光照和阴影
   3. 减少计算复杂度
      1. 使用Shader的LOD技术
         1. 设置Shader.maximumLDO或者Shader.globalMaximumLOD来允许最大的LOD
      2. Shader代码优化
         1. 把高斯模糊和边缘计算计算放到顶点shader中
         2. float存储顶点坐标等变量，half存储一些标量和纹理坐标等信息，fixed适用于大多数颜色变量和归一化的方向矢量
3. 节省内存带宽
   1. 减少纹理大小
   2. mipmap
   3. 关闭readwrite
   4. 纹理压缩（ETC2 8bit，ASTC 4x4 block，PVRTC）
   5. 降低屏幕分辨率

>待处理
> 7.4.2 遮罩纹理的使用 data2
> 着色器替换技术（Shader Replacement）
> 