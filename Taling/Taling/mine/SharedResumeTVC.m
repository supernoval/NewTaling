//
//  SharedResumeTVC.m
//  Taling
//
//  Created by ucan on 15/12/8.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "SharedResumeTVC.h"
#import "SharedCell.h"
#import "BoughtResumeDetailVC.h"

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
    self.title = @"分享的人才";
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


-(void)getData
{
    
    NSString *userid = [UserInfo getuserid];
    
    NSDictionary *param = @{@"user_id":userid,@"index":@(pageindex),@"size":@(size)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetMyResumes Params:param result:^(BOOL isSuccess, id data) {
        
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
            
            
        }else
        {
            
        }
        
    }];
    
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
    
    return 70+[StringHeight heightWithText:text font:FONT_13 constrainedToWidth:ScreenWidth-151];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _JDArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellId = @"SharedCell";
    SharedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SharedCell" owner:self options:nil][0];
    }
    
        if (_JDArray.count > indexPath.section) {
            
            ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    
    
    
    //头像
            if (oneItem.photo.length > 0) {
    
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo] placeholderImage:kDefaultHeadImage];
            }
    
    //姓名
            cell.nameLabel.text = oneItem.name;
            
            
    
    //公司&职业
        cell.companyLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.currentCompany,oneItem.currentPosition];
    
    //地点&行业
            cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,oneItem.currentIndustry];
    
     //被购买次数
            cell.boughtNum.text = [NSString stringWithFormat:@"%li",(long)oneItem.buyNum] ;
    
    
    //最近购买
            
            cell.buyTitleLabel.hidden = YES;
    
            cell.nearestBuy.hidden = YES;
    
    
    //时间
            cell.timeLabel.hidden = YES;;
    
    
        }
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _JDArray.count) {
        
        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
        
        BoughtResumeDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BoughtResumeDetailVC"];
        
        detail.item = oneItem;
        [self.navigationController pushViewController:detail animated:YES];
        
        
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
