//
//  LoginViewController.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LoginViewController.h"
#import "SysButton.h"
#import "IconUnderLineTextField.h"
#import <MBProgressHUD.h>//弹框
#import <RongIMKit/RongIMKit.h>//融云
#import <RongIMLib/RongIMLib.h>

@interface LoginViewController ()<RCIMUserInfoDataSource>

@property(nonatomic,strong)SysButton *loginBtn;
@property(nonatomic,strong)IconUnderLineTextField *accountTF;
@property(nonatomic,strong)IconUnderLineTextField *passwordTF;
@property(nonatomic,strong)UIImageView *logoImageView;

@end

@implementation LoginViewController

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"我是登录界面");
//    [self.view removeFromSuperview];
//    [self removeFromParentViewController];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tipLabel.text = @"我是登录界面";
    
    [self setupUI];
}

-(void)setupUI {
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [bgImage setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:bgImage];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.passwordTF];
}

#pragma mark -- 懒加载
-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:AAdaptionRect((750-279)*0.5, 126, 279, 307)];
        [_logoImageView setImage:[UIImage imageNamed:@"login_logo"]];
    }
    return _logoImageView;
}


-(IconUnderLineTextField *)accountTF {
    if (!_accountTF) {
        _accountTF = [[IconUnderLineTextField alloc] initWithFrame:AAdaptionRect(182, CGRectGetMaxY(self.logoImageView.frame)/AAdaptionWidth() + 88, 454, 62) withIconName:@"手机" withPlaceholder:@"请输入帐号"];
        _accountTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveAccount"];
    }
    return _accountTF;
}

-(IconUnderLineTextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[IconUnderLineTextField alloc] initWithFrame:AAdaptionRect(182, 660, 454, 62) withIconName:@"密码" withPlaceholder:@"请输入密码"];
        _passwordTF.secureTextEntry = YES;
        _passwordTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"savePassword"];
    }
    return _passwordTF;
}

-(SysButton *)loginBtn {
    __weak typeof(self) weakself = self;
    if (!_loginBtn) {
        _loginBtn = [[SysButton alloc]initWithFrame:AAdaptionRect((750-576)*0.5, CGRectGetMaxY(self.passwordTF.frame)/AAdaptionWidth() + 82, 576, 80) withTag:100 withTitle:@"登录" withTitleColor:MainBgColor withBackgorundColor:MainThemeColor withCornerRadius:0.1 withClickBlock:^(id sender) {
            
            if ([_accountTF.text  isEqualToString: @""]) {
                NSLog(@"账号不能为空");
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = @"账号不能为空";
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    hud.hidden = YES;
                });
            }else if ([_passwordTF.text isEqualToString:@""]) {
                NSLog(@"密码不能为空");
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = @"密码不能为空";
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    hud.hidden = YES;
                });
            }else {
                //初始化融云API接口
                [[RCIM sharedRCIM] initWithAppKey:AppKey];
                
                [[RCIM sharedRCIM] connectWithToken:Token success:^(NSString *userId) {
                    NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                    
//                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                    hud.mode = MBProgressHUDModeAnnularDeterminate;
//                    hud.label.text = @"登录成功";
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                        hud.hidden = YES;
//                        
//                        [weakself.view removeFromSuperview];
//                        [weakself removeFromParentViewController];
//                        
//                    });
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakself.view removeFromSuperview];
                        [weakself removeFromParentViewController];
                        
                    });
                    
                    [[RCIM sharedRCIM] setUserInfoDataSource:self];
                    
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"登陆的错误码为:%ld", (long)status);
                } tokenIncorrect:^{
                    //token过期或者不正确。
                    //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                    //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                    NSLog(@"token错误");
                }];
             
            }
        }];
    }

    return _loginBtn;
}


- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion{
    
    if ([userId isEqualToString:@"test2"]) {
        RCUserInfo *user = [[RCUserInfo alloc] init];
        user.userId = userId;
        user.name = @"测试2";
        return completion(user);
    }
    
    return completion(nil);
    
}


@end
