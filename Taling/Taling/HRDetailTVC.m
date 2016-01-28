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
#import "CommentItem.h"

@interface HRDetailTVC ()<UIAlertViewDelegate>
{
    NSInteger pageIndex;
    
    NSInteger pageSize;
    
    NSMutableArray *_JDArray;
    NSMutableArray *_commentArray;
    
    NSInteger appraiseNum;
    
    NSInteger saleresumesCountSum;
    
}

@end

@implementation HRDetailTVC
@synthesize hRitem;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = hRitem.nickname;
    self.view.backgroundColor = kBackgroundColor;
    _JDArray = [[NSMutableArray alloc]init];
    _commentArray = [[NSMutableArray alloc]init];
    pageSize = 1;
    pageIndex = 1;
//    [self requestUpLoadResumes];
    
//    [self getAppraise];
    
    [self getCount];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 获取统计结果
-(void)getCount
{
    NSDictionary *param = @{@"user_id":hRitem.id};
    
    [[TLRequest shareRequest] tlRequestWithAction:kresumesCount Params:param result:^(BOOL isSuccess, id data) {
       
        
        if (isSuccess) {
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                
                appraiseNum = [[data objectForKey:@"fansNum"]integerValue];
                
                saleresumesCountSum = [[data objectForKey:@"resumesCountSum"]integerValue];
                
                [self.tableView reloadData];
                
                
            }
        }
        
    }];
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
    
    UIImageView *indicator = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-15-13, 7, 10, 16)];
    indicator.image = [UIImage imageNamed:@"point_go"];
    [headView addSubview:indicator];
    
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, ScreenWidth-150-28-3, 30)];
    numLabel.textColor = kTextLightGrayColor;
    numLabel.font = FONT_14;
    numLabel.textAlignment = NSTextAlignmentRight;
