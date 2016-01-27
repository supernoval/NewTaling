//
//  RecommendAppraiseTVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendAppraiseTVC.h"
#import "CommentCell.h"
#import "CommentItem.h"
#import "HRListCell.h"


@interface RecommendAppraiseTVC (){
    NSInteger pageIndex;
    
    NSInteger pageSize;
    
    NSMutableArray *_commentArray;
    
    NSInteger index;
    

}

@end

@implementation RecommendAppraiseTVC
@synthesize hritem;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Ta的粉丝";
    self.view.backgroundColor = kBackgroundColor;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    _commentArray = [[NSMutableArray alloc]init];
    pageSize = 20;
    
    pageIndex = 1;
    
    [self getFocosMe];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headerRefresh{
    pageIndex = 1;
    
    [self getFocosMe];
    
    
}
- (void)footerRefresh{
    
    pageIndex ++;
   [self getFocosMe];
}

#pragma mark - 获取关注我的用户
-(void)getFocosMe
{
    NSDictionary *param = @{@"user_id":hritem.id,@"index":@(pageIndex),@"size":@(pageSize),@"type":@(2)};
    
    [[TLRequest shareRequest ] tlRequestWithAction:kgetAttention Params:param result:^(BOOL isSuccess, id data) {
        
        
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
                HRItem *item = [[HRItem alloc]init];
                [item setValuesForKeysWithDictionary:oneDic];
                
                
                [array addObject:item];
            
                
             }
            
            
            
            if (pageIndex == 1)
            {
                
                [_commentArray removeAllObjects];
                
            }
            
            [_commentArray addObjectsFromArray:array];
            
            [self.tableView reloadData];
            
         
            
        }
    }];
    
}
#pragma mark - 获取推荐的评价
-(void)getAppraise
{
    
    NSDictionary *param = @{@"user_id":hritem.id,@"index":@(pageIndex),@"size":@(pageSize)};
    
    
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
            
            
            
            if (pageIndex == 1)
            {
                
                [_commentArray removeAllObjects];
                
            }
            
            [_commentArray addObjectsFromArray:array];
            
            [self.tableView reloadData];
            
        }
        
    }];
}


#pragma mark - UITableViewDataSource


#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.8)];
    
    blankFooter.backgroundColor = [UIColor clearColor];
    
    return blankFooter;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.8;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117;
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _commentArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"HRListCell";
    HRListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"HRListCell" owner:self options:nil][0];
    }
    
    cell.userInteractionEnabled = NO;
    
    if (_commentArray.count > indexPath.section) {
        HRItem *oneItem = [_commentArray objectAtIndex:indexPath.section];
        //头像
        if (oneItem.photo.length > 0) {
            
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo] placeholderImage:kDefaultHeadImage];
        }
        else
        {
            cell.headImageView.image = kDefaultHeadImage;
            
        }
        
        
        //姓名
        
        
        NSString *sex = @"";
        
        if ([oneItem.sex isEqualToString:@"0"]) {
            
            sex = @"女";
        }
        else if ([oneItem.sex isEqualToString:@"1"])
        {
            sex = @"男";
        }
        else
        {
            sex = @"";
        }
        
        if (!oneItem.nickname) {
            
            oneItem.nickname = @"";
        }
        
        if (sex.length > 0) {
            
            cell.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",oneItem.nickname,sex];
        }
        else
        {
            cell.nameLabel.text = oneItem.nickname;
            
        }
        
        
        

        
        
        // 推荐净值
        
        NSString *value = [NSString stringWithFormat:@"%@",oneItem.recommend];
        if (value.length == 0) {
            
            value = @"1.0";
        }
        
        NSString *titleStr = [NSString stringWithFormat:@"推荐净值  %@",value];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:titleStr];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 4)];
        [title addAttribute:NSForegroundColorAttributeName value:kTextLightGrayColor range:NSMakeRange(0, 4)];
        cell.recomValue.attributedText = title;
        
        //ID  城市  服务过的企业
        if (!oneItem.city) {
            
            oneItem.city = @"";
            
        }
        if (!oneItem.industry) {
            
            oneItem.industry = @"";
            
        }
        cell.idLabel.text = [NSString stringWithFormat:@"编号%@ %@ 所在行业:%@",oneItem.id,oneItem.city,oneItem.industry];
        
        //擅长行业
        
        if (!oneItem.speciality) {
            
            oneItem.speciality = @"";
            
        }
        cell.disLabel.text = [NSString stringWithFormat:@"擅长行业:%@",oneItem.speciality];
        
        if (!oneItem.city) {
            
            oneItem.city = @"";
        }
        
        
        
        
        //服务过的企业
        cell.servicedCom.text = [CommonMethods getServicedComList:oneItem.customerCompany];
        
        
    }
    
    return cell;
}



