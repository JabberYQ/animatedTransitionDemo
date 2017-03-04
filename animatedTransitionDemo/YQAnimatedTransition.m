//
//  YQAnimatedTransition.m
//  animatedTransitionDemo
//
//  Created by 俞琦 on 2017/3/3.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "YQAnimatedTransition.h"

@interface YQAnimatedTransition()
@property (nonatomic, assign) YQAnimatedTransitionType type;
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation YQAnimatedTransition

+ (YQAnimatedTransition *)animatedTransitionWithType:(YQAnimatedTransitionType)type
{
    YQAnimatedTransition *animatedTransition = [[YQAnimatedTransition alloc] init];
    animatedTransition.type = type;
    return animatedTransition;
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    if (self.type == YQAnimatedTransitionTypePush) {
        
        // 获得即将消失的vc的v
        UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        // 获得即将出现的vc的v
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        // 获得容器view
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:fromeView];
        [containerView addSubview:toView];
        
        UIBezierPath *startBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((containerView.frame.size.width-100)/2, 100, 100, 100)];
        CGFloat radius = 1000;
        UIBezierPath *finalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(150 - radius, 150 -radius, radius*2, radius*2)];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = finalBP.CGPath;
        toView.layer.mask = maskLayer;
        
        //执行动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id _Nullable)(startBP.CGPath);
        animation.toValue = (__bridge id _Nullable)(finalBP.CGPath);
        animation.duration = [self transitionDuration:transitionContext];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.delegate = self;
        [maskLayer addAnimation:animation forKey:@"path"];
        
    } else if (self.type == YQAnimatedTransitionTypePresent) {
        UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:fromeView];
        [containerView addSubview:toView];
        
        fromeView.frame = containerView.frame;
        toView.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromeView.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
            toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else if (self.type == YQAnimatedTransitionTypeDismiss) {
        UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:fromeView];
        [containerView addSubview:toView];
        
        fromeView.frame = containerView.frame;
        toView.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromeView.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
            toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //告诉系统转场动画完成
    [self.transitionContext completeTransition:YES];
    //清除相应控制器视图的mask
    [self.transitionContext viewForKey:UITransitionContextFromViewKey].layer.mask = nil;
    [self.transitionContext viewForKey:UITransitionContextToViewKey].layer.mask = nil;
}
@end
