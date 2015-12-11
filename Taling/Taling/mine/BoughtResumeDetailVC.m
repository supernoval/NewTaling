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

@interface BoughtResumeDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *commentArry;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger size;

@end

@implementation BoughtResumeDetailVC
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@的简历",item.name];
    self.tableView.backgroundColor = kBackgroundColor;
    
    _commentArry = [[NSMutableArray alloc]init];
    
    _index = 1;
    _size = 5;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    _appraiseWidth.constant = ScreenWidth/2;
    _collectWidth.constant = ScreenWidth/2;
    

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
                UIView *appraiseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
                appraiseView.backgroundColor = [UIColor whiteColor];
                UILabel *appraiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, ScreenWidth-30, 25)];
                appraiseLabel.text = @"评价(15)";
                appraiseLabel.font = FONT_15;
                [appraiseView addSubview:appraiseLabel];
                return appraiseView;
            }else{
                
                return nil;
            }
        }
            break;
            
        default://评价
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
            
            //    UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-1, ScreenWidth, 1)];
            //    gap.backgroundColor = kLineColor;
            //    [blankFooter addSubview:gap];
            
            return blankFooter;
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
            return 50;
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
                
                return 30;
            }else{
                
                return 0.01;
            }
        }
            break;
            
        default://评价
        {
            
            return 80;
            
        }
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
            if (indexPath.row == 0) {
                return 30+[StringHeight heightWithText:item.summary font:FONT_14 constrainedToWidth:ScreenWidth-30];
            }else{
                return 30+[StringHeight heightWithText:[self getResumeExperience] font:FONT_14 constrainedToWidth:ScreenWidth-30];
            }
        }
            break;
            
        case 2:
        {
            return 55;
        }
            break;
            
            
        default://评价
        {
            return 80+[StringHeight heightWithText:@"丰富经历：描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历\n\n专家擅长：主要擅长什么主要擅长什么主要擅长什么主要擅长什么主要擅长什么\n\n关键业绩：关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩\n\n优缺点：你的也有缺点赶紧爆出来你会打篮球吗" font:FONT_14 constrainedToWidth:ScreenWidth-30];
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
                
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:item.photo]];
            }
            
            //人才估值
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",item.price] ;
            
            //姓名
            cell.idLabel.text = item.name;
            
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
                cell = [[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil][0];
            }
            
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"简历概述";
                cell.contentLabel.text = item.summary;
                return cell;
                
            }else if (indexPath.row == 1){
                cell.titleLabel.text = @"经历概述";
                
                cell.contentLabel.text = [self getResumeExperience];
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
                    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneComment.photo]];
                }
                
                
                //姓名
                cell.nameLabel.text = oneComment.commentUser;
                
                //id
                
                //                cell.idLabel.text = [NSString stringWithFormat:@"人才官ID %@",oneComment.];
                
                //time
                if (oneComment.time.length > 10) {
                    cell.timeLabel.text = [oneComment.time substringToIndex:10];
                }else{
                    cell.timeLabel.text = oneComment.time;
                }
                
                //评论内容
                
                //                cell.commentLabel.text = oneComment.comment;
                cell.commentLabel.text = @"丰富经历：描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历\n\n专家擅长：主要擅长什么主要擅长什么主要擅长什么主要擅长什么主要擅长什么\n\n关键业绩：关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩\n\n优缺点：你的也有缺点赶紧爆出来你会打篮球吗";
                
            }
            
            return cell;

        }
            break;
    }
    
    return nil;
}




#pragma mark- 评论分享
- (IBAction)appraiseAction:(UIButton *)sender {
    
    CommentTVC *comment = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentTVC"];
    comment.item = item;
    [self.navigationController pushViewController:comment animated:YES];
}

#pragma mark- 立即联系
- (IBAction)contactAction:(UIButton *)sender {
}
@end
