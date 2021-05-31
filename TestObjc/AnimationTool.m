//
//  AnimationTool.m
//  TestObjc
//
//  Created by 臻尚 on 2021/4/29.
//

#import "AnimationTool.h"

@interface AnimationTool ()

@end

@implementation AnimationTool

// 漂浮动画
+ (void)floatAnimationWithView:(UIView *)view
{
    //设置x轴方向的缩放动画
    CAKeyframeAnimation *xScaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    xScaleAnimation.values = @[@1, @0.9, @1, @1.1, @0.9, @1];
    xScaleAnimation.duration = 3.f;
    xScaleAnimation.repeatCount = CGFLOAT_MAX;
    xScaleAnimation.removedOnCompletion = NO;
    xScaleAnimation.fillMode = kCAFillModeForwards;
    
    //设置y轴方向的缩放动画
    CAKeyframeAnimation *yScaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    yScaleAnimation.values = @[@0.9, @1, @1.1, @0.8, @1, @0.9];
    yScaleAnimation.duration = 3.f;
    yScaleAnimation.repeatCount = CGFLOAT_MAX;
    yScaleAnimation.removedOnCompletion = NO;
    yScaleAnimation.fillMode = kCAFillModeForwards;
    
    //设置x轴方向的移动动画
    CAKeyframeAnimation *xTranslationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    xTranslationAnimation.values = @[@0, @5, @(-5), @0, @5, @0];
    xTranslationAnimation.duration = 3.f;
    xTranslationAnimation.repeatCount = CGFLOAT_MAX;
    xTranslationAnimation.removedOnCompletion = NO;
    xTranslationAnimation.fillMode = kCAFillModeForwards;
    
    //设置y轴方向的移动动画
    CAKeyframeAnimation *yTranslationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    yTranslationAnimation.values = @[@0, @5, @1, @-5, @0];
    yTranslationAnimation.duration = 3.f;
    yTranslationAnimation.repeatCount = CGFLOAT_MAX;
    yTranslationAnimation.removedOnCompletion = NO;
    yTranslationAnimation.fillMode = kCAFillModeForwards;
    
    //组动画
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    //将所有动画添加到动画组
    groupAnimation.animations = @[xScaleAnimation, yScaleAnimation, xTranslationAnimation, yTranslationAnimation];
    groupAnimation.duration = 3.f;
    groupAnimation.repeatCount = CGFLOAT_MAX;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

@end
