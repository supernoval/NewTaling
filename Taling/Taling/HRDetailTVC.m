//
//  HRDetailTVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "HRDetailTVC.h"
#import "HRDetailCell.h"
#import "SummaryCell.h"
#import "RecommendCell.h"
#import "CommentCell.h"
#import "RecommendTalentTVC.h"
#import "RecommendAppraiseTVC.h"

@interface HRDetailTVC ()

@end

@implementation HRDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"王女士";
    self.view.backgroundColor = kBackgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    headView.backgroundColor = [UIColor whiteColor];
    UIView *indiView = [[UIView alloc]initWithFrame:CGRectMake(15, 5, 3, 20)];
    indiView.backgroundColor = kYellowColor;
    indiView.clipsToBounds = YES;
    indiView.layer.cornerRadius = 1.2;
    [headView addSubview:indiView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, 30)];
    title.font = FONT_15;
    [headView addSubview:title];
    
    UIImageView *indicator = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-15-13, 4, 13, 22)];
    indicator.image = [UIImage imageNamed:@"point_go"];
    [headView addSubview:indicator];
    
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, ScreenWidth-150-28-3, 30)];
    numLabel.textColor = kTextLightGrayColor;
    numLabel.font = FONT_14;
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.text = @"12份";
    [headView addSubview:numLabel];
    
    UIButton *pushButton = [[UIButton alloc]initWithFrame:headView.frame];
    [headView addSubview:pushButton];
    
    switch (section) {
        case 0:
        {
            return nil;
        }
            break;
            
        case 1:
        {
            title.text = @"Ta推荐的人才";
            [pushButton addTarget:self action:@selector(pushToRecommendTalent:) forControlEvents:UIControlEventTouchUpInside];
            return headView;
        }
            break;
            
        case 2:
        {
            title.text = @"Ta推荐的评价";
            [pushButton addTarget:self action:@selector(pushToRecommendAppraise:) forControlEvents:UIControlEventTouchUpInside];
            return headView;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *gapFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    
    gapFooter.backgroundColor = kBackgroundColor;
    
    
    
    float tagWidth = (ScreenWidth-30-3*TagGap)/4;
    float tagHeight = 30;
    NSInteger count = 7;
    NSInteger tagRow;
    if (count%4 == 0) {
        tagRow = count/4;
    }else{
        tagRow = count/4 + 1;
    }
    
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*tagRow+10)];
    
    blankFooter.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i < count; i++) {
        
        TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
        tagLabel.text = [NSString stringWithFormat:@"高级%li",(long)i];
        [blankFooter addSubview:tagLabel];
        
    }
    
    UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-10, ScreenWidth, 10)];
    gap.backgroundColor = kBackgroundColor;
    [blankFooter addSubview:gap];
    
    
    switch (section) {
        case 0:
        {
            return gapFooter;
        }
            break;
            
        case 1:
        {
            return blankFooter;
        }
            break;
            
        case 2:
        {
            return blankFooter;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 10;
        }
            break;
            
        case 1:
        {
            return 90;
        }
            break;
            
        case 2:
        {
            return 90;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
        {
            return 0.1;
        }
            break;
            
        case 1:
        {
            return 30;
        }
            break;
            
        case 2:
        {
            return 30;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 3;
        }
            break;
            
        case 1:
        {
            return 1;
        }
            break;
            
        case 2:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    return 87;
                }
                    break;
                    
                case 1:
                {
                    return 100;
                }
                    break;
                    
                case 2:
                {
                    return 60;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            return 73;
        }
            break;
            
        case 2:
        {
            return 80;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    static NSString *cellId = @"HRDetailCell";
                    HRDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                    if (cell == nil) {
                        cell = [[NSBundle mainBundle]loadNibNamed:@"HRDetailCell" owner:self options:nil][0];
                    }
                    
                    
                    //头像
                    //        if (oneItem.photo.length > 0) {
                    //
                    //            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo]];
                    //        }
                    
                    //姓名
                    //    cell.nameLabel
                    
                    //ID
                    cell.idLabel.text = @"人才官ID 123333";
                    
                    //城市
                    cell.disLabel.text = @"上海 上海";
                    
                    // 推荐净值
                    //        cell.recomValue.text = [NSString stringWithFormat:@"¥%.2f",oneItem.price] ;

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
                    cell.titleLabel.text = @"擅长招聘岗位:";
                    cell.titleLabel.textColor = kTextLightGrayColor;
                    cell.titleLabel.font = FONT_14;
                    
                    cell.contentLabel.text = @"移动互联网 移动互联网 移动互联网 移动互联网 电子商务 电子商务 电子商务 电子商务";
                    return cell;
                }
                    break;
                    
                case 2:
                {
                    static NSString *cellId = @"SummaryCell";
                    SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                    if (cell == nil) {
                        cell = [[NSBundle mainBundle]loadNibNamed:@"SummaryCell" owner:self options:nil][0];
                    }
                    cell.titleLabel.text = @"服务过的企业:";
                    cell.titleLabel.textColor = kTextLightGrayColor;
                    cell.titleLabel.font = FONT_14;
                    
                    cell.contentLabel.textColor = kBlueColor;
                    cell.contentLabel.text = @"移动互联网 移动互联网 移动互联网 移动互联网";
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
        case 1:
        {
            static NSString *cellId = @"RecommendCell";
            RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"RecommendCell" owner:self options:nil][0];
            }
            
            //    if (_JDArray.count > indexPath.section) {
            
            
            
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
            
            
            //    }
            
            return cell;
        }
            break;
            
        case 2:
        {
            static NSString *cellId = @"CommentCell";
            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
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
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
    
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    RecommendDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendDetailVC"];
    //    [self.navigationController pushViewController:detail animated:YES];
    
    
    
    
    //    if (indexPath.section < _JDArray.count) {
    //
    //        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    //
    //        NSInteger resumesId = oneItem.resumesId;
    //
    //
    //        if (resumesId) {
    //
    //            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //
    //            ResumeDetailVC *resumeDetail = [sb instantiateViewControllerWithIdentifier:@"ResumeDetailVC"];
    //
    //            resumeDetail.type = 1;
    //            resumeDetail.hidesBottomBarWhenPushed = YES;
    //            resumeDetail.item = oneItem;
    //            resumeDetail.VCtitle = @"简历详情";
    //            [self.navigationController pushViewController:resumeDetail animated:YES];
    //
    //        }
    //
    //
    //
    //
    //
    //    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark- 推荐的人才
-(void)pushToRecommendTalent:(UIButton *)button{
    
    RecommendTalentTVC *talent = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendTalentTVC"];
    [self.navigationController pushViewController:talent animated:YES];
}

#pragma mark- 推荐的评价
-(void)pushToRecommendAppraise:(UIButton *)button{
    
    RecommendAppraiseTVC *talent = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendAppraiseTVC"];
    [self.navigationController pushViewController:talent animated:YES];
}


@end
