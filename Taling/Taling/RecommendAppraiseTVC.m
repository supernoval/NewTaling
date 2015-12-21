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

@interface RecommendAppraiseTVC (){
    NSInteger pageIndex;
    
    NSInteger pageSize;
    
    NSMutableArray *_commentArray;
}

@end

@implementation RecommendAppraiseTVC
@synthesize hritem;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐的评价";
    self.view.backgroundColor = kBackgroundColor;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    _commentArray = [[NSMutableArray alloc]init];
    pageSize = 5;
    pageIndex = 1;
    [self getAppraise];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headerRefresh{
    pageIndex = 1;
    [self getAppraise];
}
- (void)footerRefresh{
    
    pageIndex ++;
    [self getAppraise];
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
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (_commentArray.count>section) {
        
        float tagWidth = (ScreenWidth-30-3*TagGap)/4;
        float tagHeight = 30;
        CommentItem *commentItem = [_commentArray objectAtIndex:section];
        NSArray *labelArray =[CommonMethods sepretTheAppraiseLabel:commentItem.lable];
        NSInteger count = labelArray.count;
        NSInteger tagRow;
        if (count%4 == 0) {
            tagRow = count/4;
        }else{
            tagRow = count/4 + 1;
        }
        
        UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*tagRow+0.5)];
        
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_commentArray.count >section) {
        
        CommentItem *oneItem = [_commentArray objectAtIndex:section];
        NSInteger count = [CommonMethods sepretTheAppraiseLabel:oneItem.lable].count;
        NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
        return 40*tagRow;
        
    }else{
        return 0.0;
    }
    
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
    
    if (_commentArray.count>indexPath.section) {
        CommentItem *oneItem = [_commentArray objectAtIndex:indexPath.section];
        return 80+[StringHeight heightWithText:oneItem.comment font:FONT_14 constrainedToWidth:ScreenWidth-30];
    }else{
        return 0;
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _commentArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
    }
    
    if (_commentArray.count> indexPath.section){
        
        CommentItem *oneComment = [_commentArray objectAtIndex:indexPath.section];
        
        //头像
        if (oneComment.photo.length > 0 ) {
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneComment.photo]];
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
        
        cell.commentLabel.text = oneComment.comment;
        
    }

    
    return cell;
}


@end
