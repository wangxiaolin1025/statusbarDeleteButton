//
//  UIWindow+First.m
//  testButton
//
//  Created by 陈程 on 16/6/30.
//  Copyright © 2016年 MDLK-CC. All rights reserved.
//

#import "UIWindow+First.h"

NSString *const leftFirstResponder = @"leftFirstResponder";

@implementation UIWindow (First)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [[NSNotificationCenter defaultCenter] postNotificationName:leftFirstResponder object:touches];
}

@end
