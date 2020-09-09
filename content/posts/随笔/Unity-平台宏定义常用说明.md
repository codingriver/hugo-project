```
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
