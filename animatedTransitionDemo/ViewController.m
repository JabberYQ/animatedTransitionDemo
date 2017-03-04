//
//  ViewController.m
//  animatedTransitionDemo
//
//  Created by 俞琦 on 2017/3/3.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "ViewController.h"
#import "YQDetailViewController.h"
#import "YQAnimatedTransition.h"
#import "YQSettingViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
@property (nonatomic, weak) UIImageView *selectImageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    self.title = @"列表页面";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(set)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UIImageView *selectImageView = [UIImageView new];
    selectImageView.frame = CGRectNull;
    [self.view addSubview:selectImageView];
    self.selectImageView = selectImageView;
}

- (void)set
{
    [self presentViewController:[[YQSettingViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSInteger imageNum = indexPath.row % 3;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld", imageNum]];
    cell.imageView.frame = CGRectMake(5, 5, 70, 70);
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YQDetailViewController *detail = [[YQDetailViewController alloc] init];
    detail.selectRow = indexPath.row;
    
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
//    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
//    
//    self.selectImageView.image = cell.imageView.image;
//    self.selectImageView.frame = CGRectMake(cell.imageView.frame.origin.x, rect.origin.y, cell.imageView.frame.size.width, cell.imageView.frame.size.height);
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.selectImageView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.width);
//    } completion:^(BOOL finished) {
        [self.navigationController pushViewController:detail animated:YES];
//    }];
}



#pragma mark - UINavigationBarDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        YQAnimatedTransition *animatedTransition = [YQAnimatedTransition animatedTransitionWithType:YQAnimatedTransitionTypePush];
        return animatedTransition;
    }
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != self) {
        self.selectImageView.frame = CGRectNull;
    }
}


@end
