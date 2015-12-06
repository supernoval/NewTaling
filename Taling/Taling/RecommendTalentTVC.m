//
//  RecommendTalentTVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendTalentTVC.h"
#import "RecommendCell.h"
#import "RecommendDetailVC.h"
@interface RecommendTalentTVC ()
{
    NSInteger pageindex;
    NSInteger size;
    NSMutableArray *_JDArray;
}

@end

@implementation RecommendTalentTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _JDArray = [[NSMutableArray alloc]init];
    
    self.title = @"推荐的人才";
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    pageindex = 1;
    size = 10;}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)headerRefresh
{
    pageindex = 1;
    
    //        [self getData];
    
    //    [self searchFromTag];
    
    
}

-(void)footerRefresh
{
    pageindex ++;
    
    //    [self getData];
    
}


-(void)getData
{
    
    NSDictionary *param = @{@"index":@(pageindex),@"size":@(size),@"search":@""};
    
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetCommendResumes Params:param result:^(BOOL isSuccess, id data) {
        
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
        
    }];
    
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
    
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*tagRow+1)];
    
    blankFooter.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i < count; i++) {
        
        TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
        tagLabel.text = [NSString stringWithFormat:@"高级%li",(long)i];
        [blankFooter addSubview:tagLabel];
        
    }
    
    //    UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(15, blankFooter.frame.size.height-1, ScreenWidth-15, 1)];
    //    gap.backgroundColor = kLineColor;
    //    [blankFooter addSubview:gap];
    
    UIButton *detailAction = [[UIButton alloc]initWithFrame:blankFooter.frame];
    [detailAction addTarget:self action:@selector(pushToDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    detailAction.tag = section;
    [blankFooter addSubview:detailAction];
    
    return blankFooter;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 73;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
    //    return _JDArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //    ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
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




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendDetailVC"];
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
    
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

- (void)pushToDetailAction:(UIButton *)btn{
    
    RecommendDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendDetailVC"];
    [self.navigationController pushViewController:detail animated:YES];
    
}


@end
