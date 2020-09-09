
```
//获取appIconName
-(NSString*)GetAppIconName{
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    NSLog(@"GetAppIconName,icon:%@",icon);
    return icon;
}
···
