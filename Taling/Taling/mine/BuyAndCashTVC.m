//
//  BuyAndCashTVC.m
//  Taling
//
//  Created by ucan on 15/10/9.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BuyAndCashTVC.h"
#import "PayOrder.h"
@interface BuyAndCashTVC ()

@property (nonatomic)NSInteger payType;// 1 微信 2 支付宝

@end

@implementation BuyAndCashTVC
@synthesize viewType;//1 充值 2 提现

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _weChatBtn.selected = YES;
    _alipayBtn.selected = NO;
    _payType = 1;
    
    [_weChatBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [_weChatBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [_alipayBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [_alipayBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    
    self.tableView.tableFooterView = [self tableFooterView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.viewType == 1) {
        self.title = @"充值";
        _textLabel.text = @"请选择支付方式";
    }else if (self.viewType == 2){
        
        self.title = @"提现";
        _textLabel.text = @"请选择收款方式";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableFooterView{
    
    UIView *footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerview.backgroundColor = [UIColor clearColor];
    
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, ScreenWidth-30, 40)];
    payBtn.clipsToBounds = YES;
    payBtn.layer.cornerRadius = 5.0;
    [payBtn setTintColor:[UIColor whiteColor]];
    payBtn.titleLabel.font = FONT_16;
    [payBtn setTitle:@"确定支付" forState:UIControlStateNormal];
    payBtn.backgroundColor = NavigationBarColor;
    [payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerview addSubview:payBtn];
    return footerview;
}

- (IBAction)wechatAction:(UIButton *)sender {
    _weChatBtn.selected = YES;
    _alipayBtn.selected = NO;
    _payType = 1;
}

- (IBAction)alipayAction:(UIButton *)sender {
    _weChatBtn.selected = NO;
    _alipayBtn.selected = YES;
    _payType = 2;
}

- (void)payAction{
    
    NSLog(@"1充值2体现:%li",(long)self.viewType);
    

    NSLog(@"1微信2支付宝:%li",(long)_payType);
}
@end
