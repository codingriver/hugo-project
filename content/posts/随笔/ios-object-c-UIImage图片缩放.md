```
1.等比缩放


- (UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize {
UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize);
[image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();
return scaledImage;
}

2.自定义大小
- (UIImage *) reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
[image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();
return reSizeImage;
}
```
