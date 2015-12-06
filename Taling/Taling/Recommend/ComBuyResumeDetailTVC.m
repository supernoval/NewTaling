//
//  ComBuyResumeDetailTVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ComBuyResumeDetailTVC.h"
#import "PayOrder.h"

@interface ComBuyResumeDetailTVC ()<UIAlertViewDelegate>

@end

@implementation ComBuyResumeDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买简历";
    
    self.tableView.tableFooterView = [self tablefooterView];
    
    
    
    //城市
    //    _place.text = [NSString stringWithFormat:@"%@ %@",self.item.city,edu];
    
    
    //公司
    //    _company.text = [NSString stringWithFormat:@"公司:%@",self.item.currentCompany];
    
    //订单价格
    //    _price.text = [NSString stringWithFormat:@"¥%.2f",self.item.price];
    
    //账户余额
    //    _accountMoney
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessNoti) name:kPaySucessNotification object:nil];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //优惠券
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)payAction{
    /*
    
    NSString *buy_id = [UserInfo getuserid];
    NSLog(@"username:%@",buy_id);
    NSLog(@"userId:%@",self.item.userId);
    float order_price = self.item.price;
    
    NSString *coupon_id = @"4";
    
    
    NSDictionary *param = @{@"resumes_id":@(self.item.resumesId),@"seller_id":self.item.userId,@"buyer_id":buy_id,@"order_price":@(order_price),@"coupon_id":coupon_id};
    
    if ([self.item.userId isEqualToString:buy_id]) {
        [CommonMethods showDefaultErrorString:@"不能购买自己的简历"];
    }else{
        
        [[TLRequest shareRequest] tlRequestWithAction:kcreatOrder Params:param result:^(BOOL isSuccess, id data) {
            
            if (isSuccess) {
                
                
                if (order_price == 0) {
                    
                    
                    [self paySuccessNoti];
                    
                }
                else
                {
                    NSString *orderNO = [data objectForKey:@"orderNo"];
                    
                    PayOrderInfoModel *orderModel = [[ PayOrderInfoModel alloc]init];
                    
                    orderModel.productName = self.item.name;
                    orderModel.productDescription = [NSString stringWithFormat:@"购买%@的简历",self.item.name];
                    orderModel.amount = [data objectForKey:@"orderPrice"];
                    orderModel.out_trade_no = orderNO;
                    orderModel.producttype = @"1";
                    //            [self loadPayAction:orderModel];
                    
                    
                    
                    if (_payType == 3) {//余额支付
                        NSDictionary *payParam = @{@"order_no":orderNO};
                        [[TLRequest shareRequest]tlRequestWithAction:kBuyResumeByRemaim Params:payParam result:^(BOOL isSuccess, id data){
                            
                            if (isSuccess) {//余额购买成功
                                
                                [self showBuySuccessAlert];
                            }
                        }];
                        
                    }else{
                        
                        [self loadPayAction:orderModel];
                    }
                    
                }
            }
        }];
    }
    
    */
}

#pragma mark- 显示购买成功页面跳转提醒
- (void)showBuySuccessAlert{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"购买简历成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回",@"查看", nil];
    
    alert.tag = 100;
    
    alert.delegate = self;
    
    [alert show];
}



-(void)loadPayAction:(PayOrderInfoModel*)model
{
    /*
    
    //微信支付
    if (self.payType == 1)
    {
        
        [PayOrder sendWXPay:model];
        
    }
    
    //支付宝支付
    if (self.payType == 2) {
        
        [PayOrder loadALiPaySDK:model];
        
    }*/
}

-(void)paySuccessNoti
{
    [self showBuySuccessAlert];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /*
    if (alertView.tag == 100) {
        
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if (buttonIndex == 1){//跳转到我的简历
            
            MyResumeTVC *myResume = [self.storyboard instantiateViewControllerWithIdentifier:@"MyResumeTVC"];
            [self.navigationController pushViewController:myResume animated:YES];
            
        }
        
        
    }*/
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter ] removeObserver:self name:kPaySucessNotification object:nil];
}

    


@end
