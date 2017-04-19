//
//  JYBleUtil.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYBleUtil.h"


@interface JYBleUtil ()
<CBCentralManagerDelegate, CBPeripheralDelegate>
{
    CBCentralManager* manager;      //中心设备
    CBPeripheral*   connectedPeripheral;
    
    NSTimer* scanTimer;
}

@end

@implementation JYBleUtil

- (void) dealloc
{
    if (manager && manager.isScanning) {
        [manager stopScan];
    }
    if (manager && connectedPeripheral)
    {
        [manager cancelPeripheralConnection:connectedPeripheral];
    }
    
    if (scanTimer)
    {
        [scanTimer invalidate];
        scanTimer = nil;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUtil];
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}


- (id) initWithDelegate:(id<JYBleUtilDelegate>) delegate
{
    self = [super init];
    if (self) {
        [self setupUtil];
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        _delegate = delegate;
    }
    return self;
}

- (BOOL) isScanning
{
    if (!manager) {
        return NO;
    }
    
    return manager.isScanning;
}

- (void) setupUtil
{
    //需要子类中实现
}

- (void) startScanDevice
{
    if (manager.isScanning)
    {
        //如果正在扫描，返回
        return;
    }
    if (scanTimeOut > 0)
    {
        //启动定时器
        if (scanTimer)
        {
            [scanTimer invalidate];
        }
        
        scanTimer = [NSTimer scheduledTimerWithTimeInterval:scanTimeOut target:self selector:@selector(scanerTimeOut) userInfo:nil repeats:NO];
    }
    
    //开始扫描
    if (_delegate && [_delegate respondsToSelector:@selector(bleStartScanning)]) {
        [_delegate bleStartScanning];
    }
    [manager scanForPeripheralsWithServices:nil options:nil];
    
}

- (void) scanerTimeOut
{
    [scanTimer invalidate];
    scanTimer = nil;
    
    [self stopScanDevice];
    
    if (_delegate && [_delegate respondsToSelector:@selector(bleDeviceScanTimeOut)])
    {
        [_delegate bleDeviceScanTimeOut];
    }
}

- (void) stopScanDevice
{
    [manager stopScan];
}

- (BOOL) checkDeviceName:(NSString*) deviceName
{
    return NO;
}

- (BOOL) checkDeviceService:(CBService*) service
{
    return NO;
}

- (BOOL) checkCharacteristics:(CBCharacteristic*) service
{
    return NO;
}

- (void) startEnumDeviceServices:(CBPeripheral*) peripheral
{
    if (!peripheral ) {
        return;
    }
    
    
    __block CBService* specifyService;
    __weak typeof(self) weakSelf = self;
    if (peripheral.services) {
        [peripheral.services enumerateObjectsUsingBlock:^(CBService* service, NSUInteger idx, BOOL * _Nonnull stop)
         {
             if ([weakSelf checkDeviceService:service]) {
                 specifyService = service;
                 *stop = YES;
             }
             
         }];
    }
    
    if (specifyService)
    {
        //发现指定的Service
        if (_delegate && [_delegate respondsToSelector:@selector(bleServiceDiscoveried)])
        {
            [_delegate bleServiceDiscoveried];
        }
        //发现设备特征
        [peripheral discoverCharacteristics:nil forService:specifyService];
    }
    else
    {
        //没能发现指定服务
        if (_delegate && [_delegate respondsToSelector:@selector(bleServiceNotFound)])
        {
            [_delegate bleServiceNotFound];
        }
        //断开蓝牙连接
        [manager cancelPeripheralConnection:peripheral];
        connectedPeripheral = nil;
    }
}

- (void) startEnumCharacteristics:(CBService *)service
{
    if (!service)
    {
        return;
    }
    
    __block CBCharacteristic* specifyCharateristic;
    __weak typeof(self) weakSelf = self;
    [service.characteristics enumerateObjectsUsingBlock:^(CBCharacteristic * characteristic, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([weakSelf checkCharacteristics:characteristic]) {
            specifyCharateristic = characteristic;
//            *stop = YES;
            [connectedPeripheral setNotifyValue:YES forCharacteristic:specifyCharateristic];
            [connectedPeripheral readValueForCharacteristic:specifyCharateristic];

        }
    }];
    
    if (specifyCharateristic)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(bleCharacteristicsDiscoveried)])
        {
            [_delegate bleCharacteristicsDiscoveried];
        }
        
            }
    else
    {
        //没能发现指定特征值
        if (_delegate && [_delegate respondsToSelector:@selector(bleCharacteristicsNotFound)])
        {
            [_delegate bleCharacteristicsNotFound];
        }
        //断开蓝牙连接
        [manager cancelPeripheralConnection:connectedPeripheral];
        connectedPeripheral = nil;
    }
}



#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    
    switch (central.state)
    {
        case CBManagerStatePoweredOn:
        {
            NSLog(@"手机蓝牙已开启。");
            _bleStatus = BlueToothStatus_PowerON;
        }
            break;
            
        case CBManagerStatePoweredOff:
        {
            NSLog(@"手机尚未开启。");
            _bleStatus = BlueToothStatus_PowerOff;
            
        }
            break;
            
        default:
            break;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(blueToothStatus:)])
    {
        [_delegate blueToothStatus:self.bleStatus];
    }
    
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"didDiscoverPeripheral");
    NSLog(@"peripheral name: %@", peripheral.name);
    
    if (!peripheral.name || peripheral.name.length == 0) {
        return;
    }
    //TODO:通过校验设备名，判断是否扫描到已选的设备
    if ([self checkDeviceName:peripheral.name])
    {
        //停止扫描
        [self stopScanDevice];
        
        connectedPeripheral = peripheral;
        
        if (_delegate && [_delegate respondsToSelector:@selector(bleDeviceScanned)])
        {
            [_delegate bleDeviceScanned];
        }
        
        //开始设备连接过程
        connectedPeripheral = peripheral;
        [manager connectPeripheral:connectedPeripheral options:nil];
    }
}


-  (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //设备连接成功
    peripheral.delegate = self;
    if (_delegate && [_delegate respondsToSelector:@selector(bleDeviceScanned)])
    {
        [_delegate bleConnectSuccess];
    }
    
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    //设备连接失败
    if (_delegate && [_delegate respondsToSelector:@selector(bleDeviceScanned)])
    {
        [_delegate bleConnectFailed];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    //设备连接断开
    if (_delegate && [_delegate respondsToSelector:@selector(bleDeviceScanned)])
    {
        [_delegate bleDisConnected];
    }
}

#pragma mark - DiscoverServices
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(bleDiscoveryServiceFailed)])
        {
            [_delegate bleDiscoveryServiceFailed];
        }
        
        [manager cancelPeripheralConnection:peripheral];
        connectedPeripheral = nil;
        return;
    }
    [self startEnumDeviceServices:peripheral];
}



#pragma mark - DiscoveryCharacteristics
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(bleDiscoveryCharacteristicsFailed)])
        {
            [_delegate bleDiscoveryCharacteristicsFailed];
        }
        
        [manager cancelPeripheralConnection:peripheral];
        connectedPeripheral = nil;
        return;
        return;
    }
    
    [self startEnumCharacteristics:service];
}


//当设备有数据返回时，系统调用这个方法
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (![self checkCharacteristics:characteristic])
    {
        return;
    }
    
    NSData *valueData = characteristic.value;
    if (valueData && valueData.length > 0) {
        //处理蓝牙设备返回的数据
        [self paraserResultData:valueData];
    }
}

- (void) paraserResultData:(NSData*) data
{
    
}

@end
