//
//  HoltekBodyWeightViewController.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "HoltekBodyWeightViewController.h"
#import "HoltekBodyWeightBleUtil.h"

@interface HoltekBodyWeightViewController ()
<HoltekBodyWeightBleUtilDelegate>

@end

@implementation HoltekBodyWeightViewController
@synthesize bleUtil = _bleUtil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"Holtek体重计"];
    _bleUtil = [[HoltekBodyWeightBleUtil alloc]initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HoltekBodyWeightBleUtilDelegate
- (void) bleDisConnected       //设备连接断开
{
    [self.statusLable setText:@"监测设备连接断开"];
    //开始扫描设备
    [self.bleUtil startScanDevice];
}

- (void) bodyWeight:(float) weight
{
    
}

@end
