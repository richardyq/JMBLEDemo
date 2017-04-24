//
//  BleDetectViewController.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/19.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBleUtil.h"

@interface BleDetectViewController : UIViewController
{
    
}
@property (nonatomic, readonly) UILabel* statusLable;
@property (nonatomic, readonly) JYBleUtil* bleUtil;
@end
