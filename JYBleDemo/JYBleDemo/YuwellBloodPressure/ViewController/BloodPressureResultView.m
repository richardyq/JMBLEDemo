//
//  BloodPressureResultView.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/19.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "BloodPressureResultView.h"

@interface BloodPressureResultView ()

@property (nonatomic, readonly) UILabel* systolicTitleLable;
@property (nonatomic, readonly) UILabel* systolicLable;

@property (nonatomic, readonly) UILabel* diastolicTitleLable;
@property (nonatomic, readonly) UILabel* diastolicLable;

@property (nonatomic, readonly) UILabel* heartrateTitleLable;
@property (nonatomic, readonly) UILabel* heartrateLable;

@end

@implementation BloodPressureResultView

@synthesize systolicTitleLable = _systolicTitleLable;
@synthesize systolicLable = _systolicLable;

@synthesize diastolicTitleLable = _diastolicTitleLable;
@synthesize diastolicLable = _diastolicLable;

@synthesize heartrateTitleLable = _heartrateTitleLable;
@synthesize heartrateLable = _heartrateLable;

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [self.systolicLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).with.offset(95);
    }];
    
    [self.systolicTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.systolicLable);
        make.left.equalTo(self);
    }];
    
    [self.diastolicLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.systolicLable.mas_bottom).with.offset(30);
        make.left.equalTo(self).with.offset(95);
    }];
    
    [self.diastolicTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.diastolicLable);
        make.left.equalTo(self);
    }];
    
    [self.heartrateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.diastolicLable.mas_bottom).with.offset(30);
        make.left.equalTo(self).with.offset(95);
        make.bottom.equalTo(self);
    }];
    
    [self.heartrateTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.heartrateLable);
        make.left.equalTo(self);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) systolicTitleLable
{
    if (!_systolicTitleLable)
    {
        _systolicTitleLable = [[UILabel alloc]init];
        [self addSubview:_systolicTitleLable];
        
        [_systolicTitleLable setTextColor:[UIColor grayColor]];
        [_systolicTitleLable setFont:[UIFont systemFontOfSize:14]];
        [_systolicTitleLable setText:@"收缩压"];
    }
    return _systolicTitleLable;
}

- (UILabel*) systolicLable
{
    if (!_systolicLable)
    {
        _systolicLable = [[UILabel alloc]init];
        [self addSubview:_systolicLable];
        
        [_systolicLable setTextColor:[UIColor blackColor]];
        [_systolicLable setFont:[UIFont systemFontOfSize:34]];
    }
    return _systolicLable;
}

- (UILabel*) diastolicTitleLable
{
    if (!_diastolicTitleLable)
    {
        _diastolicTitleLable = [[UILabel alloc]init];
        [self addSubview:_diastolicTitleLable];
        
        [_diastolicTitleLable setTextColor:[UIColor grayColor]];
        [_diastolicTitleLable setFont:[UIFont systemFontOfSize:14]];
        [_diastolicTitleLable setText:@"舒张压"];
    }
    return _diastolicTitleLable;
}

- (UILabel*) diastolicLable
{
    if (!_diastolicLable)
    {
        _diastolicLable = [[UILabel alloc]init];
        [self addSubview:_diastolicLable];
        
        [_diastolicLable setTextColor:[UIColor blackColor]];
        [_diastolicLable setFont:[UIFont systemFontOfSize:34]];
    }
    return _diastolicLable;
}

- (UILabel*) heartrateTitleLable
{
    if (!_heartrateTitleLable)
    {
        _heartrateTitleLable = [[UILabel alloc]init];
        [self addSubview:_heartrateTitleLable];
        
        [_heartrateTitleLable setTextColor:[UIColor grayColor]];
        [_heartrateTitleLable setFont:[UIFont systemFontOfSize:14]];
        [_heartrateTitleLable setText:@"心率"];
    }
    return _heartrateTitleLable;
}

- (UILabel*) heartrateLable
{
    if (!_heartrateLable)
    {
        _heartrateLable = [[UILabel alloc]init];
        [self addSubview:_heartrateLable];
        
        [_heartrateLable setTextColor:[UIColor grayColor]];
        [_heartrateLable setFont:[UIFont systemFontOfSize:34]];
    }
    return _heartrateLable;
}

- (void) setBloodPressureDetectResult:(NSInteger) systolic diastolic:(NSInteger) diastolic heartRate:(NSInteger) heartRate
{
    [self.systolicLable setText:[NSString stringWithFormat:@"%ld", systolic]];
    [self.diastolicLable setText:[NSString stringWithFormat:@"%ld", diastolic]];
    [self.heartrateLable setText:[NSString stringWithFormat:@"%ld", heartRate]];
}
@end
