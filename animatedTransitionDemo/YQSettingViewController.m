//
//  YQSettingViewController.m
//  animatedTransitionDemo
//
//  Created by 俞琦 on 2017/3/3.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "YQSettingViewController.h"
#import "YQAnimatedTransition.h"

@interface YQSettingViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation YQSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.transitioningDelegate = self;
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [YQAnimatedTransition animatedTransitionWithType:YQAnimatedTransitionTypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [YQAnimatedTransition animatedTransitionWithType:YQAnimatedTransitionTypeDismiss];
}

@end
