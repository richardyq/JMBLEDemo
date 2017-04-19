//
//  FSRKBodyTemperatureViewController.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "FSRKBodyTemperatureViewController.h"
#import "FSRKBodyTemperatureBleUtil.h"

@interface FSRKBodyTemperatureViewController ()
<FSRKBodyTemperatureBleUtilDelegate>
{
    FSRKBodyTemperatureBleUtil* bleUtil;
}

@property (nonatomic, readonly) UILabel* statusLable;
@property (nonatomic, readonly) UILabel* temperatureLable;

@end

@implementation FSRKBodyTemperatureViewController

@synthesize statusLable = _statusLable;
@synthesize temperatureLable = _temperatureLable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"飞斯瑞克体温计"];
    
    bleUtil = [[FSRKBodyTemperatureBleUtil alloc]initWithDelegate:self];
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
    
    [self.temperatureLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(69);
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

- (UILabel*) temperatureLable
{
    if (!_temperatureLable)
    {
        _temperatureLable = [[UILabel alloc] init];
        [self.view addSubview:_temperatureLable];
        
        [_temperatureLable setTextColor:[UIColor blackColor]];
        [_temperatureLable setFont:[UIFont systemFontOfSize:32]];
    }
    return _temperatureLable;
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
            [bleUtil startScanDevice];
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

- (NSString*) temperatureErrorString:(NSInteger) errorCode
{
    NSString* temperatureErrorString = nil;
    if (errorCode > 0)
    {
        //设备监测出错
        switch (errorCode)
        {
            case 1:
            {
                temperatureErrorString = @"体温过低，请检查测量方式是否正确，或请立即就医";
                break;
            }
            case 2:
            {
                temperatureErrorString = @"体温过高，请检查测量方式是否正确，或请立即就医";
                break;
            }
            case 3:
            {
                temperatureErrorString = @"环境温度过低，请稍后重试。";
                break;
            }
            case 4:
            {
                temperatureErrorString = @"环境温度过高，请稍后重试。";
                break;
            }
            case 5:
            {
                temperatureErrorString = @"设备电压过低，请更换电池后再试。";
                break;
            }
            case 6:
            {
                temperatureErrorString = @"测量错误，请重试。";
                break;
            }
            default:
                break;
        }

    }

    return temperatureErrorString;
}

- (void) temperature:(CGFloat) temperature error:(NSInteger) errorCode
{
    if (errorCode > 0)
    {
        NSString* temperatureErrorString = [self temperatureErrorString:errorCode];
         __weak typeof(self) weakSelf = self;
        [self showAlertMessage:temperatureErrorString handler:^(UIAlertAction *action) {
            if (weakSelf)
            {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
        [self.temperatureLable setText:@"0.0"];
        return;
    }
    
    [self.temperatureLable setText:[NSString stringWithFormat:@"%.1f", temperature]];
}
@end
