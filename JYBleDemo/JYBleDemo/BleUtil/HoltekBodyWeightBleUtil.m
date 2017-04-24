//
//  HoltekBodyWeightBleUtil.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "HoltekBodyWeightBleUtil.h"

@interface HoltekBodyWeightBleUtil ()
{
    NSString* serialNumberString;   //接收到的数据序列号
}
@end

@implementation HoltekBodyWeightBleUtil

- (BOOL) checkDeviceName:(NSString*) deviceName
{
    if (!deviceName || deviceName.length == 0) {
        return NO;
    }
    
    if ([deviceName isEqualToString:@"000FatScale01"])
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
    return [service.UUID isEqual:[CBUUID UUIDWithString:@"FFF0"]];
}

- (BOOL) checkCharacteristics:(CBCharacteristic*) characteristic
{
    if (!characteristic) {
        return NO;
    }
    
    return [characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]];
    
}

#pragma mark - 分析返回数据
- (void) paraserResultData:(NSData*) valueData
{
    if (!valueData || valueData.length == 13) {
        return;
    }
    
    NSData* typeData = [valueData subdataWithRange:NSMakeRange(1, 1)];
    NSString* typeString = [typeData hexString];
    if (!typeString || ![typeString isEqualToString:@"DD"])
    {
        return;
    }
    
    NSData* snData = [valueData subdataWithRange:NSMakeRange(10, 1)];
    NSString* snString = [snData hexString];
    
    if (serialNumberString && [snString isEqualToString:serialNumberString])
    {
        //重复数据，不予理会
        return;
    }
    
    if (!serialNumberString)
    {
        serialNumberString = snString;
    }
    
    //解析单位和体重
    NSData* unitAndWeightData = [valueData subdataWithRange:NSMakeRange(2, 2)];
    BytePtr unitBytePtr = (BytePtr)[unitAndWeightData bytes];
    Byte unitByte = unitBytePtr[0] >> 6;
    
    NSString* unitString = @"";
    switch (unitByte) {
        case 0:
        {
            //Kg
            unitString = @"Kg";
            
        }
            break;
        case 2:
        {
            //LB
            unitString = @"LB";
            break;
        }
        case 3:
        {
            //ST
            unitString = @"ST";
            break;
        }
        default:
            break;
    }
    
    NSLog(@"unitString = %@", unitString);
    unitBytePtr[0] &= 0x3F;
    
    int weightValueInt16;
    NSData* weightData = [NSData dataWithBytes:unitBytePtr length:2];
    
    weightData = [weightData reverse];
    [weightData getBytes: &weightValueInt16 length:sizeof(weightValueInt16)];
    float weightValue = (float)weightValueInt16 / 10;
    
    id<HoltekBodyWeightBleUtilDelegate> holtekDelegate = (id<HoltekBodyWeightBleUtilDelegate>)self.delegate;
    if (holtekDelegate && [holtekDelegate respondsToSelector:@selector(bodyWeight:unit:)]) {
        [holtekDelegate bodyWeight:weightValue unit:unitString];
    }
}
@end
