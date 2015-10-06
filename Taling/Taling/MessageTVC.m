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

@interface MessageTVC ()

@end

@implementation MessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    //系统消息数
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
                cell.iconImageView.image = [UIImage imageNamed:@"message buy"];
                cell.titleLabel.text = @"购买";
                cell.dotView.hidden = YES;
            }
                break;
                
            case 1:
            {
                cell.iconImageView.image = [UIImage imageNamed:@"message comment"];
                cell.titleLabel.text = @"评论";
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
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                BuyMessageTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyMessageTVC"];
                [self.navigationController pushViewController:buy animated:YES];
                
            }
                break;
                
            case 1:
            {
                CommentMessageTVC *comment = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentMessageTVC"];
                [self.navigationController pushViewController:comment animated:YES];
               
            }
                break;
                
            case 2:
            {
                LikeMessageTVC *like = [self.storyboard instantiateViewControllerWithIdentifier:@"LikeMessageTVC"];
                [self.navigationController pushViewController:like animated:YES];
                
            }
                break;
                
                
            default:
                break;
        }

        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    }
    
}

@end
