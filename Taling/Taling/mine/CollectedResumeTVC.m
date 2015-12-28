//
//  CollectedResumeTVC.m
//  Taling
//
//  Created by ucan on 15/12/8.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CollectedResumeTVC.h"
#import "UIImageView+WebCache.h"
#import "RecommendCell.h"
#import "TagLabel.h"
#import "RecommendDetailVC.h"

@interface CollectedResumeTVC ()
{
    NSInteger pageindex;
    NSInteger size;
    
    NSMutableArray *_JDArray;
}

@end

@implementation CollectedResumeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏的人才";
    _JDArray = [[NSMutableArray alloc]init];
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    pageindex = 1;
    size = 10;
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)headerRefresh
{
    pageindex = 1;
    
    [self getData];
    
}

-(void)footerRefresh
{
    pageindex ++;
    
    [self getData];
    
}
#pragma mark - 获取收藏的简历
-(void)getData
{
    NSString *user_id = [UserInfo getuserid];
    
    NSDictionary *param = @{@"user_id":user_id,@"index":@(pageindex),@"size":@(size)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kGetReservResumes Params:param result:^(BOOL isSuccess, id data) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (isSuccess) {
            
            NSArray *dataArray = [[NSArray alloc]init];//请求获取到的数据
            
            NSMutableArray *array = [[NSMutableArray alloc]init];//解析后的数据
            
            if ([data isKindOfClass:[NSArray class]]) {
                dataArray = data;
            }
            
            for (NSInteger i = 0; i < dataArray.count; i++) {
                NSDictionary *oneDic = [dataArray objectAtIndex:i];
                ModelItem *item = [[ModelItem alloc]init];
                [item setValuesForKeysWithDictionary:oneDic];
                
                [array addObject:item];
                
                
                
            }
            
            if (pageindex == 1)
            {
                
                [_JDArray removeAllObjects];
                
            }
            
            [_JDArray addObjectsFromArray:array];
            
            [self.tableView reloadData];
            
            
            
        }
        else
        {
            
        }
        
    }];
    
}
#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_JDArray.count > section) {
        ModelItem *oneItem = [_JDArray objectAtIndex:section];
        
        float tagWidth = (ScreenWidth-30-3*TagGap)/4;
        float tagHeight = 30;
        NSInteger count = oneItem.resumesLabel.count;
        NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
        
        UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*tagRow)];
        
        blankFooter.backgroundColor = [UIColor whiteColor];
        for (NSInteger i = 0; i < count; i++) {
            NSDictionary *oneLabel = [oneItem.resumesLabel objectAtIndex:i];
            
            TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
            tagLabel.text = [NSString stringWithFormat:@"%@",[oneLabel objectForKey:@"word"]];
            [blankFooter addSubview:tagLabel];
            
        }
        
        
        UIButton *detailAction = [[UIButton alloc]initWithFrame:blankFooter.frame];
        [detailAction addTarget:self action:@selector(pushToDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        detailAction.tag = section;
        [blankFooter addSubview:detailAction];
        
        return blankFooter;
    }
    
    return nil;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_JDArray.count > section) {
        ModelItem *oneItem = [_JDArray objectAtIndex:section];
        NSInteger count = oneItem.resumesLabel.count;
        NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
        return 40*tagRow;
    }
    
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    //公司&职业
    NSString *text = [NSString stringWithFormat:@"%@ %@",oneItem.currentCompany,oneItem.currentPosition];
    
    return 57+[StringHeight heightWithText:text font:FONT_14 constrainedToWidth:ScreenWidth-153];

}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _JDArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"RecommendCell";
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RecommendCell" owner:self options:nil][0];
    }
    
    if (_JDArray.count > indexPath.section) {
        
        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
        
        //头像
        if (oneItem.photo.length > 0) {
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo] placeholderImage:kDefaultHeadImage];
        }
        
        //人才估值
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",oneItem.price];
        
        //简历ID
        cell.idLabel.text = [NSString stringWithFormat:@"人才ID %li",(long)oneItem.resumesId];
        
        
        //公司&职业
        cell.companyLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.currentCompany,oneItem.currentPosition];
        
        //城市&行业
        cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,oneItem.currentIndustry];
        
        
        
    }
    
    return cell;

}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _JDArray.count) {
        
        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
        
        NSInteger resumesId = oneItem.resumesId;
        
        
        if (resumesId) {
            
            RecommendDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendDetailVC"];
            detail.item = oneItem;
            [self.navigationController pushViewController:detail animated:YES];
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
- (void)pushToDetailAction:(UIButton *)btn{
    
    RecommendDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendDetailVC"];
    ModelItem *oneItem = [_JDArray objectAtIndex:btn.tag];
    detail.item = oneItem;
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
