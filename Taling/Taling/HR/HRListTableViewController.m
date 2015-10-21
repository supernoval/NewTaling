//
//  HRListTableViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/10/17.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "HRListTableViewController.h"
#import "HrDetailViewController.h"
#import "HRListCell.h"
#import "HRItem.h"

NSString *cellID = @"HRListCell";

@interface HRListTableViewController ()
{
    NSMutableArray * _hrdataArray;
    
    NSInteger index;
    NSInteger pageSize;
    
    
    
}



@end

@implementation HRListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _hrdataArray = [[NSMutableArray alloc]init];
    
    [self addHeaderRefresh];
    
    [self addFooterRefresh];
    
    pageSize = 10;
    
    index = 1;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestHRList];
    
}

-(void)headerRefresh
{
    index = 1;
    
    [self requestHRList];
    
    
}

-(void)footerRefresh
{
    index ++ ;
    
    [self requestHRList];
    
}


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    
    footer.backgroundColor = [UIColor clearColor];
    
    
    return footer;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    return _hrdataArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HRListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    HRItem *hrInfo = [_hrdataArray objectAtIndex:indexPath.section];
    
    
    NSString *username = hrInfo.username;
    NSString *company = hrInfo.company;
    NSString *industry = hrInfo.industry;
    
    
    if (username.length == 0) {
        
        username = [NSString stringWithFormat:@"匿名用户%ld",(long)indexPath.section];
    }
    
    if (company.length == 0) {
        
        company = [NSString stringWithFormat:@"未填写公司"];
    }
    
    if (industry.length == 0) {
        
        industry = [NSString stringWithFormat:@"未填写行业"];
        
    }
    
    
    cell.nameLabel.text = username;
    cell.compayLabel.text = company;
    cell.proffessionLabel.text = industry;
    
    
    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section < _hrdataArray.count) {
        
        HRItem *_hrItem = [_hrdataArray objectAtIndex:indexPath.section];
        
        HrDetailViewController *_detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HrDetailViewController"];
        
        
        _detailVC.hidesBottomBarWhenPushed = YES;
        
        _detailVC.hrInfoItem = _hrItem;
        
        
        [self.navigationController pushViewController:_detailVC animated:YES];
        
    }
    
 
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - 请求数据
-(void)requestHRList
{
    NSDictionary *param =@{@"index":@(index),@"size":@(pageSize)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetHrInfo Params:param result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            
            
            NSArray *dataArray = data;
            
            if (dataArray.count > 0) {
                
                if (index == 1) {
                    
                    [_hrdataArray removeAllObjects];
                    
                }
                
                
                for (int i = 0;  i < dataArray.count; i++) {
                    
                    NSDictionary *oneHR = [dataArray objectAtIndex:i];
                    HRItem *item = [[HRItem alloc]init];
                    
                    [item setValuesForKeysWithDictionary:oneHR];
                    
                    [_hrdataArray addObject:item];
                    
                    
                }
                
                
                
                
                [self.tableView reloadData];
                
            }
        }
        
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
