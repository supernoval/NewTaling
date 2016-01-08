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
#import "ComBuyResumeDetailTVC.h"
#import "CommentItem.h"

@interface RecommendDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)NSMutableArray *commentArry;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger size;

@end

@implementation RecommendDetailVC
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.title = @"人才详情";
    
    _commentArry = [[NSMutableArray alloc]init];
    
    _index = 1;
    _size = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _collectWidth.constant = ScreenWidth/2;
    _buyWidth.constant = ScreenWidth/2;
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    NSInteger zanZhuNum = _commentArry.count + 3;
    if (section == zanZhuNum) {
        
        return nil;
        
    }
    
    
    switch (section) {
        case 0:
        {
            return nil;
        }
            break;
            
        case 1:
        {
            return nil;
        }
            break;
            
        case 2:
        {
            return nil;
        }
            break;
            
        default:
        {
            if (_commentArry.count>0) {
                
                float tagWidth = (ScreenWidth-30-3*TagGap)/4;
                float tagHeight = 24;
                CommentItem *commentItem = [_commentArry objectAtIndex:section-3];
                NSArray *labelArray =[CommonMethods sepretTheAppraiseLabel:commentItem.lable];
                NSInteger count = labelArray.count;
                NSInteger tagRow;
                if (count%4 == 0) {
                    tagRow = count/4;
                }else{
                    tagRow = count/4 + 1;
                }
                
                UIView *blankFooter = [[UIView alloc]init];
                
                if (tagRow>0) {
                    blankFooter.frame = CGRectMake(0, 0, ScreenWidth, 34*tagRow+5.5);
                    
                }else{
                    blankFooter.frame = CGRectMake(0, 0, ScreenWidth, 34*tagRow+0.5);
                }
                
                
                
                blankFooter.backgroundColor = [UIColor whiteColor];
                for (NSInteger i = 0; i < count; i++) {
                    NSString *oneLabel = [labelArray objectAtIndex:i];
                    
                    TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
                    tagLabel.text = oneLabel;
                    [blankFooter addSubview:tagLabel];
                    
                }
                            UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-0.5, ScreenWidth, 1)];
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

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSInteger zanZhuNum = _commentArry.count + 3;
    if (section == zanZhuNum) {
        
        return nil;
        
    }
    
    
    if (section == 3) {
        UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        
        blankFooter.backgroundColor = [UIColor whiteColor];
        UILabel *commentNum = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 35)];
        commentNum.text = @"评论";
        commentNum.font = FONT_14;
        commentNum.textColor = [UIColor blackColor];
        [blankFooter addSubview:commentNum];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-1, ScreenWidth, 0.3)];
        line.backgroundColor = kLineColor;
        [blankFooter addSubview:line];
        return blankFooter;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    NSInteger zanZhuNum = _commentArry.count + 3;
    if (section == zanZhuNum) {
        
        return 0.8;
        
    }
    
    switch (section) {
        case 0:
        {
            return 0.8;
        }
            break;
            
        case 1:
        {
            return 0.8;
        }
            break;
            
        case 2:
        {
            return 0.8;
        }
            break;
            
        default:
        {
            if (_commentArry.count>0) {
                CommentItem *oneItem = [_commentArry objectAtIndex:section-3];
                NSInteger count = [CommonMethods sepretTheAppraiseLabel:oneItem.lable].count;
                NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
                if (tagRow>0) {
                    return 34*tagRow+5.5;
                }else{
                    return 34*tagRow+0.5;
                }
            
        
            }else{
                return 0.0;
            }
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSInteger zanZhuNum = _commentArry.count + 3;
    if (section == zanZhuNum) {
        
        return 0.1;
        
    }
    
    if (_commentArry.count > 0) {
        if (section == 3) {
            return 50;
        }
    }
    
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger zanZhuNum = _commentArry.count + 3;
    if (indexPath.section == zanZhuNum) {
        
        return 44;
        
    }
    CommentItem *oneCom = [[CommentItem alloc]init];
    if (indexPath.section > 2 && indexPath.section < _commentArry.count + 3) {
        oneCom = [_commentArry objectAtIndex:indexPath.section-3];
    }
    
    
    switch (indexPath.section) {
        case 0:
        {
            return 79;
            
        }
            break;
            
        case 2:
        {
            CGFloat height  = [StringHeight heightWithText:item.summary font:FONT_14 constrainedToWidth:ScreenWidth-30];
            if (height < 30) {
                height = 30;
                
            }
            return 40+height;
        }
            break;
            
        case 1:
        {
            return 69;
        }
            break;
            
            
        default:
        {
            
            return 78+[StringHeight heightWithText:oneCom.comment font:FONT_14 constrainedToWidth:ScreenWidth-30];
        }
            break;
    }
   
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3+_commentArry.count + 1;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger zanZhuNum = _commentArry.count + 3;
    
    if (indexPath.section == zanZhuNum) {
        
        UITableViewCell *adCell = [tableView dequeueReusableCellWithIdentifier:@"AdCell"];
        
        if (!adCell) {
            
            adCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AdCell"];
            
            
        }
        
        adCell.textLabel.text = @"赞助商";
        adCell.textLabel.font = FONT_13;
        adCell.textLabel.textColor = kLightTintColor;
        
        return adCell;
        
    }
    
    
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
            
        case 2:
        {
            static NSString *cellId = @"SummaryCell";
            SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"SummaryCell" owner:self options:nil][0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //概述
            cell.contentTF.text = item.summary;
            
            return cell;
        }
            break;
            
        case 1:
        {
            static NSString *cellId = @"FocusCell";
            FocusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"FocusCell" owner:self options:nil][0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //头像
            if (item.userPhoto.length>0) {
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:item.userPhoto] placeholderImage:kDefaultHeadImage];
            }
            
            //姓名
            cell.nameLabel.text = [NSString stringWithFormat:@"人才官ID  %@",item.userId];
            
            //人才官
            cell.disLabel.text = @"人才官";
            
            //加关注
            
            if ([UserInfo isFocusedHR:[item.userId integerValue]] == YES) {
                [cell.focusButton setTitle:@"取消关注" forState:UIControlStateNormal];
            }else{
                [cell.focusButton setTitle:@"加关注" forState:UIControlStateNormal];
                
            }
            
            [cell.focusButton addTarget:self action:@selector(focusOnTheHR:) forControlEvents:UIControlEventTouchUpInside];
            
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
                
                cell.idLabel.text = [NSString stringWithFormat:@"ID  %@",oneComment.userId];
                
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

#pragma mark- 关注人才官
- (void)focusOnTheHR:(UIButton *)button{
    
    
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


- (IBAction)collecAction:(UIButton *)sender {
    
    NSString *userid = [UserInfo getuserid];
    
    NSInteger resumeid = self.item.resumesId;
    
    NSDictionary *param = @{@"user_id":userid,@"resumes_id":@(resumeid)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kreservResume Params:param result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"收藏成功"];
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"收藏失败，请重试"];
        }
    }];
}

- (IBAction)buyAction:(id)sender {
    
    if ([UserInfo getIsCompany] == YES) {
        //公司购买
            ComBuyResumeDetailTVC *comBuy = [self.storyboard instantiateViewControllerWithIdentifier:@"ComBuyResumeDetailTVC"];
        comBuy.item = item;
        [self.navigationController pushViewController:comBuy animated:YES];
    }else{
        
        //个人购买
        BuyResumeDetailTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyResumeDetailTVC"];
        buy.item = item;
        [self.navigationController pushViewController:buy animated:YES];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 66) {
        if (buttonIndex == 0) {
            
            
            [self.tableView reloadData];
        }
    }
}
@end
