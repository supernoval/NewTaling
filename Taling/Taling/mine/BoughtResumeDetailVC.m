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
#import "CommentItem.h"
#import "ContactTVC.h"

@interface BoughtResumeDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)NSMutableArray *commentArry;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger size;

@end

@implementation BoughtResumeDetailVC
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人才详情";
    self.tableView.backgroundColor = kBackgroundColor;
    
    _commentArry = [[NSMutableArray alloc]init];
    
    _index = 1;
    _size = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    _appraiseWidth.constant = ScreenWidth/2;
    _collectWidth.constant = ScreenWidth/2;
    
    
    
    
    
    
    
    
    [self headerRefresh];
//    [self getData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}



- (void)headerRefresh{
    _index = 1;
    [self getData];
}
- (void)footerRefresh{
    
    _index ++;
    [self getData];
}

-(void)getData
{
    
    
    if (!item.resumesId) {
        
        return;
        
    }
    NSDictionary *param = @{@"resumes_id":@(item.resumesId),@"index":@(_index),@"size":@(_size)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetAppraise Params:param result:^(BOOL isSuccess, id data) {
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        if (isSuccess) {
            
            NSArray *dataArray = [[NSArray alloc]init];//请求获取到的数据
            
            NSMutableArray *array = [[NSMutableArray alloc]init];//解析后的数据
            
            if ([data isKindOfClass:[NSArray class]]) {
                dataArray = data;
            }
            
            for (NSInteger i = 0; i < dataArray.count; i++) {
                NSDictionary *oneDic = [dataArray objectAtIndex:i];
                CommentItem *cItem = [[CommentItem alloc]init];
                [cItem setValuesForKeysWithDictionary:oneDic];
                
                
                [array addObject:cItem];
                
                
                
            }
            
            
            
            if (_index == 1)
            {
                
                [_commentArry removeAllObjects];
                
            }
            
            [_commentArry addObjectsFromArray:array];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}


#pragma mark- 经历概述
- (NSString *)getResumeExperience{
    
    //学校
    
    NSString *school = @"毕业学校:";
    if (item.eduexpenrience.count > 0 ) {
        NSDictionary *dic = [self.item.eduexpenrience firstObject];
        school = [NSString stringWithFormat:@"毕业学校:%@",[dic objectForKey:@"school"]];
    }
    
    
    //工作经历
    
    NSString *experienceStr = [NSString stringWithFormat:@"工作经历:%@",[CommonMethods getTheWorkExperience:self.item.workexpenrience]];
    
    
    //办公技巧
    NSString *skillsStr = [NSString stringWithFormat:@"办公技巧:%@",[CommonMethods getTheSkills:self.item.skills]];
    
    NSString *str = [NSString stringWithFormat:@"%@\n%@\n%@",school,experienceStr,skillsStr];
    
    return str;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3+_commentArry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 2;
    }
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
        {
            UIView *view_1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
            view_1.backgroundColor = [UIColor whiteColor];
            UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 50)];
            text.numberOfLines = 0;
            text.font = FONT_13;
            text.textColor = kTextLightGrayColor;
            text.text = [NSString stringWithFormat:@"联系电话:%@\n电子邮箱:%@",item.phone,item.email];
            [view_1 addSubview:text];
            
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            line.backgroundColor = kLineColor;
            [view_1 addSubview:line];
            
            UILabel *oline = [[UILabel alloc]initWithFrame:CGRectMake(0, 49, ScreenWidth, 1)];
            oline.backgroundColor = kLineColor;
            [view_1 addSubview:oline];
            
            
            return view_1;
        }
            break;
            
        case 1:
        {
            return nil;
        }
            break;
            
        case 2:
        {
            if (_commentArry.count > 0) {
                UIView *appraiseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
                appraiseView.backgroundColor = [UIColor whiteColor];
                UILabel *appraiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, ScreenWidth-30, 35)];
                appraiseLabel.text = @"评价";
                appraiseLabel.font = FONT_14;
                [appraiseView addSubview:appraiseLabel];
                UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, appraiseView.frame.size.height-1, ScreenWidth, 1)];
                line.backgroundColor = kLineColor;
                [appraiseView addSubview:line];
                return appraiseView;
            }else{
                
                return nil;
            }
        }
            break;
            
        default://评价
        {
            if (_commentArry.count>0) {
                CommentItem *commentItem = [_commentArry objectAtIndex:section-3];
                
                float tagWidth = (ScreenWidth-30-3*TagGap)/4;
                float tagHeight = 24;
                NSArray *labelArray = [CommonMethods sepretTheAppraiseLabel:commentItem.lable];
                NSInteger count = labelArray.count;
                NSInteger tagRow;
                if (count%4 == 0) {
                    tagRow = count/4;
                }else{
                    tagRow = count/4 + 1;
                }
                
                UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 34*tagRow+10)];
                
                blankFooter.backgroundColor = [UIColor whiteColor];
                for (NSInteger i = 0; i < count; i++) {
                    
                    NSString *oneLabel = [labelArray objectAtIndex:i];
                    TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
                    tagLabel.text = oneLabel;
                    [blankFooter addSubview:tagLabel];
                    
                }
                
                UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-1, ScreenWidth, 1)];
                gap.backgroundColor = kLineColor;
                [blankFooter addSubview:gap];
                
                return blankFooter;
            }else{
                return nil;
            }
            
            
        }
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    
    switch (section) {
        case 0:
        {
            return 69;
        }
            break;
            
        case 1:
        {
            return 0.01;
        }
            break;
            
        case 2:
        {
            if (_commentArry.count > 0) {
                
                return 50;
            }else{
                
                return 0.01;
            }
        }
            break;
            
        default://评价
        {
            if (_commentArry.count >0) {
                
                CommentItem *oneItem = [_commentArry objectAtIndex:section-3];
                NSInteger count = [CommonMethods sepretTheAppraiseLabel:oneItem.lable].count;
                NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
                if (tagRow>0) {
                    return 34*tagRow+15;
                }else{
                    return 34*tagRow;
                }
                
            }else{
                return 0.0;
            }
            
            
        }
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            return 79;
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0) {
                return 40+[StringHeight heightWithText:[CommonMethods getTopsentences:item.topsentences] font:FONT_14 constrainedToWidth:ScreenWidth-30];
            }else{
                return 40+[StringHeight heightWithText:[self getResumeExperience] font:FONT_14 constrainedToWidth:ScreenWidth-30];
            }
        }
            break;
            
        case 2:
        {
            return 69;
        }
            break;
            
            
        default://评价
        {
            if (_commentArry.count>0) {
                CommentItem *oneItem = [_commentArry objectAtIndex:indexPath.section-3];
                return 78+[StringHeight heightWithText:oneItem.comment font:FONT_14 constrainedToWidth:ScreenWidth-30];
            }else{
                return 0;
            }
            
        }
            break;
    }
    
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
            if (item.photo.length > 0) {
                
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:item.userPhoto] placeholderImage:kDefaultHeadImage];
                
            }
            
            //估值
            
            NSString *titleStr = [NSString stringWithFormat:@"估值  ¥%.0f",item.price];
            NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:titleStr];
            [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 2)];
            [title addAttribute:NSForegroundColorAttributeName value:kTextLightGrayColor range:NSMakeRange(0, 2)];
            cell.priceLabel.attributedText = title;
            
            
            //人才名称
            cell.idLabel.text = [NSString stringWithFormat:@"%@",item.name];
            
            
            //地址&公式名称
            cell.companyLabel.text = [NSString stringWithFormat:@"%@ %@",item.city,item.currentCompany];
            
            //行业&职位
            cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",item.currentIndustry,item.currentPosition];
            
            
            return cell;
            
            
        }
            break;
            
        case 1:
        {
           
            
            if (indexPath.row == 0) {
                static NSString *cellId = @"SummaryCell";
                SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell == nil) {
                    cell = [[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil][0];
                }
                
                cell.titleLabel.text = @"人才概述";
                cell.contentTF.text = [CommonMethods getTopsentences:item.topsentences];
                return cell;
                
            }else if (indexPath.row == 1){
                static NSString *cellId = @"SummaryCellExperence";
                SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell == nil) {
                    cell = [[NSBundle mainBundle]loadNibNamed:@"SummaryCell" owner:self options:nil][0];
                }

                cell.titleLabel.text = @"经历概述";
                
                cell.contentTF.text = [self getResumeExperience];
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
            if (item.userPhoto.length>0) {
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:item.userPhoto] placeholderImage:kDefaultHeadImage];
            }
            
            cell.nameLabel.text = [NSString stringWithFormat:@"人才官ID %@",item.userId];
            cell.disLabel.text = @"人才官";
            //加关注
            
            if ([UserInfo isFocusedHR:[item.userId integerValue]] == YES) {
                [cell.focusButton setTitle:@"取消关注" forState:UIControlStateNormal];
            }else{
                [cell.focusButton setTitle:@"加关注" forState:UIControlStateNormal];
                
            }
            
            [cell.focusButton addTarget:self action:@selector(focusOnAction:) forControlEvents:
             UIControlEventTouchUpInside];
            
            UILabel *line_0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            line_0.backgroundColor = kLineColor;
            [cell addSubview:line_0];
            
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-1, ScreenWidth, 1)];
            line.backgroundColor = kLineColor;
            [cell addSubview:line];
            return cell;
            
            
        }
            break;
            
            
        default://评价
        {
            static NSString *cellId = @"CommentCell";
            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (_commentArry.count > 0) {
                
                CommentItem *oneComment = [_commentArry objectAtIndex:(indexPath.section-3)];
                
                //头像
                if (oneComment.photo.length > 0 ) {
                    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneComment.photo] placeholderImage:kDefaultHeadImage];
                }
                
                
                //姓名
                cell.nameLabel.text = oneComment.commentUser;
                
                //id
                
                cell.idLabel.text = [NSString stringWithFormat:@"人才官ID %@",oneComment.userId];
                
                //time
                if (oneComment.time.length > 10) {
                    cell.timeLabel.text = [oneComment.time substringToIndex:10];
                }else{
                    cell.timeLabel.text = oneComment.time;
                }
                
                //评论内容
                
                cell.commentTF.text = oneComment.comment;
                
            }
            
            return cell;

        }
            break;
    }
    
    return nil;
}

