//
//  TBViewController.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "TBViewController.h"

#import "TalkViewController.h"
#import "FriendsViewController.h"
#import "MineViewController.h"

@interface TBViewController ()

@property(nonatomic, strong) NSMutableArray<UIViewController *> *childVCs;

@end

@implementation TBViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.childVCs = [NSMutableArray array];
        [self addChildVCs];
    }
    return self;
}

-(void)addChildVCs {
    //聊天列表
    [self addChildVcWithTitle:@"聊天" withClassName:@"TalkViewController" withNormalImageName:@"icon_room" withSelectedImageName:@"icon_room_hover"];
    
    //好友
    [self addChildVcWithTitle:@"好友" withClassName:@"FriendsViewController" withNormalImageName:@"chat_room_inactive" withSelectedImageName:@"chat_room"];
    
    //我
    [self addChildVcWithTitle:@"我" withClassName:@"MineViewController" withNormalImageName:@"icon_me" withSelectedImageName:@"icon_me_hover"];
}

-(void)addChildVcWithTitle:(NSString *)title withClassName:(NSString *)className withNormalImageName:(NSString *)normalImageName withSelectedImageName:(NSString *)selectedImageName{
    
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:normalImageName] selectedImage:[UIImage imageNamed:selectedImageName]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.title = title;
    [self.childVCs addObject:nav];
    self.viewControllers = self.childVCs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
