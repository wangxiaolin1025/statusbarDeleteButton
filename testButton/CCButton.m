//
//  CCButton.m
//  testButton
//
//  Created by MDLK-CC on 16/6/30.
//  Copyright © 2016年 MDLK-CC. All rights reserved.
//

#import "CCButton.h"
#import "UIWindow+First.h"

@interface CCButton()

@property (nonatomic , assign) BOOL select;

@property (nonatomic , strong) CALayer *containtLayer;

@property (nonatomic , strong) CATextLayer *title;

@property (nonatomic , assign) CGRect originalFrame;
@end

static NSTimeInterval animationTime = 0.5f;
static CGFloat defaultFontSize = 12.0f;
@implementation CCButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _select = NO;
        CGFloat width = sqrtf(pow(self.bounds.size.height/2, 2)*2);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidClick:)];
        [self addGestureRecognizer:tap];
        self.layer.cornerRadius = self.frame.size.height/2;
        self.clipsToBounds = YES;
        
        CALayer *vertical = [CALayer layer];;
        vertical.backgroundColor = [UIColor blackColor].CGColor;
        vertical.frame = CGRectMake(self.bounds.size.height/2,(self.bounds.size.height - width)/2, 1, width);
        
        CALayer *horizontal = [CALayer layer];;
        horizontal.backgroundColor = [UIColor blackColor].CGColor;
        horizontal.frame = CGRectMake((self.bounds.size.height - width)/2, self.bounds.size.height/2, width, 1);
        
        CALayer *containtLayer = [CALayer layer];
        [containtLayer addSublayer:vertical];
        [containtLayer addSublayer:horizontal];
        containtLayer.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        containtLayer.transform = CATransform3DMakeRotation((M_PI*45)/180, 0, 0, 1);
        self.containtLayer = containtLayer;
        [self.layer addSublayer:containtLayer];
        
        
        CATextLayer *title = [CATextLayer layer];
        title.string = @"清除";
        title.fontSize = defaultFontSize;
        UIFont *systemFont = [UIFont systemFontOfSize:defaultFontSize];
        title.font = (__bridge CFTypeRef _Nullable)([systemFont fontName]);
        title.alignmentMode = kCAAlignmentCenter;
        title.foregroundColor = [UIColor blackColor].CGColor;
        title.opacity = 0;
        [self.layer addSublayer:title];
        self.title = title;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignFirstResponse:) name:leftFirstResponder object:nil];
        
        self.originalFrame = self.frame;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _select = NO;
        CGFloat width = sqrtf(pow(self.bounds.size.height/2, 2)*2);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidClick:)];
        [self addGestureRecognizer:tap];
        self.layer.cornerRadius = self.frame.size.height/2;
        self.clipsToBounds = YES;
        
        CALayer *vertical = [CALayer layer];;
        vertical.backgroundColor = [UIColor blackColor].CGColor;
        vertical.frame = CGRectMake(self.bounds.size.height/2,(self.bounds.size.height - width)/2, 1, width);
        
        CALayer *horizontal = [CALayer layer];;
        horizontal.backgroundColor = [UIColor blackColor].CGColor;
        horizontal.frame = CGRectMake((self.bounds.size.height - width)/2, self.bounds.size.height/2, width, 1);
        
        CALayer *containtLayer = [CALayer layer];
        [containtLayer addSublayer:vertical];
        [containtLayer addSublayer:horizontal];
        containtLayer.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        containtLayer.transform = CATransform3DMakeRotation((M_PI*45)/180, 0, 0, 1);
        self.containtLayer = containtLayer;
        [self.layer addSublayer:containtLayer];
        
        
        CATextLayer *title = [CATextLayer layer];
        title.string = @"清除";
        title.fontSize = defaultFontSize;
        UIFont *systemFont = [UIFont systemFontOfSize:defaultFontSize];
        title.font = (__bridge CFTypeRef _Nullable)([systemFont fontName]);
        title.alignmentMode = kCAAlignmentCenter;
        title.foregroundColor = [UIColor blackColor].CGColor;
        title.opacity = 0;
        [self.layer addSublayer:title];
        self.title = title;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignFirstResponse:) name:leftFirstResponder object:nil];
        
        self.originalFrame = self.frame;
    }
    return self;
}
#pragma set方法
- (void)setNoteString:(NSString *)noteString
{
    _noteString = noteString;
    self.title.string = noteString;
}

- (void)setFontName:(NSString *)fontName
{
    _fontName = fontName;
    self.title.font = (__bridge CFTypeRef _Nullable)(fontName);
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    self.title.fontSize = fontSize;
}

- (void)setWidth:(CGFloat)width
{
    _width = width;
    self.title.frame = CGRectMake(0, 2, width, self.bounds.size.height);
}

#pragma mark - 判断是否点击当前view
- (void)resignFirstResponse:(NSNotification *)note
{
    NSSet<UITouch *> *touches = note.object;
    UITouch *touch = [touches anyObject];
    if (touch.view != self && self.select) {
        [self tapDidClick:NO];
    }
}

