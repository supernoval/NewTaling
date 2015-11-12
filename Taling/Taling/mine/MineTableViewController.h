//
//  MineTableViewController.h
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MineTableViewController : BaseTableViewController
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *professionLabel;

@property (strong, nonatomic) IBOutlet UILabel *companyLabel;


@property (strong, nonatomic) IBOutlet UILabel *resumeNum;

@property (strong, nonatomic) IBOutlet UILabel *resumeMoney;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *moneyWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberTextWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *moneyTextWidth;
@property (strong, nonatomic) IBOutlet UILabel *bindEmail;

@end
