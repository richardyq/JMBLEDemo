//
//  FSRKBodyTemperatureBleUtil.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYBleUtil.h"

@protocol FSRKBodyTemperatureBleUtilDelegate <JYBleUtilDelegate>

@required
- (void) temperature:(CGFloat) temperature error:(NSInteger) errorCode;

@end

@interface FSRKBodyTemperatureBleUtil : JYBleUtil

@end
