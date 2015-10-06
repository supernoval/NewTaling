//
//  WalletViewController.h
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface WalletViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;

@property (strong, nonatomic) IBOutlet UIButton *recharge;

- (IBAction)rechargeAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *cashButton;
- (IBAction)cashAction:(UIButton *)sender;

@end
