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


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    _loginButton.clipsToBounds = YES;
    _loginButton.layer.cornerRadius = 5;
    
    
    
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
@end
