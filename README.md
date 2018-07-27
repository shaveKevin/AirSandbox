# SKAirSandbox
开发过程中实时查看沙盒的工具
## 集成方式
### cocoapods
```
pod 'SKAirSandbox', '~> 0.0.1'
```
## 使用方式

当keywindow创建之后使用，可使用清扫手势。
```

#ifdef DEBUG
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[SKAirSandboxTool sharedInstance] enableSwipe];
    });
#endif
```
也可以自己单独触发。

```

#ifdef DEBUG
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[SKAirSandboxTool sharedInstance] enableAirSandboxTool];
    });
#endif
```

效果图：

![图1](http://ww1.sinaimg.cn/mw690/006mQyr2ly1ftoeegnq1yj30ku112dhn.jpg)

![图2](http://ww1.sinaimg.cn/mw690/006mQyr2ly1ftoed50srgj30ku112q3p.jpg)

作者:[music4kid](https://github.com/music4kid)

项目原地址：[AirSandbox](https://github.com/music4kid/AirSandbox)

ps:原作者没有制作pod版本 这里给加一个。

