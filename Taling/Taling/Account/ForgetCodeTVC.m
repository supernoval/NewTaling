//
//  ForgetCodeTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ForgetCodeTVC.h"
#import <SMS_SDK/SMSSDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"


#import "ChangeCodeTVC.h"


@interface ForgetCodeTVC ()

@end

@implementation ForgetCodeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    _sendCodeButton.clipsToBounds = YES;
    _sendCodeButton.layer.cornerRadius = 5.0;
    
    self.tableView.tableFooterView = [self tableFooterView];
    

    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}


#pragma mark - 倒计时
-(void)getAutoCodeTime{
    __block int timeout=30;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal] ;
                _sendCodeButton.enabled = YES;
                
            });
        }else{
            int seconds = timeout % 31;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"____%@",strTime);
                
                [_sendCodeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal] ;
                _sendCodeButton.enabled = NO;
                
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)sendCodeAction:(id)sender {
    
    if ([CommonMethods checkTel:_phoneNum.text]) {
        
        
        [self getAutoCodeTime];
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNum.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            
        }];
        
    }
    else
    {
        [CommonMethods showDefaultErrorString:@"手机号码不正确"];
        
        
    }
    
    
}

- (void)summitAction:(id)sender {
    
    if ([CommonMethods checkTel:_phoneNum.text] && _codeTF.text.length > 0)
    {
        
        [self checkSMSCode:_codeTF.text];
        
        
    }
    
    
}

#pragma mark -  校验验证码
-(void)checkSMSCode:(NSString *)SMSCode
{
    
    [MyProgressHUD showProgress];
    
    [SMSSDK commitVerificationCode:SMSCode phoneNumber:_phoneNum.text zone:@"86" result:^(NSError *error) {
       
        
        [MyProgressHUD dismiss];
        
        if (!error)
        {
            
            
            
            ChangeCodeTVC *changeCodeTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeCodeTVC"];
            
            changeCodeTVC.phoneNum = _phoneNum.text;
            
            
            [self.navigationController pushViewController:changeCodeTVC animated:YES];
            
            [CommonMethods showDefaultErrorString:@"密码修改成功"];
            
            
            
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"验证码不正确"];
            
            
        }
        
    }];
    
    
  
    
}

- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, ScreenWidth-30, 40)];
    [logoutBtn setTintColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"下一步" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = FONT_17;
    logoutBtn.backgroundColor = NavigationBarColor;
    logoutBtn.clipsToBounds = YES;
    logoutBtn.layer.cornerRadius = 5.0;
    [logoutBtn addTarget:self action:@selector(summitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:logoutBtn];
    return footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
