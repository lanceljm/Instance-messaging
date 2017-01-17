//
//  WeChatVC.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "WeChatVC.h"

@interface WeChatVC() 

@end

@implementation WeChatVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
