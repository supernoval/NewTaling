//
//  BoughtResumeDetailVC.h
//  Taling
//
//  Created by ucan on 15/12/8.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface BoughtResumeDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *appraiseButton;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;
- (IBAction)appraiseAction:(UIButton *)sender;
- (IBAction)contactAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *appraiseWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collectWidth;

@end
