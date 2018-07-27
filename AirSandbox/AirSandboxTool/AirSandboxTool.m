//
//  AirSandboxTool.m
//  AirSandbox
//
//  Created by shavekevin on 2018/7/27.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "AirSandboxTool.h"
#import <UIKit/UIKit.h>
#import "AirSandboxVC.h"

@interface AirSandboxTool()

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) AirSandboxVC *airSandboxVC;

@end
@implementation AirSandboxTool
+ (instancetype)sharedInstance {
    static AirSandboxTool *airSandboxTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        airSandboxTool = [[AirSandboxTool alloc]init];
    });
    return airSandboxTool;
}


- (void)enableSwipe {
    UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showSandboxBrowser)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionLeft);
    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:swipeGesture];
}

- (void)enableAirSandboxTool {
    [self showSandboxBrowser];
}

- (void)showSandboxBrowser {
    
    self.window.hidden = NO;
}

- (void)hiddenSandboxBrowser {
    
    self.window.hidden = YES;
}

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        CGRect keyFrame = [UIScreen mainScreen].bounds;
        keyFrame.origin.y += 64;
        keyFrame.size.height -= 64;
        _window.frame = CGRectInset(keyFrame, 20, 20);
        _window.backgroundColor = [UIColor whiteColor];
        _window.layer.borderColor = [UIColor orangeColor].CGColor;
        _window.layer.borderWidth = 2.0;
        _window.windowLevel = UIWindowLevelStatusBar;
        _window.rootViewController = self.airSandboxVC;
    }
    return _window;
}

- (AirSandboxVC *)airSandboxVC {
    if (!_airSandboxVC) {
        _airSandboxVC = [[AirSandboxVC alloc]init];
    }
    return _airSandboxVC;
}

@end
