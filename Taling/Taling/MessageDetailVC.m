//
//  MessageDetailVC.m
//  Taling
//
//  Created by ZhuHaikun on 16/1/20.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import "MessageDetailVC.h"

@interface MessageDetailVC ()

@end

@implementation MessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息列表";
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *blanckView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    
    blanckView.backgroundColor = [UIColor clearColor];
    
    
    return blanckView;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _messages.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MSGModel *model = [_messages objectAtIndex:indexPath.section];
    
    CGFloat height = [StringHeight heightWithText:model.verb font:FONT_14 constrainedToWidth:ScreenWidth - 20];
    
    if (height < 30) {
        
        height = 30;
    }
    return 30 + height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MSGCell*cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    
    MSGModel *model = [_messages objectAtIndex:indexPath.section];
    
    cell.timeLabel.text = model.timestamp;
    
    cell.contentLabel.text = model.verb;
    
    
    
    
    return cell;
}


@end
