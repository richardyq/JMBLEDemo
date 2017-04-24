//
//  NSData+HexString.h
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HexString)

- (NSString *) hexString;

- (NSData*) reverse;    //反序

@end