//    numLabel.text = @"12份";
    [headView addSubview:numLabel];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, headView.frame.size.height-1, ScreenWidth, 1)];
    line.backgroundColor = kLineColor;
    [headView addSubview:line];
    
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
//            if (_JDArray.count > 0) {
//                
//                title.text = @"Ta推荐的人才";
//                [pushButton addTarget:self action:@selector(pushToRecommendTalent:) forControlEvents:UIControlEventTouchUpInside];
//                return headView;
//            }else{
//                return nil;
//            }
            
        }
            break;
            
        case 2:
        {
//            if (_commentArray.count>0) {
//                title.text = @"Ta推荐的评价";
//                [pushButton addTarget:self action:@selector(pushToRecommendAppraise:) forControlEvents:UIControlEventTouchUpInside];
//                return headView;
//            }else{
//                return nil;
//            }
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    switch (section) {
        case 0:
        {
            UIView *gapFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
            
            gapFooter.backgroundColor = kBackgroundColor;
            
            return gapFooter;
        }
            break;
            
        case 1:
        {
//            if (_JDArray.count > 0) {
//                ModelItem *oneItem = [_JDArray firstObject];
//                
//                float tagWidth = (ScreenWidth-30-3*TagGap)/4;
//                float tagHeight = 24;
//                NSInteger count = oneItem.resumesLabel.count;
//                NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
//                UIView *blankFooter = [[UIView alloc]init];
//                
//                if (tagRow>0) {
//                    blankFooter.frame = CGRectMake(0, 0, ScreenWidth, 34*tagRow+15);
//                }else{
//                     blankFooter.frame = CGRectMake(0, 0, ScreenWidth, 34*tagRow+10);
//                }
//                
//                
//                blankFooter.backgroundColor = [UIColor whiteColor];
//                for (NSInteger i = 0; i < count; i++) {
//                    NSDictionary *oneLabel = [oneItem.resumesLabel objectAtIndex:i];
//                    
//                    TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
//                    NSString *word =[NSString stringWithFormat:@"%@",[oneLabel objectForKey:@"word"]];
//                    
//                    NSArray *_words = nil;
//                    
//                    if (word.length > 0) {
//                        
//                        _words = [word componentsSeparatedByString:@"_"];
//                    }
//                    
//                    
//                    if (_words.count > 1) {
//                        
//                        word = [_words firstObject];
//                    }
//                    else
//                    {
//                        word = @"";
//                    }
//                    
//                    tagLabel.text = word;
//                    [blankFooter addSubview:tagLabel];
//                    
//                }
//                
//                UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-10, ScreenWidth, 10)];
//                    gap.backgroundColor = kLineColor;
//                    [blankFooter addSubview:gap];
//                
//               
//                return blankFooter;
//            }
            
            return nil;

        }
            break;
            
        case 2:
        {
//            if (_commentArray.count>0) {
//                CommentItem *commentItem = [_commentArray firstObject];
//                
//                float tagWidth = (ScreenWidth-30-3*TagGap)/4;
//                float tagHeight = 30;
//                NSArray *labelArray = [CommonMethods sepretTheAppraiseLabel:commentItem.lable];
//                NSInteger count = labelArray.count;
//                NSInteger tagRow;
//                if (count%4 == 0) {
//                    tagRow = count/4;
//                }else{
//                    tagRow = count/4 + 1;
//                }
//                
//                UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*tagRow)];
//                
//                blankFooter.backgroundColor = [UIColor whiteColor];
//                for (NSInteger i = 0; i < count; i++) {
//                    
//                    NSString *oneLabel = [labelArray objectAtIndex:i];
//                    TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
//                    tagLabel.text = oneLabel;
//                    [blankFooter addSubview:tagLabel];
//                    
//                }
//                
//                UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-1, ScreenWidth, 1)];
//                gap.backgroundColor = kLineColor;
//                [blankFooter addSubview:gap];
//                
//                return blankFooter;
//            }else{
//                return nil;
//            }
            
            return nil;
            
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
            
            return 0.1;
        }
            break;
            
        case 2:
        {
        

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
         
            return 0.1;
        }
            break;
            
        case 2:
        {
         
            return 0.1;
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
            
  
            
        default:
        {
            return 1;
            
        }
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
                    return 81;
                }
                    break;
                    
                case 1:
                {
                    return 40+ [StringHeight heightWithText:hRitem.speciality font:FONT_14 constrainedToWidth:ScreenWidth-30];
                }
                    break;
                    
                case 2:
                {
                    return 40+ [StringHeight heightWithText:[CommonMethods getServicedComList:hRitem.customerCompany] font:FONT_14 constrainedToWidth:ScreenWidth-30];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
   
            
        default:
        {
            return 44;
            
        }
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
                    
                    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-1, ScreenWidth, 1)];
                    line.backgroundColor = kLineColor;
                    [cell addSubview:line];
                    
                    //头像
                    if (hRitem.photo.length > 0) {
                        

                        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:hRitem.photo] placeholderImage:kDefaultHeadImage];

                    }
                    
                    //姓名
                    cell.nameLabel.text = hRitem.nickname;
                    
                    //ID
                    cell.idLabel.text = [NSString stringWithFormat:@"编号 %@",hRitem.id];
                    
                    //城市
                    cell.disLabel.text = @"城市";
                    
                    CGFloat nameWith = [StringHeight widthtWithText:cell.nameLabel.text font:FONT_14 constrainedToHeight:21];
                    
                    cell.nameLabelWith.constant = nameWith;
                    
                    
                    
                    // 推荐净值
                    
                    NSInteger  value = [[NSString stringWithFormat:@"%@",hRitem.recommend]integerValue];
                    if (value == 0) {
                        
                        value = 1;
                    }
                    
                    if (value > 5) {
                        
                        value = 5;
                        
                    }
                    
                    
                    cell.crownImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"crown_%ld",(long)value]];
                    
              
                    
                    //加关注
                    
                    if ([UserInfo isFocusedHR:[hRitem.id integerValue]] == YES) {
                        [cell.focusButton setTitle:@"取消关注" forState:UIControlStateNormal];
                    }else{
                        [cell.focusButton setTitle:@"加关注" forState:UIControlStateNormal];
                        
                    }
            
                    [cell.focusButton addTarget:self action:@selector(focusOnAction:) forControlEvents:UIControlEventTouchUpInside];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
                    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-1, ScreenWidth, 1)];
                    line.backgroundColor = kLineColor;
                    [cell addSubview:line];
                    
                    cell.titleLabel.text = @"擅长招聘岗位:";
                    cell.titleLabel.textColor = kTextLightGrayColor;
                    cell.titleLabel.font = FONT_14;
                    
                    cell.contentTF.text = hRitem.speciality;
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
                    
                    cell.contentTF.textColor = kBlueColor;
                    cell.contentTF.text = [CommonMethods getServicedComList:hRitem.customerCompany];
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
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountCell"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                UILabel *titleLable = (UILabel*)[cell viewWithTag:100];
                
                UILabel *numLabel = (UILabel*)[cell viewWithTag:101];
                
                
                titleLable.text = @"Ta的人才";
                
                numLabel.text = [NSString stringWithFormat:@"%ld",(long)saleresumesCountSum];
                
                
                
            });
            
            return cell;
            
