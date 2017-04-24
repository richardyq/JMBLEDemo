//
//  BleDetectViewController.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/19.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "BleDetectViewController.h"


@interface BleDetectViewController ()



@end

@implementation BleDetectViewController

@synthesize statusLable = _statusLable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-44);
    }];
    
    
}

#pragma mark - settingAndGetting
- (UILabel*) statusLable
{
    if (!_statusLable) {
        _statusLable = [[UILabel alloc] init];
        [self.view addSubview:_statusLable];
        
        [_statusLable setTextColor:[UIColor blackColor]];
        [_statusLable setFont:[UIFont systemFontOfSize:12]];
    }
    
    return _statusLable;
}

#pragma mark - FSRKBodyTemperatureBleUtilDelegate

- (void) blueToothStatus:(BleStatus) status
{
    switch (status)
    {
        case BlueToothStatus_PowerOff:
        {
            [self.statusLable setText:@"手机蓝牙没有开启，请开启手机的蓝牙。"];
            break;
        }
        case BlueToothStatus_PowerON:
        {
            [self.statusLable setText:@"手机蓝牙已开启，正在连接监测设备。"];
            [self.bleUtil startScanDevice];
            break;
        }
        default:
            break;
    }
}

- (void) bleStartScanning
{
    [self.statusLable setText:@"正在扫描设备。"];
}

- (void) bleDeviceScanTimeOut
{
    [self.statusLable setText:@"扫描设备超时，没能找到指定的监测设备。"];
}

- (void) bleConnectSuccess     //设备connect成功
{
    [self.statusLable setText:@"监测设备connect成功"];
}

- (void) bleConnectFailed      //设备connect失败
{
    [self.statusLable setText:@"监测设备connect失败"];
}

- (void) bleDisConnected       //设备连接断开
{
    [self.statusLable setText:@"监测设备连接断开"];
}

- (void) bleDiscoveryServiceFailed
{
    [self.statusLable setText:@"发现指定服务失败"];
}

- (void) bleServiceDiscoveried  //发现指定服务
{
    [self.statusLable setText:@"发现指定服务"];
}
- (void) bleServiceNotFound    //没能找到指定服务
{
    [self.statusLable setText:@"没能找到指定服务"];
}

- (void) bleDiscoveryCharacteristicsFailed //发现特征值失败
{
    [self.statusLable setText:@"发现特征值失败"];
}
- (void) bleCharacteristicsDiscoveried  //发现指定特征值
{
    [self.statusLable setText:@"发现指定特征值"];
}
- (void) bleCharacteristicsNotFound    //没能找到指定特征值
{
    [self.statusLable setText:@"没能找到指定特征值"];
}


@end
