//
//  RecommendTableViewController.h
//  Taling
//
//  Created by ZhuHaikun on 15/8/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SelectView.h"
#import "RecommendCell.h"
#import "RecommendHeaderView.h"
#import "BaseViewController.h"

@interface RecommendTableViewController : BaseViewController
{
    SelectView *_selectedView;
    
}

@property (weak, nonatomic) IBOutlet RecommendHeaderView *recomendHeader;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)  RecommendHeaderView *headerView;

@end
