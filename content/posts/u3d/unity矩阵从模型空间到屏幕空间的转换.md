---
title: "unity 矩阵从模型空间到屏幕空间的转换"
date: 2019-12-01T21:57:40+08:00
tags: ["Math"]
categories: ["Math"]
---

<!--more-->

>这里参考 《unity shader 入门精要》冯乐乐的这本书
>[深入探索透视投影变换](https://blog.csdn.net/cbbbc/article/details/51296804)
>

##  0X01 变换

*变换这里粗略的讲解下，为了后面的空间转换做铺垫，不是重点，如果看不 明白则看考其他文章*
这里讲解的变换有三种：**平移变换**，**缩放变换**，**旋转变换**
说变换就要用到矩阵，这里用4x4矩阵来进行这三种变换

$$
\left\{
  \begin{matrix}
   M_{3*3}& t _{3*1} \\
   0_{1*3} & 1 \\
  \end{matrix}
  \right\} \tag{1}
$$
M~3*3~用于表示旋转和缩放，t~3*1~用于表示平移，0~1*3~是零矩阵

## 平移变换
将点（x,y,z）在空间中平移（t~x~,t~y~,t~z~）,用矩阵表示为
 
 $$
\left[
  \begin{matrix}
	1 & 0&0&t_x \\
	0 & 1&0&t_y \\
	0 & 0&1&t_z \\
	0 & 0&0&1\\
  \end{matrix}
  \right] \times{
\left[
  \begin{matrix}
	x \\y\\z\\1\\
  \end{matrix}
  \right] =
  \left[
  \begin{matrix}
	x+t_x \\y+t_y\\z+t_z\\1\\
  \end{matrix}
  \right] 
}
  \tag{1}
$$
## 缩放变换
对模型沿着x轴y轴和z轴进行缩放
 $$
\left[
  \begin{matrix}
	k_x& 0&0&0 \\
	0 & k_y&0&0 \\
	0 & 0&k_z&0 \\
	0 & 0&0&1\\
  \end{matrix}
  \right] \times{
\left[
  \begin{matrix}
	x \\y\\z\\1\\
  \end{matrix}
  \right] =
  \left[
  \begin{matrix}
	k_xx \\k_yy\\k_zz\\1\\
  \end{matrix}
  \right] 
}
  \tag{2}
$$
## 旋转变换
这里着重讲下这个，吐槽下好多博客将旋转连旋转正方向都没有说 ，看的云里雾里
==**关于旋转的正方向，OpenGL与多数图形学书籍规定的正方向为逆时针方向（沿着坐标轴负方向向原点看）**==
  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181012092900338?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  

参考这篇文章[旋转变换（一）旋转矩阵](https://blog.csdn.net/csxiaoshui/article/details/65446125)

绕着z轴旋转$\theta$度的 矩阵
 $$
 R_x(\theta) =
\left[
  \begin{matrix}
	cos(\theta)&-sin(\theta)&0&0 \\
	sin(\theta)&cos(\theta)&0 &0\\
	0& 0&1&0 \\
	0 & 0&0&1\\
  \end{matrix}
  \right]   
$$

绕着y轴旋转$\theta$度的 矩阵
 $$
 R_x(\theta) =
\left[
  \begin{matrix}
	cos(\theta)&0&sin(\theta)&0\\
	0& 1&0&0 \\
	-sin(\theta)&0&cos(\theta)&0 \\
	0 & 0&0&1\\
  \end{matrix}
  \right]   
$$

绕着x轴旋转$\theta$度的 矩阵
 $$
 R_x(\theta) =
\left[
  \begin{matrix}
	1& 0&0&0 \\
	0 & cos(\theta)&-sin(\theta)&0 \\
	0 & sin(\theta)&cos(\theta)&0 \\
	0 & 0&0&1\\
  \end{matrix}
  \right]   
$$

==**unity中旋转的顺序是首先绕Z轴进行旋转，然后绕X轴进行旋转，最后绕Y轴进行旋转。**==

##  0X02 坐标空间变换
已知子坐标空间C的三个坐标轴在父坐标空间P下的表示x~c~、y~c~、z~c~，以及其原点位置O~c~，当给定一个子坐标空间中的点A~c~=(a,b,c)，求A点用父坐标空间的表示A~p~
x~c~设为(x~cx~,x~cy~,x~cz~),y~c~设为(y~cx~,y~cy~,y~cz~),z~c~设为(z~cx~,z~cy~,z~cz~),O~c~设为(o~cx~,o~cy~,o~cz~)
这里写结论不写推导过程了
 $$
A_p =
\left[
  \begin{matrix}
	x_{cx}& 	y_{cx}& 	z_{cx}&o_{cx}\\
	x_{cy}&	y_{cy}&	z_{cy}&o_{cy}\\
	x_{cz}&	y_{cz}&	z_{cz}&o_{cz}\\
	0 & 0&0&1\\
  \end{matrix}
  \right]   
  \times{
\left[
  \begin{matrix}
	a \\b\\c\\1\\
  \end{matrix}
  \right] 
}
$$
所以点从子坐标空间到父坐标空间的变换矩阵M~c->p~为(|表示是按列展开的)
 $$
M_{c->p} =
\left[
  \begin{matrix}
	|&|&|&|\\
	x_{c}&	y_{c}&	z_{c}&o_{c}\\
	|&|&|&|\\
	0 & 0&0&1\\
  \end{matrix}
  \right]   
$$
矢量（不需要平移）从子坐标空间到父坐标空间的变换矩阵M~c->p~为(|表示是按列展开的)
 $$
M_{c->p} =
\left[
  \begin{matrix}
	|&|&|\\
	x_{c}&	y_{c}&	z_{c}\\
	|&|&|\\
  \end{matrix}
  \right]   
$$
矢量（不需要平移）从父坐标空间到子坐标空间的变换矩阵M~p->c~为(-表示是按行展开的)
 $$
M_{p->c} =
\left[
  \begin{matrix}
	-&	x_{c}&-\\
	-&	y_{c}&	-\\
	-&	z_{c}&-\\
  \end{matrix}
  \right]   
$$

##  0X03 空间变换过程
空间变换经历这几个过程：==模型空间(model  space)==--->==世界空间(world space)==-->==观察空间(view space)==`（右手坐标系）`-->==裁剪空间(clip space)==-->==屏幕空间(screen space)== 
*除了观察空间是右手坐标系外其他的全是左手坐标系*
屏幕空间 的转换需要经过NDC变换 然后视口坐标变换（只关注x,y；z不关注）再到屏幕坐标
这里用的是   透视 相机没有用正交相机
在文章最下面提供了`TransformationMatrixUtil.cs`脚本

## **模型空间到世界空间**
根据世界空间对模型空间的平移、旋转、缩放来建立一个变换矩阵，变换矩阵根据上面提到的基础矩阵相乘得到
建立一个 测试脚本`TestMatrix.cs` 来测试变换坐标

```csharp
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestMatrix : MonoBehaviour {

    // Use this for initialization
    Camera cam;

    /// <summary>
    /// 模型空间的物体，localPosition作为模型空间的坐标
    /// 父物体的Transform作为世界空间对模型空间的变换
    /// </summary>
    public Transform trans1;
    void Start()
    {
        cam = Camera.main;
        TestModelSpaceToWorldSpace();
    }
    

    /// <summary>
    /// 模型空间转世界空间的坐标
    /// </summary>
    void TestModelSpaceToWorldSpace()
    {
        Transform _parent = trans1.parent;
        //模型空间转世界空间
        Vector3 p = TransformationMatrixUtil.MToWPosition(_parent.localScale, _parent.localEulerAngles, _parent.localPosition, trans1.localPosition);
        Debug.Log("模型空间转世界空间的坐标：" + p);
        Debug.Log("物体的世界坐标" + trans1.position);
        //模型空间转世界空间
        Matrix4x4 matrix = TransformationMatrixUtil.MToWMatrix(_parent.localScale, _parent.localEulerAngles, _parent.localPosition);
        Debug.LogFormat("matrix:\n{0}\n\nlocalToWorldMatrix:\n{1}\n\n是否相等：{2}", matrix, _parent.localToWorldMatrix, matrix == _parent.localToWorldMatrix);
    }
}
```
场景中配置两个物体 Root，Cube；Root的Transform代表世界空间对Cube模型空间的变换
  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181013095156321?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  

  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181013095307949?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  

测试代码的结果：说明变换后的坐标和物体本身世界坐标相同
  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181013104313560?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  

**来看世界空间到模型空间**
继续增加测试代码
```
    /// <summary>
    /// 世界空间到模型空间变换对比
    /// 这里直接对比变换矩阵是否相同
    /// </summary>
    void TestWorldSpaceToModelSpace()
    {
        //检查世界空间到模型空间
        Transform _parent = trans1.parent;
        //模型空间转世界空间
        Matrix4x4 matrix = TransformationMatrixUtil.MToWMatrix(_parent.localScale, _parent.localEulerAngles, _parent.localPosition);
        //世界空间转模型空间；就是matrix的逆矩阵
        matrix = matrix.inverse;
        Debug.LogFormat("matrix:\n{0}\n\nworldToLocalMatrix:\n{1}\n\n是否相等：{2}", matrix, _parent.worldToLocalMatrix, matrix== _parent.worldToLocalMatrix);
        

    }
```
在Start方法中调用后的结果：
  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181013100821727?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  


## **模型空间到观察空间**
继续增加测试代码
```csharp
    /// <summary>
    /// 世界空间到观察空间变换对比
    /// 这里是透视相机，没有做正交相机的
    /// </summary>
    void TestWorldSpaceToViewSpace()
    {
        //注意这里是透视相机，没有做正交相机变换矩阵
        cam = Camera.main;
        //世界空间坐标到观察空间坐标
        Vector3 viewPos = TransformationMatrixUtil.WToVPosition(trans1.position);
        //结果是z轴相反，因为世界空间是左手坐标系，而观察空间是右手坐标系
        Debug.LogFormat("世界空间:{0},观察空间:{1}", trans1.position, viewPos);
        //世界空间到观察空间
        Matrix4x4 matrix = TransformationMatrixUtil.WToVMatrix();
        Debug.LogFormat("matrix:\n{0}\n\n worldToCameraMatrix:\n{1}\n\n是否相等：{2}", matrix, cam.worldToCameraMatrix, matrix == cam.worldToCameraMatrix);
    }

```
在Start方法中调用后的结果：
  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181013101819939?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  


## **观察空间到裁剪空间**
继续增加测试代码
```
    /// <summary>
    /// 测试观察空间到裁剪空间的变换矩阵
    /// </summary>
    void TestViewSpaceToClipSpace()
    {
        //观察空间到裁剪空间矩阵，注意这里是透视相机，没有做正交相机变换矩阵
        Matrix4x4 matrix = TransformationMatrixUtil.VToPMatrix();
        Debug.LogFormat("matrix:\n{0}\n\n projectionMatrix:\n{1}\n\n是否相等：{2}", matrix, cam.projectionMatrix, matrix == cam.projectionMatrix);
    }
```
在Start方法中调用后的结果：
  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181013102306526?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  

## **模型空间到屏幕空间**
这里直接测试从模型空间到世界空间到观察空间到屏幕空间变换
```csharp
    /// <summary>
    /// 测试模型空间到屏幕空间的变换
    /// 只验证 屏幕坐标xy，不验证zw
    /// 注意这里是透视相机，没有做正交相机变换矩阵
    /// </summary>
    void TestModelSpaceToScreenSpace()
    {
        Transform _parent = trans1.parent;
        //模型空间转世界空间
        Vector3 worldPos = TransformationMatrixUtil.MToWPosition(_parent.localScale, _parent.localEulerAngles, _parent.localPosition, trans1.localPosition);
        //世界空间转观察空间
        Vector3 viewPos = TransformationMatrixUtil.WToVPosition(worldPos);
        //观察空间转透视裁剪空间
        Vector4 clipPos = TransformationMatrixUtil.VToPPosition(viewPos);
        //裁剪空间到屏幕空间变换
        Vector4 screenPos = TransformationMatrixUtil.PToScreenPosition(clipPos);

        Vector4 screenPos1 = cam.WorldToScreenPoint(trans1.position);
        //Vector4 viewportPos = cam.WorldToViewportPoint(trans1.position);
        Debug.LogFormat(" worldPos:{0},trans1.positon:{1}\n viewPos:{2}\n clipPos:{3}\n screenPos:{4},screenPos1:{5}",worldPos,trans1.position,viewPos,clipPos,screenPos,screenPos1);
        
    }
```
在Start方法中调用后的结果：（如果想要一样的结果则需要设置分辨率为1280*720，并且相机配置一样）
这里只验证屏幕坐标x和y，z值是世界坐标的z值，没有变换的，w值没有研究
  
  

![在这里插入图片描述](https://img-blog.csdn.net/20181013103949544?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NvZGluZ3JpdmVy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  



**脚本`TransformationMatrixUtil.cs`**
```csharp
//=====================================================
// - FileName:      TransformationMatrixUtil.cs
// - Created:       wangguoqing
// - UserName:      2018/09/03 17:18:56
// - Email:         wangguoqing@hehegames.cn
// - Description:   
// -  (C) Copyright 2008 - 2015, codingriver,Inc.
// -  All Rights Reserved.
//======================================================
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TransformationMatrixUtil {

	
    /// <summary>
    /// 模型空间的坐标转世界空间坐标
    /// </summary>
    /// <param name="scale">世界空间对模型的缩放</param>
    /// <param name="rotation">世界空间对模型的旋转</param>
    /// <param name="translate">世界空间对模型的平移</param>
    /// <param name="currentPos">模型空间的坐标</param>
    /// <returns></returns>
    public static Vector3 MToWPosition(Vector3 scale, Vector3 rotation, Vector3 translate, Vector3 currentPos)
    {
        Matrix4x4 convertMatrix = MToWMatrix(scale, rotation, translate);
        Vector3 pos= convertMatrix.MultiplyPoint(currentPos);
        return pos;
    }

    /// <summary>
    /// 世界空间的坐标转模型空间坐标
    /// </summary>
    /// <param name="scale">世界空间对模型的缩放</param>
    /// <param name="rotation">世界空间对模型的旋转</param>
    /// <param name="translate">世界空间对模型的平移</param>
    /// <param name="currentPos">世界空间的坐标</param>
    /// <returns></returns>
    public static Vector3 WToMPosition(Vector3 scale, Vector3 rotation, Vector3 translate, Vector3 currentPos)
    {
        Matrix4x4 convertMatrix = MToWMatrix(scale, rotation, translate);
        Vector3 pos = convertMatrix.inverse.MultiplyPoint(currentPos);
        return pos;
    }

    /// <summary>
    /// 模型空间到世界空间的变换矩阵
    /// </summary>
    /// <param name="scale">世界空间对模型空间的缩放</param>
    /// <param name="rotation">世界空间对模型空间的旋转</param>
    /// <param name="translate">世界空间对模型空间的平移</param>
    /// <returns></returns>
    public static Matrix4x4 MToWMatrix(Vector3 scale, Vector3 rotation, Vector3 translate)
    {
        Matrix4x4 scaleMatrix = new Matrix4x4();
        scaleMatrix.SetRow(0, new Vector4(scale.x, 0, 0, 0));
        scaleMatrix.SetRow(1, new Vector4(0, scale.y, 0, 0));
        scaleMatrix.SetRow(2, new Vector4(0, 0, scale.z, 0));
        scaleMatrix.SetRow(3, new Vector4(0, 0, 0, 1));

        rotation *= Mathf.Deg2Rad;
        Matrix4x4 rotateMatrixZ = new Matrix4x4();
        rotateMatrixZ.SetRow(0, new Vector4(Mathf.Cos(rotation.z), -Mathf.Sin(rotation.z), 0, 0));
        rotateMatrixZ.SetRow(1, new Vector4(Mathf.Sin(rotation.z), Mathf.Cos(rotation.z), 0, 0));
        rotateMatrixZ.SetRow(2, new Vector4(0, 0, 1, 0));
        rotateMatrixZ.SetRow(3, new Vector4(0, 0, 0, 1));

        Matrix4x4 rotateMatrixY = new Matrix4x4();
        rotateMatrixY.SetRow(0, new Vector4(Mathf.Cos(rotation.y), 0, Mathf.Sin(rotation.y), 0));
        rotateMatrixY.SetRow(1, new Vector4(0, 1, 0, 0));
        rotateMatrixY.SetRow(2, new Vector4(-Mathf.Sin(rotation.y), 0, Mathf.Cos(rotation.y), 0));
        rotateMatrixY.SetRow(3, new Vector4(0, 0, 0, 1));

        Matrix4x4 rotateMatrixX = new Matrix4x4();
        rotateMatrixX.SetRow(0, new Vector4(1, 0, 0, 0));
        rotateMatrixX.SetRow(1, new Vector4(0, Mathf.Cos(rotation.x), -Mathf.Sin(rotation.x), 0));
        rotateMatrixX.SetRow(2, new Vector4(0, Mathf.Sin(rotation.x), Mathf.Cos(rotation.x), 0));
        rotateMatrixX.SetRow(3, new Vector4(0, 0, 0, 1));

        Matrix4x4 translateMatrix = new Matrix4x4();
        translateMatrix.SetRow(0, new Vector4(1, 0, 0, translate.x));
        translateMatrix.SetRow(1, new Vector4(0, 1, 0, translate.y));
        translateMatrix.SetRow(2, new Vector4(0, 0, 1, translate.z));
        translateMatrix.SetRow(3, new Vector4(0, 0, 0, 1));


        //这里注意顺序，矩阵不满足左右交换的，
        //unity中旋转的顺序是首先绕Z轴进行旋转，然后绕X轴进行旋转，最后绕Y轴进行旋转
        Matrix4x4 convertMatrix = translateMatrix * rotateMatrixY * rotateMatrixX * rotateMatrixZ * scaleMatrix;
        return convertMatrix;
    }


    /// <summary>
    /// 世界空间 转到 观察空间
    /// 观察空间是右手坐标系
    /// </summary>
    /// <param name="worldPos"></param>
    /// <returns></returns>
    public static Vector3 WToVPosition(Vector3 worldPos)
    {

        Matrix4x4 mat = WToVMatrix();
        Vector3 viewPos = mat.MultiplyPoint(worldPos);
        return viewPos;
    }

    /// <summary>
    /// 世界空间转观察空间的矩阵
    /// 观察空间是右手坐标系
    /// </summary>
    /// <returns></returns>
    public static Matrix4x4 WToVMatrix()
    {
        //先获取世界空间转模型空间的矩阵（变换矩阵可逆，取逆矩阵）
        Transform camTrans = Camera.main.transform;
        Matrix4x4 matrix = MToWMatrix(camTrans.localScale, camTrans.localEulerAngles, camTrans.position);
        Matrix4x4 inverseMatrix = matrix.inverse;

        //将矩阵改成右手坐标系的矩阵，即z取反
        inverseMatrix.SetRow(2, -inverseMatrix.GetRow(2));
        return inverseMatrix;
    }

    /// <summary>
    /// 观察空间到裁剪空间
    /// 
    /// </summary>
    /// <param name="vPos"></param>
    /// <returns></returns>
    public static Vector4 VToPPosition(Vector3 vPos)
    {

        Matrix4x4 matrix = VToPMatrix();
        Vector4 p = matrix*new Vector4( vPos.x,vPos.y,vPos.z,1);
        return p;
    }

    /// <summary>
    /// 观察空间到裁剪空间的变换矩阵
    /// </summary>
    /// <returns></returns>
    public static Matrix4x4 VToPMatrix()
    {
        Camera cam = Camera.main;
        float near = cam.nearClipPlane;
        float far = cam.farClipPlane;
        float fov = cam.fieldOfView;
        float aspect = cam.aspect;
        Matrix4x4 matrix = VToPMatrix(fov, near, far, aspect);
        return matrix;
    }
    /// <summary>
    /// 透视裁剪矩阵
    /// 透视投影矩阵
    /// 参考（https://blog.csdn.net/cbbbc/article/details/51296804）
    /// View to Projection
    /// 观察空间到裁剪空间
    /// </summary>
    /// <param name="fov"></param>
    /// <param name="near"></param>
    /// <param name="far"></param>
    /// <param name="aspect"></param>
    /// <returns></returns>
    public static Matrix4x4 VToPMatrix(float fov,float near,float far,float aspect)
    {
        float tan= Mathf.Tan((fov * Mathf.Deg2Rad) / 2);

        Matrix4x4 matrix = new Matrix4x4();
        matrix.SetRow(0, new Vector4(1 / (aspect * tan), 0, 0, 0));
        matrix.SetRow(1, new Vector4(0,1 / (tan), 0, 0));
        matrix.SetRow(2, new Vector4(0, 0, -(far + near) / (far - near), -2 * far * near / (far - near)));
        matrix.SetRow(3, new Vector4(0, 0, -1, 0));

        return matrix;
    }

    /// <summary>
    /// 裁剪空间到屏幕空间的坐标变换（x,y是有效的）
    /// </summary>
    /// <param name="p"></param>
    /// <returns></returns>
    public static Vector4 PToScreenPosition(Vector4 p)
    {
        Vector4 ndcPos= PToNDCPosition(p);
        Vector4 texPos = NDCToTexturePosition(ndcPos);
        Vector4 screenPos = TextureToScreenPosition(texPos);
        return screenPos;
    }


    /// <summary>
    /// NDC是一个归一化的空间，坐标空间范围为[-1, 1]。从Projection空间到NDC空间的做法就是做了一个齐次除法！
    /// Projection to NDC
    /// </summary>
    /// <param name="p"></param>
    /// <returns></returns>
    public static Vector4 PToNDCPosition(Vector4 p)
    {
        return p / p.w;
    }
    /// <summary>
    /// NDC - Texture Space
    /// (NDC - Viewport Space 视口空间,z的值这里和视口空间不一样，z的范围是[-1,1],视口坐标的z值是实际的z值)
    /// 这个过程是将[-1, 1]映射到[0, 1]之间。
    /// NDC to Texture space
    /// </summary>
    /// <param name="p"></param>
    /// <returns></returns>
    public static Vector4 NDCToTexturePosition(Vector4 ndcPoint)
    {
        return (ndcPoint + Vector4.one) / 2;
    }

    /// <summary>
    /// Texture Space - Screen Space
    /// 这个过程就是得到顶点最终在屏幕上的坐标，其实就是利用Texture Space的坐标乘上屏幕的宽高。
    /// Texture to Screen
    /// </summary>
    /// <param name="p"></param>
    /// <returns></returns>
    public static Vector4 TextureToScreenPosition(Vector4 texturePoint)
    {
        Vector4 screenPos = new Vector4(texturePoint.x * Screen.width, texturePoint.y * Screen.height, texturePoint.z, texturePoint.w);
        return screenPos;
    }

}


```
测试脚本`TestMatrix.cs`：
```csharp
   //=====================================================
// - FileName:      TestMatrix.cs
// - Created:       wangguoqing
// - UserName:      2018/09/03 17:18:56
// - Email:         wangguoqing@hehegames.cn
// - Description:   
// -  (C) Copyright 2008 - 2015, codingriver,Inc.
// -  All Rights Reserved.
//======================================================
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// 测试空间变换
/// 这里是透视相机，没有做正交相机的
/// </summary>
public class TestMatrix : MonoBehaviour {

    // Use this for initialization
    Camera cam;

    /// <summary>
    /// 模型空间的物体，localPosition作为模型空间的坐标
    /// 父物体的Transform作为世界空间对模型空间的变换
    /// </summary>
    public Transform trans1;
    void Start()
    {
        cam = Camera.main;
        TestModelSpaceToWorldSpace();
        //TestWorldSpaceToModelSpace();
        //TestWorldSpaceToViewSpace();
        //TestViewSpaceToClipSpace();
        //TestModelSpaceToScreenSpace();
    }
    

    /// <summary>
    /// 模型空间转世界空间的坐标
    /// </summary>
    void TestModelSpaceToWorldSpace()
    {
        Transform _parent = trans1.parent;
        //模型空间转世界空间
        Vector3 p = TransformationMatrixUtil.MToWPosition(_parent.localScale, _parent.localEulerAngles, _parent.localPosition, trans1.localPosition);
        Debug.Log("模型空间转世界空间的坐标：" + p);
        Debug.Log("物体的世界坐标" + trans1.position);
        //模型空间转世界空间
        Matrix4x4 matrix = TransformationMatrixUtil.MToWMatrix(_parent.localScale, _parent.localEulerAngles, _parent.localPosition);
        Debug.LogFormat("matrix:\n{0}\n\nlocalToWorldMatrix:\n{1}\n\n是否相等：{2}", matrix, _parent.localToWorldMatrix, matrix == _parent.localToWorldMatrix);
    }
    /// <summary>
    /// 世界空间到模型空间变换对比
    /// 这里直接对比变换矩阵是否相同
    /// </summary>
    void TestWorldSpaceToModelSpace()
    {
        //检查世界空间到模型空间
        Transform _parent = trans1.parent;
        //模型空间转世界空间
        Matrix4x4 matrix = TransformationMatrixUtil.MToWMatrix(_parent.localScale, _parent.localEulerAngles, _parent.localPosition);
        //世界空间转模型空间；就是matrix的逆矩阵
        matrix = matrix.inverse;
        Debug.LogFormat("matrix:\n{0}\n\nworldToLocalMatrix:\n{1}\n\n是否相等：{2}", matrix, _parent.worldToLocalMatrix, matrix== _parent.worldToLocalMatrix);
        

    }

    /// <summary>
    /// 世界空间到观察空间变换对比
    /// 这里是透视相机，没有做正交相机的
    /// </summary>
    void TestWorldSpaceToViewSpace()
    {
        //注意这里是透视相机，没有做正交相机变换矩阵
        cam = Camera.main;
        //世界空间坐标到观察空间坐标
        Vector3 viewPos = TransformationMatrixUtil.WToVPosition(trans1.position);
        //结果是z轴相反，因为世界空间是左手坐标系，而观察空间是右手坐标系
        Debug.LogFormat("世界空间:{0},观察空间:{1}", trans1.position, viewPos);
        //世界空间到观察空间
        Matrix4x4 matrix = TransformationMatrixUtil.WToVMatrix();
        Debug.LogFormat("matrix:\n{0}\n\n worldToCameraMatrix:\n{1}\n\n是否相等：{2}", matrix, cam.worldToCameraMatrix, matrix == cam.worldToCameraMatrix);
    }

    /// <summary>
    /// 测试观察空间到裁剪空间的变换矩阵
    /// 注意这里是透视相机，没有做正交相机变换矩阵
    /// </summary>
    void TestViewSpaceToClipSpace()
    {
        //观察空间到裁剪空间矩阵，注意这里是透视相机，没有做正交相机变换矩阵
        Matrix4x4 matrix = TransformationMatrixUtil.VToPMatrix();
        Debug.LogFormat("matrix:\n{0}\n\n projectionMatrix:\n{1}\n\n是否相等：{2}", matrix, cam.projectionMatrix, matrix == cam.projectionMatrix);
    }

    /// <summary>
    /// 测试模型空间到屏幕空间的变换
    /// 只验证 屏幕坐标xy，不验证zw
    /// 注意这里是透视相机，没有做正交相机变换矩阵
    /// </summary>
    void TestModelSpaceToScreenSpace()
    {
        Transform _parent = trans1.parent;
        //模型空间转世界空间
        Vector3 worldPos = TransformationMatrixUtil.MToWPosition(_parent.localScale, _parent.localEulerAngles, _parent.localPosition, trans1.localPosition);
        //世界空间转观察空间
        Vector3 viewPos = TransformationMatrixUtil.WToVPosition(worldPos);
        //观察空间转透视裁剪空间
        Vector4 clipPos = TransformationMatrixUtil.VToPPosition(viewPos);
        //裁剪空间到屏幕空间变换
        Vector4 screenPos = TransformationMatrixUtil.PToScreenPosition(clipPos);

        Vector4 screenPos1 = cam.WorldToScreenPoint(trans1.position);
        //Vector4 viewportPos = cam.WorldToViewportPoint(trans1.position);
        Debug.LogFormat(" worldPos:{0},trans1.positon:{1}\n viewPos:{2}\n clipPos:{3}\n screenPos:{4},screenPos1:{5}",worldPos,trans1.position,viewPos,clipPos,screenPos,screenPos1);
        
    }
}

```

[github项目](https://github.com/codingriver/UnityProjectTest/tree/master/MatrixTest)

>这篇文章整理太麻烦了，前面关于使用矩阵做变换的原理的整理很粗糙，只是为了下面的使用，这篇文章不做过多介绍，之前研究过了，没有记录现在反过头来整理需要仔细理理
>