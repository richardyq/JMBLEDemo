//
//  HoltekBodyWeightBleUtil.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYBleUtil.h"

@protocol HoltekBodyWeightBleUtilDelegate <JYBleUtilDelegate>

- (void) bodyWeight:(float) weight unit:(NSString*) unit;

@end

@interface HoltekBodyWeightBleUtil : JYBleUtil

@end
