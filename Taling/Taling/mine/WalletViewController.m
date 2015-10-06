//
//  WalletViewController.m
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "WalletViewController.h"

@interface WalletViewController ()

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包";
    self.view.backgroundColor = kContentColor;
    _recharge.clipsToBounds = YES;
    _recharge.layer.cornerRadius = 5.0;
    _cashButton.clipsToBounds = YES;
    _cashButton.layer.cornerRadius = 5.0;
    _cashButton.layer.borderWidth = 1.0;
    _cashButton.layer.borderColor = kLineColor.CGColor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-充值
- (IBAction)rechargeAction:(UIButton *)sender {
}

#pragma mark-提现
- (IBAction)cashAction:(UIButton *)sender {
}
@end
