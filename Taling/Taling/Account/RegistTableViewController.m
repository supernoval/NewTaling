//
//  RegistTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "RegistTableViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"
#import "PrivacyViewController.h"




@interface RegistTableViewController ()<UIAlertViewDelegate>
{
    NSString *dviceToken;
    
    UIAlertView *_noneAlertView;
    
    UIAlertView *_dviceHadRegist;
    
    CompanyFirstTVC *_companyTVC;
    
    
    
    
}
@end

@implementation RegistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    self.sendCodeButton.clipsToBounds = YES;
    self.sendCodeButton.layer.cornerRadius = 5.0;
    
    self.tableView.tableFooterView = [self tableFooterView];
    
    _companyTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanyFirstTVC"];
    
    
}


- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, ScreenWidth-30, 40)];
    [logoutBtn setTintColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"用户注册" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = FONT_17;
    logoutBtn.backgroundColor = NavigationBarColor;
    logoutBtn.clipsToBounds = YES;
    logoutBtn.layer.cornerRadius = 5.0;
    [logoutBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:logoutBtn];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(logoutBtn.frame.origin.x, logoutBtn.frame.origin.y+logoutBtn.frame.size.height+3, 157, 20)];
    textLabel.text = @"＊注册即代表您已同意她灵";
    textLabel.font = FONT_13;
    textLabel.textColor = kLightTintColor;
    textLabel.textAlignment = NSTextAlignmentLeft;
    [footerView addSubview:textLabel];
    
    UIButton *proBtn = [[UIButton alloc]initWithFrame:CGRectMake(textLabel.frame.origin.x+textLabel.frame.size.width, textLabel.frame.origin.y, 80, 20)];
    [proBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    proBtn.titleLabel.font = FONT_13;
    [proBtn setTitleColor:RGB(0, 122, 255, 1.0) forState:UIControlStateNormal];
    [proBtn addTarget:self action:@selector(showPrivacy:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:proBtn];
    return footerView;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
}



- (IBAction)sendCodeAction:(id)sender {
    
    if ([CommonMethods checkTel:_phoneTF.text])
    {
        
  
        
        _sendCodeButton.enabled = NO;
       
        [self getAutoCodeTime];
        
     [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneTF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
         if (!error) {
             
             NSLog(@"sendsms!");
             
             
         }
         else
         {
             NSLog(@"error:%@",error);
             
         }
     }];
        
     
        
        
    }
    else
    {
        [MyProgressHUD showError:@"手机号码不正确"];
        
    }
    
}
- (void)registAction:(id)sender {
    
    
//     [self summitRegist];
//    
//    return;
    
    if (![CommonMethods checkTel:_phoneTF.text]) {
        
        [MyProgressHUD showError:@"请输入正确的手机号码"];
        
        return;
        
    }
    
    if (_SMSCodeTF.text.length == 0) {
        
        [MyProgressHUD showError:@"请输入验证码"];
        
        
        return;
        
        
    }
    
    if (_codeTF.text.length > 16 || _codeTF.text.length == 0) {
        
        [MyProgressHUD showError:@"请输入小于16位的密码"];
        
        return;
        
        
    }
    
    if (![_codeTF.text isEqualToString:_checkCodeTF.text]) {
        
        
        [MyProgressHUD showError:@"两次输入的密码不一致"];
        
        return;
    }
    
//    if (_recommendPhone.text.length > 0 && ![CommonMethods checkTel:_recommendPhone.text]) {
//        
//        [MyProgressHUD showError:@"推荐人手机号码不正确"];
//        
//        return;
//        
//        
//    }
    
    
    [self checkSMSCode:_SMSCodeTF.text];
    
    
    
}

#pragma mark -  校验验证码
-(void)checkSMSCode:(NSString *)SMSCode
{
    
    [MyProgressHUD showProgress];
    
    [SMSSDK commitVerificationCode:SMSCode phoneNumber:_phoneTF.text zone:@"86" result:^(NSError *error) {
      
        
        if (!error)
        {
            
            [self summitRegist];
            
        }
        else
        {
            [MyProgressHUD dismiss];
            
            [CommonMethods showDefaultErrorString:@"验证码不正确"];
            
            
        }
    }];
    

    
}

#pragma mark - 提交注册
-(void)summitRegist
{
    NSDictionary *param = @{@"username":_phoneTF.text,@"password":_codeTF.text,@"is_company":@"0"};
    
    
    TLRequest *request = [TLRequest shareRequest];
    
    [request tlRequestWithAction:kRegist Params:param result:^(BOOL isSuccess, id data) {
        
          [MyProgressHUD dismiss];
        
        if (isSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            
        }
        
    }];
    
    
}

- (void)showPrivacy:(id)sender {
    
    UINavigationController *_privacy = [self.storyboard instantiateViewControllerWithIdentifier:@"privacyNav"];
    
    [self presentViewController:_privacy animated:YES completion:nil];
    
    
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
//                NSLog(@"____%@",strTime);
                
                [_sendCodeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal] ;
                
                
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}





#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _noneAlertView)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    
    if (alertView == _dviceHadRegist) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
        
    }
}

#pragma mar - 自动登录
-(void)login:(NSString*)phone  code:(NSString*)code
{
    
    [MyProgressHUD showProgress];

    
}


- (IBAction)switch:(id)sender {
    
    
    UISegmentedControl *segment = (UISegmentedControl*)sender;
    
    if(segment.selectedSegmentIndex == 0)
    {
        
        self.tableView.hidden = NO;
        
        [_companyTVC.view removeFromSuperview];
        
        
    }
    else
    {
//        self.tableView.hidden = YES;
        
        
        [self.view addSubview:_companyTVC.view];
         
    }
    
    
    
    
    
}
@end
