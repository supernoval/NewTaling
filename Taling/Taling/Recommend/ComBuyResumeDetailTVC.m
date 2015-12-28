//
//  ComBuyResumeDetailTVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ComBuyResumeDetailTVC.h"
#import "PayOrder.h"
#import "BoughtResumeTVC.h"
#import "MyCouponTVC.h"

@interface ComBuyResumeDetailTVC ()<UIAlertViewDelegate>
@property (nonatomic)CGFloat payMoney;
@property (nonatomic)NSString *couponId;
@end

@implementation ComBuyResumeDetailTVC
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买人才";
    _payMoney = item.price;
    _couponId = @"";
    
    self.tableView.tableFooterView = [self tablefooterView];
    
    
    
    
    //头像
    if (item.photo.length > 0) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:item.photo]placeholderImage:kDefaultHeadImage];
    }
    
    
    //人才估值
    _price.text = [NSString stringWithFormat:@"¥%.2f",item.price];
    
    //简历ID
    _idLabel.text = [NSString stringWithFormat:@"人才ID %li",(long)item.resumesId];
    
    
    //公司&职业
    _company.text = [NSString stringWithFormat:@"%@ %@",item.currentCompany,item.currentPosition];
    
    //城市&行业
    _place.text = [NSString stringWithFormat:@"%@ %@",item.city,item.currentIndustry];
    
    //需支付
    _orderPrice.text = [NSString stringWithFormat:@"%.2f元",_payMoney];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessNoti) name:kPaySucessNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getWalletData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            //公司&职业
            NSString *text = [NSString stringWithFormat:@"%@ %@",item.currentCompany,item.currentPosition];
            
            return 57+[StringHeight heightWithText:text font:FONT_14 constrainedToWidth:ScreenWidth-153];
        }
            break;
            
            
        default:
        {
            return 44;
        }
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //优惠券
            MyCouponTVC *coupon = [self.storyboard instantiateViewControllerWithIdentifier:@"MyCouponTVC"];
            [self.navigationController pushViewController:coupon animated:YES];
            [coupon chooseCoupon:^(CouponItem *couponItem){
                CGFloat couponMoney = couponItem.couponPrice;
                _couponId = couponItem.id;
                _couponLabel.text = [NSString stringWithFormat:@"%.2f元优惠券",couponMoney];
                
                if (item.price <= couponMoney) {
                    _payMoney = 0.00;
                    _orderPrice.text = [NSString stringWithFormat:@"%.2f元",_payMoney];
                }else{
                    _payMoney = item.price - couponMoney;
                    _orderPrice.text = [NSString stringWithFormat:@"%.2f元",_payMoney];
                    
                }
            }];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)payAction{
    
    NSString *buy_id = [UserInfo getuserid];
    NSLog(@"username:%@",buy_id);
    NSLog(@"userId:%@",self.item.userId);
    float order_price = _payMoney;
    //  _couponId 优惠券ID
    
    NSDictionary *param = @{@"resumes_id":@(self.item.resumesId),@"seller_id":self.item.userId,@"buyer_id":buy_id,@"order_price":@(order_price),@"coupon_id":_couponId};
    
    if ([self.item.userId isEqualToString:buy_id]) {
        [CommonMethods showDefaultErrorString:@"不能购买自己的人才"];
    }else{
        
        [[TLRequest shareRequest] tlRequestWithAction:kcreatOrder Params:param result:^(BOOL isSuccess, id data) {
            
            if (isSuccess) {
                
                
                if (order_price == 0) {
                    
                    
                    [self paySuccessNoti];
                    
                }
                else
                {
                    NSString *orderNO = [data objectForKey:@"orderNo"];
                    NSDictionary *payParam = @{@"order_no":orderNO};
                    [[TLRequest shareRequest]tlRequestWithAction:kBuyResumeByRemaim Params:payParam result:^(BOOL isSuccess, id data){
                            
                            if (isSuccess) {//余额购买成功
                                
                                [self showBuySuccessAlert];
                            }
                        }];
                }
            }
        }];
    }
    
    
}

#pragma mark- 获取钱包数据
- (void)getWalletData{
    
    NSString *user_id = [UserInfo getuserid];
    NSDictionary *param = @{@"user_id":user_id};
    [[TLRequest shareRequest]tlRequestWithAction:kGetAuthMoney Params:param result:^(BOOL isSuccess, id data){
        
        if (isSuccess) {
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSDictionary *walletDic = data;
                _accountMoney.text = [NSString stringWithFormat:@"%@元",[walletDic objectForKey:@"money"]];
            }
            
        }
        
    }];
}

#pragma mark- 显示购买成功页面跳转提醒
- (void)showBuySuccessAlert{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"购买人才成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回",@"查看", nil];
    
    alert.tag = 100;
    
    alert.delegate = self;
    
    [alert show];
}




-(void)paySuccessNoti
{
    [self showBuySuccessAlert];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if (buttonIndex == 1){//跳转购买的简历
            
            BoughtResumeTVC *myResume = [self.storyboard instantiateViewControllerWithIdentifier:@"BoughtResumeTVC"];
            [self.navigationController pushViewController:myResume animated:YES];
            
        }
        
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter ] removeObserver:self name:kPaySucessNotification object:nil];
}

    


@end
