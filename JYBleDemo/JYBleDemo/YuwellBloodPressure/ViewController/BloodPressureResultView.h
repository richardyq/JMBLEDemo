//
//  BloodPressureResultView.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/19.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BloodPressureResultView : UIView

- (void) setBloodPressureDetectResult:(NSInteger) systolic diastolic:(NSInteger) diastolic heartRate:(NSInteger) heartRate;
@end