//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//    if (_commentArray.count>section) {
//        
//        float tagWidth = (ScreenWidth-30-3*TagGap)/4;
//        float tagHeight = 24;
//        CommentItem *commentItem = [_commentArray objectAtIndex:section];
//        NSArray *labelArray =[CommonMethods sepretTheAppraiseLabel:commentItem.lable];
//        NSInteger count = labelArray.count;
//        NSInteger tagRow;
//        if (count%4 == 0) {
//            tagRow = count/4;
//        }else{
//            tagRow = count/4 + 1;
//        }
//        
//        UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 34*tagRow+0.5)];
//        
//        blankFooter.backgroundColor = [UIColor whiteColor];
//        for (NSInteger i = 0; i < count; i++) {
//            NSString *oneLabel = [labelArray objectAtIndex:i];
//            
//            TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
//            tagLabel.text = oneLabel;
//            [blankFooter addSubview:tagLabel];
//            
//        }
//        UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-0.5, ScreenWidth, 1)];
//        gap.backgroundColor = kLineColor;
//        [blankFooter addSubview:gap];
//        
//        return blankFooter;
//        
//        
//        
//    }else{
//        return nil;
//    }
//
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (_commentArray.count >section) {
//        
//        CommentItem *oneItem = [_commentArray objectAtIndex:section];
//        NSInteger count = [CommonMethods sepretTheAppraiseLabel:oneItem.lable].count;
//        NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
//        if (tagRow>0) {
//            return 34*tagRow+5;
//        }else{
//            return 34*tagRow+0.1;
//        }
//
//        
//    }else{
//        return 0.0;
//    }
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 0.1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//    
//}
//
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if (_commentArray.count>indexPath.section) {
//        CommentItem *oneItem = [_commentArray objectAtIndex:indexPath.section];
//        return 78+[StringHeight heightWithText:oneItem.comment font:FONT_14 constrainedToWidth:ScreenWidth-30];
//    }else{
//        return 0;
//    }
//}
//
//
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _commentArray.count;
//}




//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    static NSString *cellId = @"CommentCell";
//    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
//    }
//    
//    if (_commentArray.count> indexPath.section){
//        
//        CommentItem *oneComment = [_commentArray objectAtIndex:indexPath.section];
//        
//        //头像
//        if (oneComment.photo.length > 0 ) {
//            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneComment.photo] placeholderImage:kDefaultHeadImage];
//        }
//        
//        
//        //姓名
//        cell.nameLabel.text = oneComment.commentUser;
//        
//        //id
//        
//        cell.idLabel.text = [NSString stringWithFormat:@"人才官ID %@",oneComment.userId];
//        
//        
//        //time
//        if (oneComment.time.length > 10) {
//            cell.timeLabel.text = [oneComment.time substringToIndex:10];
//        }else{
//            cell.timeLabel.text = oneComment.time;
//        }
//        
//        //评论内容
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            cell.commentTF.text = oneComment.comment;
//        });
//        
//        
//    }
//
//    
//    return cell;
//}


@end
