//
//  YuwellBloodPressureBluUtil.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/19.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYBleUtil.h"

@protocol YuwellBloodPressureBluUtilDelegate <JYBleUtilDelegate>

@required
- (void) detectingPressure:(NSInteger) pressure;

- (void) detectedsystolic:(NSInteger) systolic diastolic:(NSInteger) diastolic heartRate:(NSInteger) heartRate;

@end

@interface YuwellBloodPressureBluUtil : JYBleUtil

@end
