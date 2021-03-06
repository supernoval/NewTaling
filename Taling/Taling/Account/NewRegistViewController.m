//
//  NewRegistViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "NewRegistViewController.h"


#import <SMS_SDK/SMSSDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"
#import "PersonInfoTVC.h"
#import "YanZhengViewController.h"


@interface NewRegistViewController ()
{
   
    BOOL isCompany;
    
}
@end

@implementation NewRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"注册";
    
    
    
    [_personButton setTitleColor:kButtonBackGroundColor
                        forState:UIControlStateNormal];
    
    [_companybutton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    _sendCodeButton.clipsToBounds = YES;
    
    _sendCodeButton.layer.cornerRadius = 4;
    
    _nextButton.clipsToBounds=  YES;
    _nextButton.layer.cornerRadius = 4;
    
    isCompany = NO;
    
    
}


- (IBAction)personAction:(id)sender {
    
    isCompany = NO;
    
    [_personButton setTitleColor:kButtonBackGroundColor
                        forState:UIControlStateNormal];
    
    [_companybutton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    _secondView.hidden = NO;
    
    _secViewHeight.constant = 44;
    
    _sendCodeButton.hidden = NO;
    _countDownLabel.hidden =NO;
    
    _firstTextField.text = nil;
    
    _firstTextField.placeholder = @"手机号";
    
    _passwordTF.text = nil;
    
    
    
}
- (IBAction)companyAction:(id)sender {
    
    isCompany = YES;
    
    [_personButton setTitleColor:kDarkGrayColor
                        forState:UIControlStateNormal];
    
    [_companybutton setTitleColor:kButtonBackGroundColor forState:UIControlStateNormal];
    
    _secondView.clipsToBounds = YES;
    
    _secViewHeight.constant = 0;
    _secondView.hidden = YES;
    
    _sendCodeButton.hidden = YES;
    
    _countDownLabel.hidden = YES;
    
    
    _firstTextField.text = nil;
    _passwordTF.text = nil;
    
    
    _firstTextField.placeholder = @"企业邮箱";
    
}
- (IBAction)sendCodeAction:(id)sender {
    
    
    if ([CommonMethods checkTel:_firstTextField.text])
    {
        
        
        
        _sendCodeButton.enabled = NO;
        
        [self getAutoCodeTime];
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_firstTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
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
                _sendCodeButton.hidden = NO;
                
                _countDownLabel.text = nil;
                _countDownLabel.hidden = YES;
                
                
            });
        }else{
            int seconds = timeout % 31;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //                NSLog(@"____%@",strTime);
                
                _sendCodeButton.hidden = YES;
                
                _countDownLabel.hidden = NO;
                
                _countDownLabel.text = [NSString stringWithFormat:@"%@s",strTime];
                
//                [_sendCodeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal] ;
                
                
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



#pragma mark -  校验验证码
-(void)checkSMSCode:(NSString *)SMSCode
{
    
    [MyProgressHUD showProgress];
    

    
    
    
    [SMSSDK commitVerificationCode:SMSCode phoneNumber:_firstTextField.text zone:@"86" result:^(NSError *error) {
        
        
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
    
    
    NSDictionary *param = nil;
    
    if (isCompany) {
        
        param= @{@"username":_firstTextField.text,@"password":_passwordTF.text,@"is_company":@(isCompany)};
    }
    else
    {
        param= @{@"username":_firstTextField.text,@"password":_passwordTF.text};
    }
    
    
    
    TLRequest *request = [TLRequest shareRequest];
    
    [request tlRequestWithAction:kRegist Params:param result:^(BOOL isSuccess, id data) {
        
        [MyProgressHUD dismiss];
        
        if (isSuccess) {
            
            
            [UserInfo loginWithUsername:_firstTextField.text password:_passwordTF.text];
            
             [UserInfo saveUserInfo:data];
            
            if (isCompany) {
                
                YanZhengViewController *_yanzhengVC = [self.storyboard instantiateViewControllerWithIdentifier:@"YanZhengViewController"];
                _yanzhengVC.email = _firstTextField.text;
                [self.navigationController pushViewController:_yanzhengVC animated:YES];
            }
            else
            {
                PersonInfoTVC *_personTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonInfoTVC"];
                
                [self.navigationController pushViewController:_personTVC animated:YES];
            }
            
     
            
            
            
        }
        else
        {
           
                
             [CommonMethods showDefaultErrorString:@"该账号已被注册"];
            
        }
        
    }];
    
    
}



- (IBAction)nextAtion:(id)sender {
    
    
    
    

    
    
    if (isCompany) {
        

        
        
        if ([CommonMethods checkTel:_firstTextField.text]) {
            
            [CommonMethods showDefaultErrorString:@"请填写企业邮箱"];
            
            return;
            
        }
  
        
        if (_passwordTF.text.length < 6) {
            
            [CommonMethods showDefaultErrorString:@"请填写6位以上的密码"];
            
            
            return;
            
        }
        
        [self summitRegist];
        
        
        
    }
    else
    {
        

    
    
        
        
        if (![CommonMethods checkTel:_firstTextField.text]) {
            
            [CommonMethods showDefaultErrorString:@"手机号码不正确"];
            
            return;
            
        }
        
        if (_checkSMSCodeTF.text.length == 0) {
            
            [CommonMethods showDefaultErrorString:@"请填写验证码"];
            
            return;
            
        }
        
        if (_passwordTF.text.length < 6) {
            
            [CommonMethods showDefaultErrorString:@"请填写6位以上的密码"];
            
            
            return;
            
        }
        
        
        
        [self checkSMSCode:_checkSMSCodeTF.text];
        
        
    }
    
}

- (IBAction)showprivacyAction:(id)sender {
    
    
    UINavigationController *_privacy = [self.storyboard instantiateViewControllerWithIdentifier:@"privacyNav"];
    
    [self presentViewController:_privacy animated:YES completion:nil];
    
}
@end
