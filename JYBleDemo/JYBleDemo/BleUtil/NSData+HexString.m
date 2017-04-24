//
//  NSData+HexString.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "NSData+HexString.h"

@interface ByteHexString : NSObject

+ (NSString *) parseByte2HexString:(NSData *) data;
+ (NSData *) dataFromHexString:(NSString *)hexString;

@end

@implementation ByteHexString

+(NSString *) parseByte2HexString:(NSData *) data

{
    Byte* bytes = (Byte*)[ data bytes];
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    
    int i = 0;
    
    if(bytes)
    {
        //while (bytes[i] != '\0')
        for (int index = 0; index < [data length]; ++index)
        {
            NSString *hexByte = [NSString stringWithFormat:@"%X",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
            {
                [hexStr appendFormat:@"0%@", hexByte];
            }
            else
            {
                [hexStr appendFormat:@"%@", hexByte];
                
            }
            i++;
        }
        
    }
    
    return hexStr;
    
}


+ (NSData *) dataFromHexString:(NSString *)hexString
{ //
    
    int bufLen = (int)[hexString length] / 2 ;
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSData* dataRet = [NSData dataWithBytes:myBuffer length:bufLen];
    free(myBuffer);
    return dataRet;
}

@end


@implementation NSData (HexString)

- (NSString *) hexString
{
    NSString* hexString = [ByteHexString parseByte2HexString:self];
    return hexString;
}

- (NSData*) reverse
{
    NSData* data = nil;
    if (self.length == 0)
    {
        return data;
    }
    
    const char* bytes = [self bytes];
    Byte* reverseBytes = alloca(self.length);
    for (NSInteger index = 0; index < self.length; ++index)
    {
        reverseBytes[self.length - index - 1] = bytes[index];
    }
    
    data = [NSData dataWithBytes:reverseBytes length:self.length];
    return data;
}
@end
