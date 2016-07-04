//
//  CCButton.h
//  testButton
//
//  Created by MDLK-CC on 16/6/30.
//  Copyright © 2016年 MDLK-CC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CCButtonStyle) {
    CCButtonStyleLeftToRight = 0,//由左向右
    CCButtonStyleRightToLeft,//由右向左
};

IB_DESIGNABLE
@interface CCButton : UIView
/**
 *  提示文字
 */
@property (copy , nonatomic) IBInspectable NSString *noteString;

/**
 *  提示文字字体大小
 */
@property (assign , nonatomic) IBInspectable  CGFloat fontSize;

/**
 *  提示文字字体名称
 */
@property (copy , nonatomic) IBInspectable  NSString *fontName;

/**
 *  button的样式
 */
@property (assign , nonatomic) IBInspectable CCButtonStyle style;

/**
 *  button展开的宽度
 */
@property (assign , nonatomic) IBInspectable CGFloat width;

/**
 *  点击回调
 */
@property (copy , nonatomic) void(^buttonDidClick)(void);
@end
