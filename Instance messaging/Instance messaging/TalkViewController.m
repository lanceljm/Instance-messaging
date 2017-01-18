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
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),    /*单聊*/
                                            @(ConversationType_DISCUSSION),                  /*讨论组*/
                                            @(ConversationType_CHATROOM),                   /*聊天室*/
                                            @(ConversationType_GROUP),                          /*群组*/
                                            @(ConversationType_APPSERVICE),                 /*公众号*/
                                            @(ConversationType_SYSTEM)]];                      /*系统会话*/
        //会话类型聚合 私聊
        //[self setCollectionConversationType:@[@(ConversationType_PRIVATE)]];

        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        //会话类型聚合 私聊 讨论组
        [self setCollectionConversationType:@[@(ConversationType_PRIVATE), @(ConversationType_DISCUSSION)]];

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
    //判断会话聚合类型 私聊
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        TalkViewController *vc = [[TalkViewController alloc] init];

        [vc setDisplayConversationTypes:@[@(model.conversationType)]];
        [vc setCollectionConversationType:nil];
        vc.isEnteredToCollectionViewController = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (model.conversationType == ConversationType_PRIVATE) {
        
    //初始化聊天界面
    ChatVC *chatVc = [[ChatVC alloc] init];
    //会话类型
    chatVc.conversationType = model.conversationType;
    chatVc.targetId = model.targetId;
    chatVc.title = model.conversationTitle;
    [self.navigationController pushViewController:chatVc animated:YES];
    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"chat" style:UIBarButtonItemStyleDone target:self action:@selector(addChatVC)];
    self.navigationItem.rightBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)createDiscussion:(NSString *)name
              userIdList:(NSArray *)userIdList
                 success:(void (^)(RCDiscussion *discussion))successBlock
                   error:(void (^)(RCErrorCode status))errorBlock{
    
}

- (void)addChatVC {
    ChatVC *vc = [[ChatVC alloc] init];
    vc.targetId = @"ljm";
    vc.conversationType = ConversationType_PRIVATE;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
