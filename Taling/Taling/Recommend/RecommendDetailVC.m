//
//  RecommendDetailVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendDetailVC.h"
#import "RecommendCell.h"
#import "SummaryCell.h"
#import "FocusCell.h"
#import "CommentCell.h"
#import "BuyResumeDetailTVC.h"

@interface RecommendDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RecommendDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.title = @"姓名的简历";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _collectWidth.constant = ScreenWidth/2;
    _buyWidth.constant = ScreenWidth/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
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
    
//    UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-10, ScreenWidth, 10)];
//    gap.backgroundColor = kBackgroundColor;
//    [blankFooter addSubview:gap];
    
    if (section == 3) {
        return blankFooter;
    }else{
        return nil;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    
    blankFooter.backgroundColor = [UIColor whiteColor];
    UILabel *commentNum = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 200, 32)];
    commentNum.text = @"评论(15)";
    commentNum.font = FONT_15;
    commentNum.textColor = [UIColor blackColor];
    [blankFooter addSubview:commentNum];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-1, ScreenWidth, 0.3)];
    line.backgroundColor = kLineColor;
    [blankFooter addSubview:line];
    
    if (section == 3) {
        return blankFooter;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 80;
    }
    return 0.8;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 3) {
        return 40;
    }
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            return 73;
        }
            break;
            
        case 1:
        {
            return 100;
        }
            break;
            
        case 2:
        {
            return 55;
        }
            break;
            
        case 3:
        {
            return 120;
        }
            break;
            
        default:
            break;
    }
    return 0;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cellId = @"RecommendCell";
            RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"RecommendCell" owner:self options:nil][0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
            //    cell.companyLabel.text = [NSString stringWithFormat:@"公司:%@",oneItem.currentCompany]
            
            return cell;
        }
            break;
            
        case 1:
        {
            static NSString *cellId = @"SummaryCell";
            SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"SummaryCell" owner:self options:nil][0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            //概述
            //            cell.contentLabel.text = @"";
            
            return cell;
        }
            break;
            
        case 2:
        {
            static NSString *cellId = @"FocusCell";
            FocusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"FocusCell" owner:self options:nil][0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //姓名
            //                        cell.nameLabel.text = @"";
            
            //人才官
            //            cell.disLabel.text =
            
            //加关注
            //            cell.focusButton
            
            return cell;
        }
            break;
            
        case 3:
        {
            static NSString *cellId = @"CommentCell";
            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
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
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    
    return nil;
}


- (IBAction)collecAction:(UIButton *)sender {
}

- (IBAction)buyAction:(id)sender {
    
    BuyResumeDetailTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyResumeDetailTVC"];
    [self.navigationController pushViewController:buy animated:YES];
}
@end
