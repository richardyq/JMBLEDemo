//
//  UIViewController+AlertExtension.h
//  JYHMUser
//
//  Created by yinquan on 16/10/21.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertExtension)

- (void) showAlertMessage:(NSString*) message;
- (void) showAlertMessage:(NSString*) message handler:(void (^ __nullable)(UIAlertAction *action))handler;

@end


