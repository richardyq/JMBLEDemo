//
//  UIViewController+AlertExtension.m
//  JYHMUser
//
//  Created by yinquan on 16/10/21.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import "UIViewController+AlertExtension.h"

@implementation UIViewController (AlertExtension)

- (void) showAlertMessage:(NSString*) message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) showAlertMessage:(NSString*) message handler:(void (^ __nullable)(UIAlertAction *action))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:handler]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end




