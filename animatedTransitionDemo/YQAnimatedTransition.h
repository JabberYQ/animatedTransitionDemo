//
//  YQAnimatedTransition.h
//  animatedTransitionDemo
//
//  Created by 俞琦 on 2017/3/3.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    YQAnimatedTransitionTypePush,
    YQAnimatedTransitionTypePop,
    YQAnimatedTransitionTypePresent,
    YQAnimatedTransitionTypeDismiss
}YQAnimatedTransitionType;

@interface YQAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>
+ (YQAnimatedTransition *)animatedTransitionWithType:(YQAnimatedTransitionType)type;
@end
