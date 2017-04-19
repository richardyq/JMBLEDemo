//
//  BloodPressureRetModel.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/19.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BloodPressureRetModel : NSObject

@property (nonatomic, assign) NSInteger systolic;   //收缩压
@property (nonatomic, assign) NSInteger diastolic;   //舒张压
@property (nonatomic, assign) NSInteger heartRate;   //心率

@end
