//
//  MessageTVC.m
//  Taling
//
//  Created by Leo on 15/10/6.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "MessageTVC.h"
#import "MessageCell.h"
#import "NotifiCell.h"
#import "BuyMessageTVC.h"
#import "CommentMessageTVC.h"
#import "LikeMessageTVC.h"
#import "MSGModel.h"
#import "MessageDetailVC.h"



@interface MessageTVC ()
{
    NSInteger index;
    NSInteger size;
    
    
    NSMutableArray *_SYSMSGArray;
    NSMutableArray *_UserMSGArray;
    
    
    
}
@end

@implementation MessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    
    _SYSMSGArray = [[NSMutableArray alloc]init];
    _UserMSGArray = [[NSMutableArray alloc]init];
    
    index = 1;
    size = 20;
    
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getMessage];
    

    
}
-(void)getMessage
{
    NSDictionary *param
    = @{@"user_id":[UserInfo getuserid],@"index":@(index),@"size":@(size)};
    
//    NSDictionary *param = @{@"user_id":@"1",@"index":@(index),@"size":@(size)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetNotification Params:param result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            if ([data isKindOfClass:[NSArray class]])
            {
                
                [_SYSMSGArray removeAllObjects];
                [_UserMSGArray removeAllObjects];
                
                for (NSDictionary *dic in data) {
                    
                    MSGModel *model = [[MSGModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dic];
                    
                    if (model.messageType == 0) {
                      
                        [_SYSMSGArray addObject:model];
                        
                    }
                    if (model.messageType == 1) {
                        
                        
                        [_UserMSGArray addObject:model];
                        
                    }
                   
                    
                    
                 }
                
                
                [self.tableView reloadData];
                
            }
            
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 64;
    }
    return 114;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

  
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"MessageCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:self options:nil][0];
        
    }
    
    static NSString *notifiCellId = @"NotifiCell";
    NotifiCell *notifiCell = [tableView dequeueReusableCellWithIdentifier:notifiCellId];
    if (notifiCell == nil) {
        notifiCell = [[NSBundle mainBundle]loadNibNamed:@"NotifiCell" owner:self options:nil][0];
        
    }
    notifiCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
            
                cell.iconImageView.image = [UIImage imageNamed:@"message comment"];
                cell.titleLabel.text = @"用户消息";
                
                cell.dotView.hidden = YES;
                
                
//                if (_SYSMSGArray.count > 0) {
//                    
//                    cell.dotView.hidden = NO;
//                }
//                else
//                {
//                   cell.dotView.hidden = YES;
//                }
            }
                break;
                
            case 1:
            {
                
                cell.iconImageView.image = [UIImage imageNamed:@"message notification"];
                cell.titleLabel.text = @"系统消息";
                
                cell.dotView.hidden = YES;
                
              
                
//                if (_UserMSGArray.count > 0) {
//                    
//                    cell.dotView.hidden = NO;
//                }
//                else
//                {
//                    cell.dotView.hidden = YES;
//                }
                
                
            }
                break;
                
            case 2:
            {
                cell.iconImageView.image = [UIImage imageNamed:@"message like"];
                cell.titleLabel.text = @"赞";
            }
                break;
                
                
            default:
                break;
        }
        
        return cell;
    }else{
        
        notifiCell.timeLabel.text = @"2099-09-09";
        notifiCell.contentLabel.text = @"系统消息提醒，你中大奖了，快来领。系统消息提醒，你中大奖了，快来领";
        
        return notifiCell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.row == 0) {
        
        MessageDetailVC *_detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailVC"];
        
        _detail.messages = _UserMSGArray;
        
        _detail.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:_detail animated:YES];
        
   
        
    }
    
    if (indexPath.row == 1) {
        
        MessageDetailVC *_detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailVC"];
        
        _detail.messages = _SYSMSGArray;
        
        _detail.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:_detail animated:YES];
        
        
    }
    
    
    
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//            {
//                BuyMessageTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyMessageTVC"];
//                [self.navigationController pushViewController:buy animated:YES];
//                
//            }
//                break;
//                
//            case 1:
//            {
//                CommentMessageTVC *comment = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentMessageTVC"];
//                [self.navigationController pushViewController:comment animated:YES];
//               
//            }
//                break;
//                
//            case 2:
//            {
//                LikeMessageTVC *like = [self.storyboard instantiateViewControllerWithIdentifier:@"LikeMessageTVC"];
//                [self.navigationController pushViewController:like animated:YES];
//                
//            }
//                break;
//                
//                
//            default:
//                break;
//        }
//
//       
//
//    }
    
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