//            static NSString *cellId = @"RecommendCell";
//            RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//            if (cell == nil) {
//                cell = [[NSBundle mainBundle]loadNibNamed:@"RecommendCell" owner:self options:nil][0];
//            }
//            
//            if (_JDArray.count > 0) {
//                
//                ModelItem *oneItem = [_JDArray firstObject];
//                
//                
//                //头像
//                if (oneItem.photo.length > 0) {
//                    
//                    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.userPhoto] placeholderImage:kDefaultHeadImage];
//                    
//                }
//                
//                //估值
//                
//                NSString *titleStr = [NSString stringWithFormat:@"估值  ¥%.0f",oneItem.price];
//                NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:titleStr];
//                [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 2)];
//                [title addAttribute:NSForegroundColorAttributeName value:kTextLightGrayColor range:NSMakeRange(0, 2)];
//                cell.priceLabel.attributedText = title;
//                
//                
//                //人才名称
//                cell.idLabel.text = [NSString stringWithFormat:@"%@",oneItem.name];
//                
//                
//                //地址&公式名称
//                cell.companyLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,oneItem.currentCompany];
//                
//                //行业&职位
//                cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.currentIndustry,oneItem.currentPosition];
//                
//                
//             return cell;
            

      
            
            
            
            
         }
            break;
            
        case 2:
        {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountCell"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UILabel *titleLable = (UILabel*)[cell viewWithTag:100];
                
                UILabel *numLabel = (UILabel*)[cell viewWithTag:101];
                
                
                titleLable.text = @"Ta的粉丝";
                
                numLabel.text = [NSString stringWithFormat:@"%ld",(long)appraiseNum];
                
                
                
            });
            
            return cell;
//            
//            static NSString *cellId = @"CommentCell";
//            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//            if (cell == nil) {
//                cell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
//            }
//            if (_commentArray.count>0){
//                
//                CommentItem *oneComment = [_commentArray firstObject];
//                
//                //头像
//                if (oneComment.photo.length > 0 ) {
//
//                    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneComment.photo] placeholderImage:kDefaultHeadImage];
//
//                }
//                
//                
//                //姓名
//                cell.nameLabel.text = oneComment.commentUser;
//                
//                //id
//                
//                cell.idLabel.text = [NSString stringWithFormat:@"人才官ID %@",oneComment.userId];
//
//                
//                //time
//                if (oneComment.time.length > 10) {
//                    cell.timeLabel.text = [oneComment.time substringToIndex:10];
//                }else{
//                    cell.timeLabel.text = oneComment.time;
//                }
//                
//                //评论内容
//                
//                cell.commentTF.text = oneComment.comment;
//                
//                return cell;
//                
//            }
        
            
            return nil;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
    
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (indexPath.section == 1) {
        
        [self pushToRecommendTalent];
    }
    
    if (indexPath.section == 2) {
        
        [self pushToRecommendAppraise];
        
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark- 加关注
- (void)focusOnAction:(UIButton *)button{
    
    if ([UserInfo isFocusedHR:[hRitem.id integerValue]] == YES) {
        
        //取消关注
        
        NSDictionary *cancelParam = @{@"hr_id":hRitem.id,@"user_id":[UserInfo getuserid]};
        
        [[TLRequest shareRequest ] tlRequestWithAction:kcancelAttention Params:cancelParam result:^(BOOL isSuccess, id data) {
            
            if (isSuccess) {
                
                
                if (_block) {
                    
                    _block(YES);
                }
                [UserInfo hasFocusedHR:[hRitem.id integerValue]];
                
                [CommonMethods showAlertString:@"取消关注成功" delegate:self tag:66];
                
                
            }
        }];
        
    }else{
        
        //关注
        
        NSDictionary *param = @{@"hr_id":hRitem.id,@"user_id":[UserInfo getuserid]};
        
        [[TLRequest shareRequest]  tlRequestWithAction:kAttentionHr Params:param result:^(BOOL isSuccess, id data) {
            
            if (isSuccess) {
                
                if (_block) {
                    
                    _block(YES);
                }
                
                [UserInfo hasFocusedHR:[hRitem.id integerValue]];
                
                [CommonMethods showAlertString:@"关注成功" delegate:self tag:66];
                
                
            }
        }];
        
        
    }


}

#pragma mark- 推荐的人才
-(void)pushToRecommendTalent{
    
    RecommendTalentTVC *talent = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendTalentTVC"];
    talent.hRitem = hRitem;
    [self.navigationController pushViewController:talent animated:YES];
}

#pragma mark- 推荐的评价
-(void)pushToRecommendAppraise{
    
    RecommendAppraiseTVC *talent = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendAppraiseTVC"];
    talent.hritem = hRitem;
    [self.navigationController pushViewController:talent animated:YES];
}

#pragma mark- alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 66) {
        if (buttonIndex == 0) {
            
            
            [self.tableView reloadData];
        }
    }
}

-(void)setblock:(CancelForcos)block
{
    _block = block;
    
}
@end
