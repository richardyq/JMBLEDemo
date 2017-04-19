//
//  JYBleUtilDelegate.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleUtilStatus.h"

@protocol JYBleUtilDelegate <NSObject>

- (void) blueToothStatus:(BleStatus) status;

@optional
#pragma mark - 扫描设备
- (void) bleStartScanning;
- (void) bleDeviceScanned;  //指定设备已经被扫描到
- (void) bleDeviceScanTimeOut;  //扫描超时，没有找到指定设备

#pragma mark - 连接设备
- (void) bleConnectSuccess;     //设备connect成功
- (void) bleConnectFailed;      //设备connect失败
- (void) bleDisConnected;       //设备连接断开

#pragma mark - 发现Service
- (void) bleDiscoveryServiceFailed; //发现服务失败
- (void) bleServiceDiscoveried;  //发现指定服务
- (void) bleServiceNotFound;    //没能找到指定服务

#pragma mark - 发现Characteristics
- (void) bleDiscoveryCharacteristicsFailed; //发现特征值失败
- (void) bleCharacteristicsDiscoveried;  //发现指定特征值
- (void) bleCharacteristicsNotFound;    //没能找到指定特征值
@end
