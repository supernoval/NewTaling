//
//  BuyAndCashTVC.h
//  Taling
//
//  Created by ucan on 15/10/9.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BuyAndCashTVC : BaseTableViewController

@property (strong, nonatomic) IBOutlet UITextField *moneyTextField;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UIButton *weChatBtn;
@property (strong, nonatomic) IBOutlet UIButton *alipayBtn;

- (IBAction)wechatAction:(UIButton *)sender;
- (IBAction)alipayAction:(UIButton *)sender;


@property (nonatomic)NSInteger viewType;//1 充值 2 提现

@end
