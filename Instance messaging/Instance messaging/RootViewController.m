//
//  RootViewController.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "RootViewController.h"

#import "TBViewController.h"
#import "LoginViewController.h"

@interface RootViewController ()

@property(nonatomic, strong) NSMutableArray<UIViewController *> *childVCs;

@end

@implementation RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor redColor];
    
    
    [self setControllers];
    [self registNotifications];
    
}

-(void)registNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginViewController) name:@"showLoginViewController" object:nil];
}

-(void)setControllers{
    //1.TabBarControllers
    [self showTabBarVcs];
    //2.LoginViewController
    //[self showLoginViewController];
    
}

-(void)showTabBarVcs{
    //显示标签控制器视图
    TBViewController *vc = [[TBViewController alloc] init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    self.TBVC = vc;
}

-(void)showLoginViewController{
    //显示登录视图
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
