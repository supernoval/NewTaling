//
//  ResumeDetailVC.h
//  Taling
//
//  Created by ucan on 15/10/23.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface ResumeDetailVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)adviceAction:(UIButton *)sender;

- (IBAction)collectAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) IBOutlet UIButton *buyOrAppraiseAction;

@property (nonatomic) NSInteger type;//1 购买 2 评价

@property (nonatomic) NSString *resumes_id; // 简历ID

@property (strong, nonatomic)ModelItem *item;

@property (nonatomic) NSString *VCtitle;

@end
