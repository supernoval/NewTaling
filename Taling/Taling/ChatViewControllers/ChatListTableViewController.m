//
//  ChatListTableViewController.m
//  Taling
//
//  Created by Haikun Zhu on 15/10/14.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ChatListTableViewController.h"
#import "ChatListCellTableViewCell.h"
#import "IChatManagerDelegate.h"
#import "NSDate+Category.h"
#import "ConvertToCommonEmoticonsHelper.h"


static NSString *cellId = @"ChatListCellTableViewCell";


@interface ChatListTableViewController ()<EMChatManagerDelegate,UITableViewDataSource,UITableViewDelegate,IChatManagerDelegate>
{
    NSMutableArray *_conversations;
    
    
}

@end

@implementation ChatListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    self.title = @"消息";
    
    
    _conversations = [[NSMutableArray alloc]init];
    
//    [self addHeaderRefresh];
//    [self addFooterRefresh];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reFreshDataSource];
    
    [self registerNotifications];
    
}

-(void)headerRefresh
{
    
}

-(void)footerRefresh
{
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _conversations.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    
    
    
    return cell;
    
    
}


// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
//                if ([[RobotManager sharedInstance] isRobotMenuMessage:lastMessage]) {
//                    ret = [[RobotManager sharedInstance] getRobotMenuMessageDigest:lastMessage];
//                } else {
//                    ret = didReceiveText;
//                }
                
                 ret = didReceiveText;
                
            } break;
            case eMessageBodyType_Voice:{
                ret = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                ret = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                ret = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}


#pragma mark - 刷新
-(void)reFreshDataSource
{
    _conversations = [self loadDataSource];
    
    [self.tableView reloadData];
    
    
}

#pragma mark -获取聊天记录
- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    
    NSArray* sorte = [conversations sortedArrayUsingComparator:
                      ^(EMConversation *obj1, EMConversation* obj2){
                          EMMessage *message1 = [obj1 latestMessage];
                          EMMessage *message2 = [obj2 latestMessage];
                          if(message1.timestamp > message2.timestamp) {
                              return(NSComparisonResult)NSOrderedAscending;
                          }else {
                              return(NSComparisonResult)NSOrderedDescending;
                          }
                      }];
    
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}






#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self reFreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self reFreshDataSource];
}


#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self unregisterNotifications];
    
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
