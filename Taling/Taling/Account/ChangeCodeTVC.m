//
//  ChangeCodeTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ChangeCodeTVC.h"
#import <SMS_SDK/SMS_SDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"



@interface ChangeCodeTVC ()<UIAlertViewDelegate>
{
     
}
@end

@implementation ChangeCodeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    
    _changeCodeButton.clipsToBounds = YES;
    _changeCodeButton.layer.cornerRadius = 20.0;
    
    
}


- (IBAction)changeCodeAction:(id)sender {
    
    if (_newpwdTF.text.length == 0)
    {
        
        [MyProgressHUD showError:@"密码不能为空"];
        
     
        return;
    }
    
    if (_newpwdTF.text.length > 16) {
        
        [MyProgressHUD showError:@"密码必须小于16位"];
        
        
        return;
    }
    
    if (![_newpwdTF.text isEqualToString:_againpwdTF.text]) {
        
        [MyProgressHUD showError:@"两次输入的密码不一致"];
        
        
        return;
    }
    
    NSDictionary *param = @{@"phone":_phoneNum,@"password":_newpwdTF.text};
    
    NSLog(@"param:%@",param);
 
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 999) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
