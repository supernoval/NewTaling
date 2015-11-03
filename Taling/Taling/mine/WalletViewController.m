//
//  WalletViewController.m
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "WalletViewController.h"
#import "BuyAndCashTVC.h"

@interface WalletViewController ()
@property (strong, nonatomic)NSDictionary *walletDic;

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
    _walletDic = [[NSDictionary alloc]init];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getWalletData];
}
#pragma mark- 获取钱包数据
- (void)getWalletData{
    
    NSString *user_id = [UserInfo getuserid];
    NSDictionary *param = @{@"user_id":user_id};
    [[TLRequest shareRequest]tlRequestWithAction:kGetAuthMoney Params:param result:^(BOOL isSuccess, id data){
        
        if (isSuccess) {
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                _walletDic = data;
                _moneyLabel.text = [NSString stringWithFormat:@"¥%@",[_walletDic objectForKey:@"money"]];
            }
            
        }
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-充值
- (IBAction)rechargeAction:(UIButton *)sender {
    
    BuyAndCashTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyAndCashTVC"];
    buy.viewType = 1;
    [self.navigationController pushViewController:buy animated:YES];
}

#pragma mark-提现
- (IBAction)cashAction:(UIButton *)sender {
    
    BuyAndCashTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyAndCashTVC"];
    buy.viewType = 2;
    [self.navigationController pushViewController:buy animated:YES];
}
@end
