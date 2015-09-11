//
//  OrderListViewController.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/6.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderListViewController : BaseViewController
- (IBAction)switchOrderList:(id)sender;
@property ( nonatomic)  UITableView *tableView;

@end
