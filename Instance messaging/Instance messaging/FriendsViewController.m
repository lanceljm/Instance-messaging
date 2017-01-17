//
//  FriendsViewController.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "FriendsViewController.h"
#import "WeChatVC.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        //设置会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),    /*单聊*/
                                            @(ConversationType_DISCUSSION),                  /*讨论组*/
                                            @(ConversationType_CHATROOM),                   /*聊天室*/
                                            @(ConversationType_GROUP),                          /*群组*/
                                            @(ConversationType_APPSERVICE),                 /*公众号*/
                                            @(ConversationType_SYSTEM)]];
    }
    return self;
}

-(void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    //模型的绘画类型是群聊
    if (model.conversationType == ConversationType_GROUP) {
        RCConversationCell *conCell = (RCConversationCell *)cell;
        conCell.conversationTitle.textColor = [UIColor blueColor];
    }
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{
    
    //初始化聊天界面
    WeChatVC *chatVcs = [[WeChatVC alloc] init];
    //会话类型
    chatVcs.conversationType = model.conversationType;
    chatVcs.targetId = model.targetId;
    chatVcs.title = model.targetId;
    [self.navigationController pushViewController:chatVcs animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"群聊" style:UIBarButtonItemStyleDone target:self action:@selector(addChatVCs)];
    self.navigationItem.rightBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    self.view.backgroundColor = [UIColor greenColor];
}

-(void)addChatVCs {

    NSMutableArray *IDS = [NSMutableArray arrayWithArray:@[@"HuahuaCai",@"test1",@"ljm"]];

    [[RCIMClient sharedRCIMClient] createDiscussion:@"融云学习讨论组" userIdList:IDS success:^(RCDiscussion *discussion) {
        NSLog(@"success  %@",discussion.discussionName);
        NSLog(@"%@",discussion.discussionId);
        self.discussionId = discussion.discussionId;
        dispatch_async(dispatch_get_main_queue(), ^{
//            [WMUtil showTipsWithHUD:@"成功加入讨论组"];
        });
        
    } error:^(RCErrorCode status) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [WMUtil showTipsWithHUD:@"创建讨论组失败"];
        });
        NSLog(@"faild %ld",status);
        
    }];

    
}


//- (void)addChatVC {
//    WeChatVC *vc = [[WeChatVC alloc] initWithConversationType:ConversationType_GROUP targetId:@"HuahuaCai"];
//    [self.navigationController pushViewController:vc animated:YES];
//}

@end
