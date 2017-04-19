//
//  YuwellBloodPressureViewController.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/19.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "YuwellBloodPressureViewController.h"
#import "YuwellBloodPressureBluUtil.h"
#import "BloodPressureDetectingView.h"
#import "BloodPressureResultView.h"

@interface YuwellBloodPressureViewController ()
<YuwellBloodPressureBluUtilDelegate>
{
    UIView* detectResultView;
}
@end

@implementation YuwellBloodPressureViewController

@synthesize bleUtil = _bleUtil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"鱼跃血压计"];
    
    _bleUtil = [[YuwellBloodPressureBluUtil alloc]initWithDelegate:self];
    
    detectResultView = [[BloodPressureResultView alloc] init];
    [self.view addSubview:detectResultView];
    
    [detectResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(66);
        make.width.mas_equalTo(@240);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_bleUtil && _bleUtil.bleStatus == BlueToothStatus_PowerOff) {
        [_bleUtil startScanDevice];
    }
    
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_bleUtil && _bleUtil.isScanning) {
        [_bleUtil stopScanDevice];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - YuwellBloodPressureBluUtilDelegate
- (void) detectingPressure:(NSInteger) pressure
{
    if (detectResultView && ![detectResultView isKindOfClass:[BloodPressureDetectingView class]])
    {
        [detectResultView removeFromSuperview];
        detectResultView = nil;
    }
    if (!detectResultView)
    {
        detectResultView = [[BloodPressureDetectingView alloc] init];
        [self.view addSubview:detectResultView];
        
        [detectResultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(66);
        }];
    }
    
    BloodPressureDetectingView* detectingView = (BloodPressureDetectingView*)detectResultView;
    [detectingView setDetectPressure:pressure];
}

- (void) detectedsystolic:(NSInteger) systolic diastolic:(NSInteger) diastolic heartRate:(NSInteger) heartRate
{
    if (detectResultView && ![detectResultView isKindOfClass:[BloodPressureResultView class]])
    {
        [detectResultView removeFromSuperview];
        detectResultView = nil;
    }
    
    if (!detectResultView)
    {
        detectResultView = [[BloodPressureResultView alloc] init];
        [self.view addSubview:detectResultView];
        
        [detectResultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(66);
            make.width.mas_equalTo(@240);
        }];
    }
    
    BloodPressureResultView* resultView = (BloodPressureResultView*)detectResultView;
    [resultView setBloodPressureDetectResult:systolic diastolic:diastolic heartRate:heartRate];
}
@end
