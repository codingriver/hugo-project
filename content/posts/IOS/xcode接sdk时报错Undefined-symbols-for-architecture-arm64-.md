
---
title: "xcode接sdk时报错Undefined-symbols-for-architecture-arm64-"
date: 2019-12-01T21:57:40+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
 tags: ["IOS","Xcode"]
categories: ["IOS"]
---

<!--more-->


unity 导出xcode后接环信libHyphenateSDK时build报错Undefined symbols for architecture armv7:
也有Undefined symbols for architecture arm64:
```
Undefined symbols for architecture armv7:
  "_CGImageDestinationCreateWithURL", referenced from:
      -[EMVideoMessageBody initWithLocalPath:displayName:] in libHyphenateSDK.a(EMVideoMessageBody.o)
  "_CGImageDestinationAddImage", referenced from:
      -[EMVideoMessageBody initWithLocalPath:displayName:] in libHyphenateSDK.a(EMVideoMessageBody.o)
  "_CGImageDestinationFinalize", referenced from:
      -[EMVideoMessageBody initWithLocalPath:displayName:] in libHyphenateSDK.a(EMVideoMessageBody.o)
ld: symbol(s) not found for architecture armv7
clang: error: linker command failed with exit code 1 (use -v to see invocation)
```



![{A28B1E2A-4EEB-9DB0-ADB5-B16C40B93EAF}.png](http://upload-images.jianshu.io/upload_images/1095643-9928c5eddc68fdaa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

这个错误以为sdk或者framework不支持armv7或者arm64，我这实际上是缺少framework
这个错误是工程里面没有引用 ImageIO.framework造成的，


![image.png](http://upload-images.jianshu.io/upload_images/1095643-3a219e25c9ec76ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  


环信的libHyphenateSDK.a库依赖ImageIO.framework，结果报错让人无语



