//
//  BuyAndCashTVC.m
//  Taling
//
//  Created by ucan on 15/10/9.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BuyAndCashTVC.h"
#import "PayOrder.h"
#import "PayOrderInfoModel.h"

@interface BuyAndCashTVC ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UIAlertView *_successAlert;
    
}
@property (nonatomic)NSInteger payType;// 1 支付宝 2 微信

@end

@implementation BuyAndCashTVC
@synthesize viewType;//1 充值 2 提现

- (void)viewDidLoad {
    [super viewDidLoad];
    _moneyTextField.delegate = self;
    _account.delegate = self;
    _account_again.delegate = self;
    
    _weChatBtn.selected = YES;
    _alipayBtn.selected = NO;
    _payType = 2;
    
    [_weChatBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [_weChatBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [_alipayBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [_alipayBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    
    self.tableView.tableFooterView = [self tableFooterView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:kPaySucessNotification object:nil];
    
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

-(void)paySuccess
{
    _successAlert = [[UIAlertView alloc]initWithTitle:nil message:@"充值成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [_successAlert show];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.viewType == 1) {
        return 2;
    }else if (self.viewType == 2){
        
        return 3;
    }
    
    return 3;
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
    [payBtn setTitle:@"确定" forState:UIControlStateNormal];
    payBtn.backgroundColor = NavigationBarColor;
    [payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerview addSubview:payBtn];
    return footerview;
}

- (IBAction)wechatAction:(UIButton *)sender {
 
}

- (IBAction)alipayAction:(UIButton *)sender {
   
}

- (void)payAction{
    
    if (self.viewType == 1) {//充值
        
        if (_moneyTextField.text.length == 0) {
            [CommonMethods showDefaultErrorString:@"请输入充值金额"];
        }else{
            
            
            NSString *amount = [NSString stringWithFormat:@"%.2f",[_moneyTextField.text floatValue]];
            
            NSDictionary *param = @{@"user_id":[UserInfo getuserid],@"money":amount,@"type":@(_payType),@"action":@"2",@"account":@"发票抬头"};
            
            [[TLRequest shareRequest]tlRequestWithAction:kBuyAndCash Params:param result:^(BOOL isSuccess, id data){
                
                if (isSuccess) {
                    
                    
                    PayOrderInfoModel *orderModel = [[ PayOrderInfoModel alloc]init];
                    
                    orderModel.productName = @"充值测试";
                    orderModel.productDescription = [NSString stringWithFormat:@"充值"];
                    
                    orderModel.amount =   [data objectForKey:@"money"];
                    orderModel.out_trade_no = [data objectForKey:@"id"];
                    orderModel.producttype = @"2";
                    
                    if (_payType == 2) {
                        
                        
                        [PayOrder sendWXPay:orderModel];
                        
                    }
                    else
                    {
                        [PayOrder loadALiPaySDK:orderModel];
                    }
                    
                    
                   
                }
                
            }];
            
        }
        
    }else if (self.viewType == 2){//提现
        
        if (_moneyTextField.text.length == 0) {
            [CommonMethods showDefaultErrorString:@"请输入提现金额"];
        }else if (_account.text.length == 0){
            [CommonMethods showDefaultErrorString:@"请输入提现账户"];
        }else if (_account_again.text.length == 0){
            [CommonMethods showDefaultErrorString:@"请再次输入提现账户"];
        }else if (![_account.text isEqualToString:_account_again.text]){
            [CommonMethods showDefaultErrorString:@"两次输入的提现账户不一致"];
        }else{
            
            NSDictionary *param = @{@"user_id":[UserInfo getuserid],@"money":_moneyTextField.text,@"type":@(_payType),@"action":@"1",@"account":_account.text};
            
            [[TLRequest shareRequest]tlRequestWithAction:kBuyAndCash Params:param result:^(BOOL isSuccess, id data){
                
                if (isSuccess) {
                    
                    
                }
                
                
            }];
            
        }
        
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {
            _weChatBtn.selected = YES;
            _alipayBtn.selected = NO;
            _payType = 2;
        }
        if (indexPath.row == 2) {
            
            _weChatBtn.selected = NO;
            _alipayBtn.selected = YES;
            _payType = 1;
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark- textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    
    [futureString  insertString:string atIndex:range.location];
    
    NSInteger flag=0;
    
    const NSInteger limited = 2;//小数点后需要限制的个数
    
    for (NSInteger i = futureString.length-1; i>=0; i--) {
        
        
        if ([futureString characterAtIndex:i] == '.') {
            
            
            
            if (flag > limited) {
                
                return NO;
                
            }
            
            
            break;
            
        }
        
        flag++;
        
    }
    
    
    
    return YES;
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView == _successAlert) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPaySucessNotification object:nil];
    
    
}
@end
