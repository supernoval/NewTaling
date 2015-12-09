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

@interface HRListTableViewController ()<UISearchBarDelegate>
{
    NSMutableArray * _hrdataArray;
    
    NSInteger index;
    NSInteger pageSize;
    
    UISearchBar *_searchBar;
    
    
    
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
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"姓名、城市、行业";
    self.navigationItem.titleView = _searchBar;
    
    
    
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



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 71;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hrdataArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HRListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    
//    HRItem *hrInfo = [_hrdataArray objectAtIndex:indexPath.row];
//    
//    
//    NSString *username = hrInfo.username;
//    NSString *company = hrInfo.company;
//    NSString *industry = hrInfo.industry;
//    
//    
//    if (username.length == 0) {
//        
//        username = [NSString stringWithFormat:@"匿名用户%ld",(long)indexPath.row];
//    }
//    
//    if (company.length == 0) {
//        
//        company = [NSString stringWithFormat:@"未填写公司"];
//    }
//    
//    if (industry.length == 0) {
//        
//        industry = [NSString stringWithFormat:@"未填写行业"];
//        
//    }
//    
//    
//    cell.nameLabel.text = username;
//    cell.compayLabel.text = [NSString stringWithFormat:@"%@ %@",company,industry];

    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row < _hrdataArray.count) {
        
        HRItem *_hrItem = [_hrdataArray objectAtIndex:indexPath.row];
        
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
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
       
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


#pragma mark -  UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    SearchHRTVC *searchTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchHRTVC"];
//    
//    
//    searchTVC.hidesBottomBarWhenPushed =YES;
//    
//    [self.navigationController pushViewController:searchTVC animated:YES];
    
    
    return NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    [self.view removeGestureRecognizer:_tap];
    
    //    [searchBar resignFirstResponder];
    
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    
    
    
    
    //    [self.view addGestureRecognizer:_tap];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
