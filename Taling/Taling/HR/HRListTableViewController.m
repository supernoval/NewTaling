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
    
}



@end

@implementation HRListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _hrdataArray = [[NSMutableArray alloc]init];
    
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 10;
    
    return _hrdataArray;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HRListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    
    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    HrDetailViewController *_detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HrDetailViewController"];
    
    
    _detailVC.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:_detailVC animated:YES];
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
