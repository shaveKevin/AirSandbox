//
//  AirSandboxTool.h
//  AirSandbox
//
//  Created by shavekevin on 2018/7/27.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirSandboxTool : NSObject
/**
 单例
 
 @return single
 */
+ (instancetype)sharedInstance;

/**
 通过清扫手势开启
 */
- (void)enableSwipe;
/**
 不通过清扫手势开启(可主动控制是否开启)
 */
- (void)enableAirSandboxTool;
@end
