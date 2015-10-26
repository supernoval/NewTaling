//
//  ChangePasswordTVC.m
//  Taling
//
//  Created by ucan on 15/10/26.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ChangePasswordTVC.h"

@interface ChangePasswordTVC ()

@end

@implementation ChangePasswordTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [self tableFooterView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, ScreenWidth-30, 40)];
    [confirm setTitle:@"确认" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirm setBackgroundColor:kYellowColor];
    confirm.clipsToBounds = YES;
    confirm.layer.cornerRadius = 5.0;
    [confirm addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:confirm];
    return footerView;
}

- (void)confirmAction{
    NSString *oldPwdStr = [[NSUserDefaults standardUserDefaults]objectForKey:kpassword];
    
    if (self.tl_oldPwd.text.length == 0) {
        [CommonMethods showDefaultErrorString:@"请输入原密码"];
    }else if (self.tl_newPwd.text.length == 0){
        
        [CommonMethods showDefaultErrorString:@"请输入新密码"];
    }else if (self.tl_pwdAgain.text.length == 0){
        
        [CommonMethods showDefaultErrorString:@"请再次输入新密码"];
    }else if (![self.tl_oldPwd.text isEqualToString:oldPwdStr]){
        
        [CommonMethods showDefaultErrorString:@"原密码错误"];
    }else if (![self.tl_newPwd.text isEqualToString:self.tl_pwdAgain.text]){
        
        [CommonMethods showDefaultErrorString:@"两次输入新密码不一致"];
    }else if (self.tl_newPwd.text.length > 16){
        
        [CommonMethods showDefaultErrorString:@"密码张度小于16位"];
    }else{
        NSString *nickname = [[NSUserDefaults standardUserDefaults]objectForKey:kusername];
        NSDictionary *param = @{@"username":nickname,@"password":self.tl_newPwd.text};
        
        [[TLRequest shareRequest] tlRequestWithAction:kupdatePwd Params:param result:^(BOOL isSuccess, id data) {
            
            
            
            
            if (isSuccess) {
                
                [[NSUserDefaults standardUserDefaults]setObject:self.tl_newPwd.text forKey:kpassword];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        }];

    }
}

@end