#pragma mark- 加关注
- (void)focusOnAction:(UIButton *)button{
    
    if ([UserInfo isFocusedHR:[item.userId integerValue]] == YES) {
        
        //取消关注
        
        NSDictionary *cancelParam = @{@"hr_id":item.userId,@"user_id":[UserInfo getuserid]};
        
        [[TLRequest shareRequest ] tlRequestWithAction:kcancelAttention Params:cancelParam result:^(BOOL isSuccess, id data) {
            
            if (isSuccess) {
                
                [UserInfo hasFocusedHR:[item.userId integerValue]];
                
                [CommonMethods showAlertString:@"取消关注成功" delegate:self tag:66];
                
                
            }
        }];
        
    }else{
        
        //关注
        
        NSDictionary *param = @{@"hr_id":item.userId,@"user_id":[UserInfo getuserid]};
        
        [[TLRequest shareRequest]  tlRequestWithAction:kAttentionHr Params:param result:^(BOOL isSuccess, id data) {
            
            if (isSuccess) {
                [UserInfo hasFocusedHR:[item.userId integerValue]];
                
                [CommonMethods showAlertString:@"关注成功" delegate:self tag:66];
                
                
            }
        }];
        
        
    }
    
    
}



#pragma mark- 评论分享
- (IBAction)appraiseAction:(UIButton *)sender {
    
    CommentTVC *comment = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentTVC"];
    comment.item = item;
    
    [comment setblock:^(BOOL success) {
       
        if (success) {
            
            if (_commentArry.count > _size) {
                
               _index ++;
            }
        
            
            [self getData];
            
        }
        
    }];
    [self.navigationController pushViewController:comment animated:YES];
}

#pragma mark- 立即联系
- (IBAction)contactAction:(UIButton *)sender {
    ContactTVC *contact = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactTVC"];
    contact.oneItem = item;
    [self.navigationController pushViewController:contact animated:YES];
}

#pragma mark- alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 66) {
        if (buttonIndex == 0) {
            
            
            [self.tableView reloadData];
        }
    }
}
@end
