//
//  BoughtResumeTVC.m
//  Taling
//
//  Created by ucan on 15/12/8.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BoughtResumeTVC.h"
#import "BoughtCell.h"
#import "BoughtResumeDetailVC.h"


@interface BoughtResumeTVC ()
{
    NSInteger pageindex;
    NSInteger size;
    NSMutableArray *_JDArray;
}

@end

@implementation BoughtResumeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买的人才";
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


//获取购买简历
-(void)getData
{
    NSString *userid = [UserInfo getuserid];
    
    NSDictionary *param = @{@"buy_user_id":userid,@"index":@(pageindex),@"size":@(size)};
    
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetMyBuyResumes Params:param result:^(BOOL isSuccess, id data){
        
        [self endFooterRefresh];
        [self endHeaderRefresh];
        
        
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
    
    return 0.8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
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
    
    return 91+[StringHeight heightWithText:text font:FONT_13 constrainedToWidth:ScreenWidth-151];
   
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return _JDArray.count;

}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"BoughtCell";
    BoughtCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"BoughtCell" owner:self options:nil][0];
    }
    
        if (_JDArray.count > indexPath.section) {
            
        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    
    
    
    //头像
            if (oneItem.photo.length > 0) {
    
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo]];
            }
            
            //人才估值
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",oneItem.price] ;
    
    //姓名
            cell.nameLabel.text = oneItem.name;
    
    //公司&职业
            cell.companyLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.currentCompany,oneItem.currentPosition];
    
    //城市&行业
            cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,oneItem.currentIndustry];
    
     
    
    
    //购买自 ID
    
            cell.idLabel.text = [NSString stringWithFormat:@"人才官 ID%@",oneItem.userId];
    
    
    //时间
            if (oneItem.buyTime.length > 10) {
                cell.timeLabel.text = [oneItem.buyTime substringToIndex:10];
            }else{
                
                cell.timeLabel.text = oneItem.buyTime;
            }
      
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
