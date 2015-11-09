//
//  ChangeCodeTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ChangeCodeTVC.h"
#import <SMS_SDK/SMSSDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"



@interface ChangeCodeTVC ()
{
     
}
@end

@implementation ChangeCodeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    self.tableView.tableFooterView = [self tableFooterView];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

- (void)changeCodeAction:(id)sender {
    
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
    
    NSString *nickname = [[NSUserDefaults standardUserDefaults]objectForKey:kusername];
    NSDictionary *param = @{@"username":nickname,@"password":_newpwdTF.text};
    
    [[TLRequest shareRequest] tlRequestWithAction:kupdatePwd Params:param result:^(BOOL isSuccess, id data) {
        
        
        
        
        if (isSuccess) {
            
            [[NSUserDefaults standardUserDefaults]setObject:_newpwdTF.text forKey:kpassword];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }];

 
    
    
}



- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, ScreenWidth-30, 40)];
    [logoutBtn setTintColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"完成" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = FONT_17;
    logoutBtn.backgroundColor = NavigationBarColor;
    logoutBtn.clipsToBounds = YES;
    logoutBtn.layer.cornerRadius = 5.0;
    [logoutBtn addTarget:self action:@selector(changeCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:logoutBtn];
    return footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
