//
//  JYBleUtil.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <CoreBluetooth/CoreBluetooth.h>
#import "BleUtilStatus.h"
#import "JYBleUtilDelegate.h"
#import "NSData+HexString.h"

@interface JYBleUtil : NSObject
{
    NSInteger scanTimeOut;      //扫描超时时间，0 － 没有超时限制
}

@property (nonatomic, readonly) BleStatus bleStatus;
@property (nonatomic, weak) id<JYBleUtilDelegate> delegate;
@property (nonatomic, readonly) BOOL isScanning;

- (id) initWithDelegate:(id<JYBleUtilDelegate>) delegate;

/*
 startScanDevice
 开始扫描蓝牙监测设备
 */
- (void) startScanDevice;

/*
 stopScanDevice
 停止扫描蓝牙监测设备
 */
- (void) stopScanDevice;

@end
