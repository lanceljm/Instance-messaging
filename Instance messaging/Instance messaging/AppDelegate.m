//
//  AppDelegate.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>

@interface AppDelegate ()<RCIMUserInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
//    [[RCIM sharedRCIM] initWithAppKey:@"uwd1c0sxuwt71"];
//    
//    __weak typeof(self)weakSelf = self;
//    [[RCIM sharedRCIM] connectWithToken:@"PC/sBMu87VadVYk5kxIR1JilVM5YkeEAd+a39plw3mKH9R86Ci/Q8KX/cywF59NLHraBY9RG8LGP8KDaiKSEjw=="     success:^(NSString *userId) {
//        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            weakSelf.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//            weakSelf.window.rootViewController = [[RootViewController alloc] init];
//            [weakSelf.window makeKeyAndVisible];
//
//        });
//
//       
//        
//        [[RCIM sharedRCIM] setUserInfoDataSource:self];
//        
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"登陆的错误码为:%ld", (long)status);
//    } tokenIncorrect:^{
//        //token过期或者不正确。
//        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//        NSLog(@"token错误");
//    }];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[RootViewController alloc]init];
    [self.window makeKeyAndVisible];

    /**
     * 推送处理1
     */
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
//        UIFont *font = [UIFont systemFontOfSize:19.f];
//    NSDictionary *textAttributes = @{
//                                     NSFontAttributeName : font,
//                                     NSForegroundColorAttributeName : [UIColor whiteColor]
//                                     };
//    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance]
//     setBarTintColor:[UIColor colorWithRed:(1 / 255.0f) green:(149 / 255.0f) blue:(255 / 255.0f) alpha:1]];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];

    return YES;
}
/**
 *  将得到的devicetoken 传给融云用于离线状态接收push ，您的app后台要上传推送证书
 *
 *  @param application <#application description#>
 *  @param deviceToken <#deviceToken description#>
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}


/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
       
    }
}
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion{
    
   if([userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {//自己
       
       RCUserInfo *aUser = [[RCUserInfo alloc]init];
       aUser.userId = userId;
       aUser.name = @"huahuacai?";
       return completion(aUser);
   }
    
    
    if ([userId isEqualToString:@"test2"]) {
        RCUserInfo *user = [[RCUserInfo alloc] init];
        user.userId = userId;
        user.name = @"测试2";
        return completion(user);
    }
    if ([userId isEqualToString:@"ljm"]) {
        RCUserInfo *user = [[RCUserInfo alloc] init];
        user.userId = userId;
        user.name = @"罗佳明";
        return completion(user);
    }
    return completion(nil);
    
}
//- (void)getUserInfoWithUserId:(NSString *)userId
//                   completion:(void (^)(RCUserInfo *userInfo))completion{
//    
//    if ([userId isEqualToString:@"test2"]) {
//        RCUserInfo *user = [[RCUserInfo alloc] init];
//        user.userId = userId;
//        user.name = @"测试2";
//        return completion(user);
//    }
//    
//    return completion(nil);
//    
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
