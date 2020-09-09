---
title: "Unity 平台宏定义常用说明"
date: 2019-12-01T21:57:40+08:00
tags: ["Unity3d"]
categories: ["Unity3d"]
---

<!--more-->


```csharp
using UnityEngine;
using System.Collections;

public class PlatformDefines : MonoBehaviour {
  void Start () {

    #if UNITY_EDITOR
      Debug.Log("Unity Editor");
    #endif
    #if UNITY_EDITOR_WIN
      Debug.Log("UNITY_EDITOR_WIN");
    #endif
    #if UNITY_EDITOR_OSX
      Debug.Log("UNITY_EDITOR_OSX");
    #endif    

    #if UNITY_IOS
      Debug.Log("Iphone");
    #endif

    #if UNITY_ANDROID
      Debug.Log("UNITY_ANDROID");
    #endif

    #if UNITY_STANDALONE_OSX
    Debug.Log("Stand Alone OSX");
    #endif

    #if UNITY_STANDALONE_WIN
      Debug.Log("Stand Alone Windows");
    #endif


  }          
}
```


[官方说明](https://docs.unity3d.com/Manual/PlatformDependentCompilation.html)
