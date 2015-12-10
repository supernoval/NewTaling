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

@interface RecommendDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *commentArry;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger size;

@end

@implementation RecommendDetailVC
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.title = @"简历详情";
    
    _commentArry = [[NSMutableArray alloc]init];
    
    _index = 1;
    _size = 5;
    
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
            
            if (_index == 1)
            {
                
                [_commentArry removeAllObjects];
                
            }
            
            [_commentArry addObjectsFromArray:data];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}


#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section > 2) {
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
        return blankFooter;
    }else{
        return nil;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 3) {
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
        return blankFooter;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section > 2) {
        return 80;
    }
    return 0.8;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_commentArry.count > 0) {
        if (section == 3) {
            return 40;
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
    
    switch (indexPath.section) {
        case 0:
        {
            //公司&职业
            NSString *text = [NSString stringWithFormat:@"%@ %@",item.currentCompany,item.currentPosition];
            
            return 57+[StringHeight heightWithText:text font:FONT_14 constrainedToWidth:ScreenWidth-153];
            
        }
            break;
            
        case 1:
        {
            return 40+[StringHeight heightWithText:item.summary font:FONT_14 constrainedToWidth:ScreenWidth-30];
        }
            break;
            
        case 2:
        {
            return 55;
        }
            break;
            
            
        default:
        {
            
            return 80+[StringHeight heightWithText:@"丰富经历：描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历\n\n专家擅长：主要擅长什么主要擅长什么主要擅长什么主要擅长什么主要擅长什么\n\n关键业绩：关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩\n\n优缺点：你的也有缺点赶紧爆出来你会打篮球吗" font:FONT_14 constrainedToWidth:ScreenWidth-30];
        }
            break;
    }
   
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3+_commentArry.count;
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
            if (item.photo.length > 0) {
                
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:item.photo]];
            }
            
            
            //人才估值
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",item.price];
            
            //简历ID
            cell.idLabel.text = [NSString stringWithFormat:@"简历ID %li",(long)item.resumesId];
            
            
            //公司&职业
            cell.companyLabel.text = [NSString stringWithFormat:@"%@ %@",item.currentCompany,item.currentPosition];
            
            //城市&行业
            cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",item.city,item.currentIndustry];
            
            
            
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
            cell.contentLabel.text = item.summary;
            
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
            
            
            //头像
            //            cell.headImageView
            
            //姓名
            //            cell.nameLabel
            
            //id
            //            cell.idLabel
            
            //time
            //            cell.timeLabel
            
            //评论内容
            cell.commentLabel.text = @"丰富经历：描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历\n\n专家擅长：主要擅长什么主要擅长什么主要擅长什么主要擅长什么主要擅长什么\n\n关键业绩：关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩\n\n优缺点：你的也有缺点赶紧爆出来你会打篮球吗";
            return cell;
        }
            break;
    }
    
    
    return nil;
}

#pragma mark- 关注人才官
- (void)focusOnTheHR:(UIButton *)button{
    
    self.view.backgroundColor = [UIColor redColor];
}


- (IBAction)collecAction:(UIButton *)sender {
}

- (IBAction)buyAction:(id)sender {
    
    //公司购买
//    ComBuyResumeDetailTVC *comBuy = [self.storyboard instantiateViewControllerWithIdentifier:@"ComBuyResumeDetailTVC"];
    
    //个人购买
    BuyResumeDetailTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyResumeDetailTVC"];
    buy.item = item;
    [self.navigationController pushViewController:buy animated:YES];
}
@end
