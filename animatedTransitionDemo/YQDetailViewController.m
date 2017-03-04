//
//  YQDetailViewController.m
//  animatedTransitionDemo
//
//  Created by 俞琦 on 2017/3/3.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "YQDetailViewController.h"

@interface YQDetailViewController ()

@end

@implementation YQDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"详细页面";
    self.view.backgroundColor = [UIColor greenColor];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width);
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld", self.selectRow%3]];
    [self.view addSubview:imageView];
}

@end
