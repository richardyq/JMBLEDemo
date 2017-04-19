//
//  BloodPressureDetectingView.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/19.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "BloodPressureDetectingView.h"

@interface BloodPressureDetectingView ()

@property (nonatomic, readonly) UILabel* pressureLable;
@end

@implementation BloodPressureDetectingView

@synthesize pressureLable = _pressureLable;

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [self.pressureLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.bottom.equalTo(self);
    }];
}

- (void) setDetectPressure:(NSInteger) pressure
{
    [self.pressureLable setText:[NSString stringWithFormat:@"%ld", pressure]];
}

#pragma mark - settingAndGetting
- (UILabel*) pressureLable
{
    if (!_pressureLable)
    {
        _pressureLable = [[UILabel alloc] init];
        [self addSubview:_pressureLable];
        
        [_pressureLable setFont:[UIFont systemFontOfSize:36]];
        [_pressureLable setTextColor:[UIColor blackColor]];
    }
    
    return _pressureLable;
}

@end
