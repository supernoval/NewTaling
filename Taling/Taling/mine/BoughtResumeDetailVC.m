//
//  BoughtResumeDetailVC.m
//  Taling
//
//  Created by ucan on 15/12/8.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BoughtResumeDetailVC.h"
#import "RecommendCell.h"
#import "SummaryCell.h"
#import "FocusCell.h"
#import "CommentCell.h"
#import "CommentTVC.h"

@interface BoughtResumeDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
}

@end

@implementation BoughtResumeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"XX的简历";
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _appraiseWidth.constant = ScreenWidth/2;
    _collectWidth.constant = ScreenWidth/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 2;
    }
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *view_1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        view_1.backgroundColor = [UIColor whiteColor];
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 50)];
        text.numberOfLines = 0;
        text.font = FONT_13;
        text.textColor = kTextLightGrayColor;
        text.text = @"联系电话:15222222222\n电子邮箱:somebody@uu.com";
        [view_1 addSubview:text];
        return view_1;
    }else if (section == 2){
        
        UIView *appraiseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        appraiseView.backgroundColor = [UIColor whiteColor];
        UILabel *appraiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, ScreenWidth-30, 25)];
        appraiseLabel.text = @"评价(15)";
        appraiseLabel.font = FONT_15;
        [appraiseView addSubview:appraiseLabel];
        return appraiseView;
    }else if (section == 3){
        float tagWidth = (ScreenWidth-30-3*TagGap)/4;
        float tagHeight = 30;
        NSInteger count = 7;
        NSInteger tagRow;
        if (count%4 == 0) {
            tagRow = count/4;
        }else{
            tagRow = count/4 + 1;
        }
        
        UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*tagRow)];
        
        blankFooter.backgroundColor = [UIColor whiteColor];
        for (NSInteger i = 0; i < count; i++) {
            
            TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
            tagLabel.text = [NSString stringWithFormat:@"高级%li",(long)i];
            [blankFooter addSubview:tagLabel];
            
        }
        
        //    UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-1, ScreenWidth, 1)];
        //    gap.backgroundColor = kLineColor;
        //    [blankFooter addSubview:gap];
        
        return blankFooter;
    }else{
        
        return nil;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }else if (section == 2){
        return 30;
    }else if (section == 3){
        return 80;
    }
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            return 73;
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0) {
                return 30+[StringHeight heightWithText:@"简历概述简历概述简历概述简历概述简历概述简历概述简历概述简历概述简历概述" font:FONT_14 constrainedToWidth:ScreenWidth-30];
            }else if (indexPath.row == 1){
                return 30+[StringHeight heightWithText:@"毕业学校:外国航天人体大学\n实习经历:曾经在人体大学学到了很多不为人知的秘密\n工作经历:那谁知道是什么玩意你知道吗，我不知道\n办公技巧:你需要我啥技巧，啥都会\n生活喜好:我啥姿势都喜欢你不知道" font:FONT_14 constrainedToWidth:ScreenWidth-30];
            }
        }
            break;
            
        case 2:
        {
            return 55;
        }
            break;
            
        case 3:
        {
            return 80+[StringHeight heightWithText:@"丰富经历：描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历\n\n专家擅长：主要擅长什么主要擅长什么主要擅长什么主要擅长什么主要擅长什么\n\n关键业绩：关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩\n\n优缺点：你的也有缺点赶紧爆出来你会打篮球吗" font:FONT_14 constrainedToWidth:ScreenWidth-30];
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cellId = @"RecommendCell";
            RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil][0];
            }
            

            //头像
            //        if (oneItem.photo.length > 0) {
            //
            //            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo]];
            //        }
            
            
            //ID
            //    cell.idLabel.text = oneItem.name;
            
            // 简历估值
            //    cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",oneItem.price] ;
            
            
            //城市&行业
            
            //    cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,edu];
            
            
            //公司&职业
            //    cell.companyLabel.text = [NSString stringWithFormat:@"公司:%@",oneItem.currentCompany];
            
            return cell;
            
            
        }
            break;
            
        case 1:
        {
            static NSString *cellId = @"SummaryCell";
            SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil][0];
            }
            
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"简历概述";
                cell.contentLabel.text = @"简历概述简历概述简历概述简历概述简历概述简历概述简历概述简历概述简历概述";
                return cell;
                
            }else if (indexPath.row == 1){
                cell.titleLabel.text = @"经历概述";
                cell.contentLabel.text = @"毕业学校:外国航天人体大学\n实习经历:曾经在人体大学学到了很多不为人知的秘密\n工作经历:那谁知道是什么玩意你知道吗，我不知道\n办公技巧:你需要我啥技巧，啥都会\n生活喜好:我啥姿势都喜欢你不知道";
                return cell;
            }
        }
            break;
            
        case 2:
        {
            static NSString *cellId = @"FocusCell";
            FocusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil][0];
            }
//            cell.headImageView
//            cell.nameLabel
//            cell.disLabel
//            cell.focusButton
            return cell;
            
            
        }
            break;
            
        case 3:
        {
            static NSString *cellId = @"CommentCell";
            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil][0];
            }
            
            //头像
            //            cell.headImageView
            
            //姓名
            //            cell.nameLabel
            
            //id
            //            cell.idLabel
            
            //time
            //            cell.timeLabel
            
            //评论内容
            //            cell.commentLabel
            
            NSString *text = @"丰富经历：描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历\n\n专家擅长：主要擅长什么主要擅长什么主要擅长什么主要擅长什么主要擅长什么\n\n关键业绩：关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩\n\n优缺点：你的也有缺点赶紧爆出来你会打篮球吗";
            cell.commentLabel.text = text;
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}




#pragma mark- 评论分享
- (IBAction)appraiseAction:(UIButton *)sender {
    
    CommentTVC *comment = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentTVC"];
    [self.navigationController pushViewController:comment animated:YES];
}

#pragma mark- 立即联系
- (IBAction)contactAction:(UIButton *)sender {
}
@end
