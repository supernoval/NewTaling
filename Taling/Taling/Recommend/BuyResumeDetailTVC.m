//
//  BuyResumeDetailTVC.m
//  Taling
//
//  Created by ucan on 15/10/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BuyResumeDetailTVC.h"

@interface BuyResumeDetailTVC ()
@property (nonatomic)NSInteger payType;// 1 微信 2 支付宝

@end

@implementation BuyResumeDetailTVC
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买简历";
    _payType = 1;
    
    _wechatButton.selected = YES;
    _alipayButton.selected = NO;
    _payType = 1;
    
    [_wechatButton setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [_wechatButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [_alipayButton setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [_alipayButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    
    self.tableView.tableFooterView = [self tablefooterView];
    NSLog(@"name:%@",self.item.name);
    _name.text = self.item.name;
    _nameWidth.constant = 130;
//    _nameWidth.constant = [StringHeight widthtWithText:self.item.name font:FONT_15 constrainedToHeight:18]+5;
//    if ([self.item.sex isEqualToString:@"男"]) {
//        _sex.image = [UIImage imageNamed:@"male"];
//    }else if ([self.item.sex isEqualToString:@"女"]){
//        _sex.image = [UIImage imageNamed:@"female"];
//    }else{
//        _sex.image = [UIImage imageNamed:@""];
//    }
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tablefooterView{
    
    UIView *footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerview.backgroundColor = [UIColor clearColor];
    
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, ScreenWidth-30, 40)];
    payBtn.clipsToBounds = YES;
    payBtn.layer.cornerRadius = 5.0;
    [payBtn setTintColor:[UIColor whiteColor]];
    payBtn.titleLabel.font = FONT_16;
    [payBtn setTitle:@"确定购买" forState:UIControlStateNormal];
    payBtn.backgroundColor = NavigationBarColor;
    [payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerview addSubview:payBtn];
    return footerview;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.1;
    }
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}



- (void)payAction{
    
    NSLog(@"支付方式：%li",(long)_payType);
    NSString *buy_id = [[NSUserDefaults standardUserDefaults]objectForKey:kusername];
    NSLog(@"username:%@",buy_id);
    NSLog(@"resumeId:%@",self.item.resumesId);
    NSLog(@"userId:%@",self.item.userId);
//    NSString *order_price = self.item.price;
    NSString *order_price = @"0.01";
    
    NSDictionary *param = @{@"resumes_id":self.item.resumesId,@"seller_id":self.item.userId,@"buyer_id":buy_id,@"order_price":order_price};
    
    [[TLRequest shareRequest] tlRequestWithAction:kcreatOrder Params:param result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            
        }
    }];
     
        
        
        
        
}

- (IBAction)wechatAction:(UIButton *)sender {
    _wechatButton.selected = YES;
    _alipayButton.selected = NO;
    _payType = 1;
}

- (IBAction)alipayAction:(UIButton *)sender {
    _wechatButton.selected = NO;
    _alipayButton.selected = YES;
    _payType = 2;
}
@end