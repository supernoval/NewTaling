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
    
    NSDictionary *hrInfo = [_hrdataArray objectAtIndex:indexPath.section];
    
    cell.nameLabel.text = [hrInfo objectForKey:@"username"];
    
    
    
    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    HrDetailViewController *_detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HrDetailViewController"];
    
    
    _detailVC.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:_detailVC animated:YES];
    
    
    
    
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
                [_hrdataArray addObjectsFromArray:dataArray];
                
                
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