- (void)tapDidClick:(BOOL)tapIn
{
    if (self.select) {
        if (self.buttonDidClick && tapIn) {
            self.buttonDidClick();
        }
        [UIView animateWithDuration:animationTime animations:^{
            if (self.style == CCButtonStyleLeftToRight) {
                self.frame = CGRectMake(self.originalFrame.origin.x, self.originalFrame.origin.y, self.originalFrame.size.width, self.originalFrame.size.height);
            }else{
                self.frame = CGRectMake(self.originalFrame.origin.x, self.originalFrame.origin.y, self.originalFrame.size.width, self.originalFrame.size.height);
            }
        }];
    }else{
        [UIView animateWithDuration:animationTime animations:^{
            if (self.style == CCButtonStyleLeftToRight) {
                self.frame = CGRectMake(self.originalFrame.origin.x, self.originalFrame.origin.y, self.width, self.originalFrame.size.height);
            }else{
                self.frame = CGRectMake(self.originalFrame.origin.x - self.width + self.originalFrame.size.width, self.originalFrame.origin.y, self.width, self.originalFrame.size.height);
            }
            
        }];
    }
    [self containtLayerAnimation:self.select];
    [self titleLayerAnimation:self.select];
    self.select = !self.select;
}

- (void)titleLayerAnimation:(BOOL)select
{
    if (!select) {
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        scale.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.25, 1.25, 0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)]];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.fromValue = [NSNumber numberWithFloat:0];
        opacity.toValue = [NSNumber numberWithFloat:1];
        
        CAAnimationGroup *transformGroup = [CAAnimationGroup animation];
        transformGroup.animations = [NSArray arrayWithObjects:scale,opacity, nil];
        transformGroup.duration = animationTime;
        transformGroup.removedOnCompletion = NO;
        transformGroup.fillMode = kCAFillModeForwards;
        [self.title addAnimation:transformGroup forKey:nil];
    }else{
        
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        scale.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)]];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.fromValue = [NSNumber numberWithFloat:1];
        opacity.toValue = [NSNumber numberWithFloat:0];
        
        CAAnimationGroup *transformGroup = [CAAnimationGroup animation];
        transformGroup.animations = [NSArray arrayWithObjects:scale,opacity, nil];
        transformGroup.duration = animationTime;
        transformGroup.removedOnCompletion = NO;
        transformGroup.fillMode = kCAFillModeForwards;
        [self.title addAnimation:transformGroup forKey:nil];
    }
}

- (void)containtLayerAnimation:(BOOL)select
{
    if (!select) {
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform"];
        rotation.fromValue =[NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI*45)/180, 0, 0, 1)];
        rotation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI*(self.style == CCButtonStyleLeftToRight ? 180 : -90))/180, 0, 0, 1)];
        rotation.duration = animationTime;
        
        CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        if (self.style == CCButtonStyleLeftToRight) {
            translation.fromValue = [NSNumber numberWithFloat:0];
            translation.toValue = [NSNumber numberWithFloat:self.width/2];
        }else{
            translation.fromValue = [NSNumber numberWithFloat:0];
            translation.toValue = [NSNumber numberWithFloat:-self.width/4];
        }
        translation.duration = animationTime/2;
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.fromValue = [NSNumber numberWithFloat:1];
        opacity.toValue = [NSNumber numberWithFloat:0];
        
        CAAnimationGroup *transformGroup = [CAAnimationGroup animation];
        transformGroup.animations = [NSArray arrayWithObjects:rotation,translation,opacity, nil];
        transformGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transformGroup.removedOnCompletion = NO;
        transformGroup.fillMode = kCAFillModeForwards;
        [self.containtLayer addAnimation:transformGroup forKey:nil];
    }else{
        CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        rotation.values =
        @[[NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI*(self.style == CCButtonStyleLeftToRight ? 180 : -90))/180, 0, 0, 1)], [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI*(self.style == CCButtonStyleLeftToRight ? 135 : -45))/180, 0, 0, 1)],
          [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI*(self.style == CCButtonStyleLeftToRight ? 90 : 0))/180, 0, 0, 1)],
          [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI*45)/180, 0, 0, 1)]];
        
        CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        if (self.style == CCButtonStyleLeftToRight) {
            translation.fromValue = [NSNumber numberWithFloat:self.width/2];
            translation.toValue = [NSNumber numberWithFloat:0];
        }else{
            translation.fromValue = [NSNumber numberWithFloat:-self.width/4];
            translation.toValue = [NSNumber numberWithFloat:0];
        }
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.fromValue = [NSNumber numberWithFloat:0];
        opacity.toValue = [NSNumber numberWithFloat:1];
        
        CAAnimationGroup *transformGroup = [CAAnimationGroup animation];
        transformGroup.animations = [NSArray arrayWithObjects:rotation,translation,opacity,nil];
        transformGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        transformGroup.duration = animationTime;
        transformGroup.removedOnCompletion = NO;
        transformGroup.fillMode=kCAFillModeForwards;
        [self.containtLayer addAnimation:transformGroup forKey:nil];
    }
}

@end
