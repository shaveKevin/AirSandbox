//
//  AirSandboxCell.h
//  AirSandbox
//
//  Created by shavekevin on 2018/7/27.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AirSandboxModel;
@interface AirSandboxCell : UITableViewCell

- (void)renderCellWithItem:(AirSandboxModel *)item;

@end
