//
//  SharedResumeTVC.m
//  Taling
//
//  Created by ucan on 15/12/8.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "SharedResumeTVC.h"
#import "SharedCell.h"

@interface SharedResumeTVC ()
{
    NSInteger pageindex;
    NSInteger size;
    NSMutableArray *_JDArray;
}

@end

@implementation SharedResumeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享的简历";
    _JDArray = [[NSMutableArray alloc]init];
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    pageindex = 1;
    size = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)headerRefresh
{
    pageindex = 1;
    
    //        [self getData];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 109;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
    //    return _JDArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //    ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    static NSString *cellId = @"BoughtCell";
    SharedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SharedCell" owner:self options:nil][0];
    }
    
    //    if (_JDArray.count > indexPath.section) {
    
    
    
    //头像
    //        if (oneItem.photo.length > 0) {
    //
    //            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo]];
    //        }
    
    //姓名
    //    cell.nameLabel
    
    //公司&职业
    //    cell.companyLabel
    
    //地点&行业
    //        cell.placeLabel.text = oneItem.name;
    
    // 被购买次数
//            cell.boughtNum.text = [NSString stringWithFormat:@"¥%.2f",oneItem.price] ;
    
    
    //购买自
    
    //        cell.idLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,edu];
    
    
    //时间
    //        cell.timeLabel.text = [NSString stringWithFormat:@"公司:%@",oneItem.currentCompany];
    
    
    //    }
    
    return cell;
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


@end
