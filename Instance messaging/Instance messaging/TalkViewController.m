//
//  TalkViewController.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "TalkViewController.h"
#import "ChatVC.h"
@interface TalkViewController ()


@end

@implementation TalkViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        //会话类型聚合 私聊
        //[self setCollectionConversationType:@[@(ConversationType_PRIVATE)]];
    }
    return self;
}


//列表即将显示时做的操作
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
 
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    //模型的绘画类型是私聊
    if (model.conversationType == ConversationType_PRIVATE) {
        RCConversationCell *conCell = (RCConversationCell *)cell;
        conCell.conversationTitle.textColor = [UIColor blueColor];
    }
    
    
    
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{
    
    //初始化聊天界面
    ChatVC *chatVc = [[ChatVC alloc] init];
    //会话类型
    chatVc.conversationType = model.conversationType;
    chatVc.targetId = model.targetId;
    chatVc.title = model.targetId;
    [self.navigationController pushViewController:chatVc animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"chat" style:UIBarButtonItemStyleDone target:self action:@selector(addChatVC)];
    self.navigationItem.rightBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    self.view.backgroundColor = [UIColor greenColor];
}


- (void)addChatVC {
    ChatVC *vc = [[ChatVC alloc] initWithConversationType:ConversationType_PRIVATE targetId:@"HuahuaCai"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
