//
//  LoginViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "LoginViewController.h"
#import "ConstantsHeaders.h"
#import "CommonMethods.h"
#import "RegistTableViewController.h"
#import "ForgetCodeTVC.h"
#import "MyProgressHUD.h"
#import "Location.h"
#import "ChatAccountManager.h"



@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    _loginButton.clipsToBounds = YES;
    _loginButton.layer.cornerRadius = 5;
    
    _accountView.clipsToBounds = YES;
    _accountView.layer.cornerRadius = 5;
    
    _codeView.clipsToBounds = YES;
    _codeView.layer.cornerRadius = 5;
    
    _phoneTF.delegate = self;
    _codeTF.delegate = self;
    
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginAction:(id)sender {
    
    NSString *phone = _phoneTF.text;
    
    NSString *code = _codeTF.text;
    
    if (phone.length == 0 ||  code.length == 0)
    {
        
        [MyProgressHUD showError:@"请输入用户名和密码"];
        
        return;
        
        
    }
    
    
    [[TLRequest shareRequest] tlRequestWithAction:kLogin Params:@{@"username":_phoneTF.text,@"password":_codeTF.text} result:^(BOOL isSuccess, id data) {
        
        if (isSuccess)
        {
            
            [UserInfo saveUserInfo:data];
            
            [[NSUserDefaults standardUserDefaults ] setObject:@YES forKey:kHadLogin];
            
            [[NSUserDefaults standardUserDefaults ] setObject:_codeTF.text forKey:kpassword];
            
            
            [[NSUserDefaults standardUserDefaults ] synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [self CheckEasyMobLogin];
            
        }
        
    }];
            
        
    
    
    
}

- (IBAction)registAction:(id)sender {
    
    
    
    RegistTableViewController *registTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistTableViewController"];
    
    [self.navigationController pushViewController:registTVC animated:YES];
    
    
    
    
}

- (IBAction)forgetCodeAction:(id)sender {
    
    ForgetCodeTVC *fTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetCodeTVC"];
    
    [self.navigationController pushViewController:fTVC animated:YES];
    
}

-(void)CheckEasyMobLogin
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kEasyMobHadLogin] && [[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin]) {
        
        NSString *account =[UserInfo getUsername];
        
        //        NSString *account = @"15201931110";
        [[ChatAccountManager shareChatAccountManager] loginWithAccount:account successBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                NSLog(@"Login EaseMob Success:%@",account);
                
                
            }
            else
            {
                
            }
            
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    CGFloat y = -200;
    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        y = -128;
    }else if ([UIScreen mainScreen].bounds.size.height == 568) {
        y = -160;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height);
        
    
    }];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

@end
