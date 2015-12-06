//
//  BuyResumeDetailTVC.h
//  Taling
//
//  Created by ucan on 15/10/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BuyResumeDetailTVC : BaseTableViewController

@property (strong, nonatomic)ModelItem *item;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;

@property (strong, nonatomic) IBOutlet UILabel *place;

@property (strong, nonatomic) IBOutlet UILabel *company;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIButton *wechatButton;
@property (strong, nonatomic) IBOutlet UIButton *alipayButton;
- (IBAction)wechatAction:(UIButton *)sender;
- (IBAction)alipayAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *remainPayButton;
- (IBAction)remainPayAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *accountMoney;

@property (strong, nonatomic) IBOutlet UILabel *orderPrice;

@end
