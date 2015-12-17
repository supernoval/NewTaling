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
    
    
    
    [_personButton setTitleColor:kOrangeTextColor
                        forState:UIControlStateNormal];
    
    [_companybutton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    _sendCodeButton.clipsToBounds = YES;
    
    _sendCodeButton.layer.cornerRadius = 4;
    
    _nextButton.clipsToBounds=  YES;
    _nextButton.layer.cornerRadius = 4;
    
    
    
}


- (IBAction)personAction:(id)sender {
    
    isCompany = NO;
    
    [_personButton setTitleColor:kOrangeTextColor
                        forState:UIControlStateNormal];
    
    [_companybutton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    _secViewHeight.constant = 44;
    
    _sendCodeButton.hidden = NO;
    
    _firstTextField.text = nil;
    
    _firstTextField.placeholder = @"手机号";
    
    
    
    
}
- (IBAction)companyAction:(id)sender {
    
    isCompany = YES;
    
    [_personButton setTitleColor:kDarkGrayColor
                        forState:UIControlStateNormal];
    
    [_companybutton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
    
    
    _secViewHeight.constant = 0;
    
    _sendCodeButton.hidden = YES;
    
    
    _firstTextField.text = nil;
    
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
    
    
    NSDictionary *param = @{@"username":_firstTextField.text,@"password":_passwordTF.text,@"is_company":@(isCompany)};
    
    
    TLRequest *request = [TLRequest shareRequest];
    
    [request tlRequestWithAction:kRegist Params:param result:^(BOOL isSuccess, id data) {
        
        [MyProgressHUD dismiss];
        
        if (isSuccess) {
            
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
        

    
    
        
        
        if ([CommonMethods checkTel:_firstTextField.text]) {
            
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
