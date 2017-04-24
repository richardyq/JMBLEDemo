//
//  FSRKBodyTemperatureBleUtil.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "FSRKBodyTemperatureBleUtil.h"

@interface FSRKBodyTemperatureBleUtil ()
{
    NSTimer* detectingTimer;
    float temperatureValue;
}
@end

@implementation FSRKBodyTemperatureBleUtil

- (void) setupUtil
{
    scanTimeOut = 10;
}

- (BOOL) checkDeviceName:(NSString*) deviceName
{
    if (!deviceName || deviceName.length == 0) {
        return NO;
    }
    
    if ([deviceName isEqualToString:@"FSRKB-EWQ01"])
    {
        return YES;
    }
    return NO;
}

- (BOOL) checkDeviceService:(CBService*) service
{
    if (!service) {
        return NO;
    }
    return [service.UUID isEqual:[CBUUID UUIDWithString:@"1910"]];

}

- (BOOL) checkCharacteristics:(CBCharacteristic*) characteristic
{
    if (!characteristic) {
        return NO;
    }
    
    return [characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]];
}

#pragma mark - 分析返回数据
- (void) paraserResultData:(NSData*) valueData
{
    if (!valueData || valueData.length != 13) {
        return;
    }
    
    id<FSRKBodyTemperatureBleUtilDelegate> fsrkDelegat = (id<FSRKBodyTemperatureBleUtilDelegate>)self.delegate;
    NSData* headerData = [valueData subdataWithRange:NSMakeRange(0, 4)];
    NSString* headerDataString = [headerData hexString];
    
    if (![headerDataString isEqualToString:@"0220DD08"])
    {
        //不是正常体温数据
        return;
    }

    NSData* flagData = [valueData subdataWithRange:NSMakeRange(4, 1)];
    NSString* flagDataString = [flagData hexString];
    
    if (![flagDataString isEqualToString:@"FF"])
    {
        //不是正常体温数据
        
        return;
    }
    
    NSData* tempHData = [valueData subdataWithRange:NSMakeRange(5, 1)];
    NSString* tempHDataString = [tempHData hexString];
    
    if ([tempHDataString isEqualToString:@"EE"])
    {
        NSData* errorData = [valueData subdataWithRange:NSMakeRange(6, 1)];
        NSString* errorDataString = [errorData hexString];
        NSLog(@"errorDataString = %@", errorDataString);
        const char* errorPtr = [errorData bytes];
        int8_t erroCodeInt8 = (int8_t)(*errorPtr);
        NSLog(@"erroCode = %d", erroCodeInt8);
        NSInteger deviceError = (NSInteger)erroCodeInt8;
        //设备出错
        if (fsrkDelegat && [fsrkDelegat respondsToSelector:@selector(temperature:error:)])
        {
            [fsrkDelegat temperature:0 error:deviceError];
        }
        return;
    }
    
    NSData* tempData = [valueData subdataWithRange:NSMakeRange(5, 2)];
    NSString* tempDataString = [tempData hexString];
    NSLog(@"tempDataString %@", tempDataString);
    
    tempData = [tempData reverse];
    int16_t temperatureInt16;
    
    [tempData getBytes: &temperatureInt16 length:sizeof(temperatureInt16)];
    NSLog(@"temperatureInt16 %X, %d", temperatureInt16, temperatureInt16);
    CGFloat tempValue = temperatureInt16;
    tempValue /= 10;
    temperatureValue = tempValue;
    if (!detectingTimer) {

        detectingTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(detectingTimerFunc) userInfo:nil repeats:NO];
    }
}

- (void) detectingTimerFunc
{
    id<FSRKBodyTemperatureBleUtilDelegate> fsrkDelegat = (id<FSRKBodyTemperatureBleUtilDelegate>)self.delegate;
    
    if (fsrkDelegat && [fsrkDelegat respondsToSelector:@selector(temperature:error:)])
    {
        [fsrkDelegat temperature:temperatureValue error:0];
    }

}
@end
