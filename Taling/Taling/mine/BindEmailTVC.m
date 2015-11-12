//
//  BindEmailTVC.m
//  Taling
//
//  Created by ucan on 15/11/10.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BindEmailTVC.h"

@interface BindEmailTVC ()<UITextFieldDelegate>

@end

@implementation BindEmailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定邮箱";
    _email.delegate = self;
    _emailAgain.delegate = self;
    self.tableView.tableFooterView = [self tableFooterView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *emalStr = [[NSUserDefaults standardUserDefaults] objectForKey:kemail];
    _email.text = emalStr;
    _emailAgain.text = emalStr;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, ScreenWidth-30, 40)];
    [logoutBtn setTintColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"绑定" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = FONT_17;
    logoutBtn.backgroundColor = NavigationBarColor;
    logoutBtn.clipsToBounds = YES;
    logoutBtn.layer.cornerRadius = 5.0;
    [logoutBtn addTarget:self action:@selector(bindAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:logoutBtn];
    return footerView;
}

- (void)bindAction{
    
    
    NSDictionary *param = @{@"user_id":[[NSUserDefaults standardUserDefaults]objectForKey:kuserid],@"email":_email.text};
    
    if (_email.text.length == 0) {
        [CommonMethods showDefaultErrorString:@"请输入要绑定的邮箱"];
    }else if (_emailAgain.text.length == 0) {
        [CommonMethods showDefaultErrorString:@"请再次输入要绑定的邮箱"];
    }else if (![_emailAgain.text isEqualToString:_email.text]) {
        [CommonMethods showDefaultErrorString:@"两次输入的邮箱不一致"];
    }else{
        
        [[TLRequest shareRequest] tlRequestWithAction:kBindingEmail Params:param result:^(BOOL isSuccess, id data){
            
            if (isSuccess) {
                
                [[NSUserDefaults standardUserDefaults] setObject:_email.text forKey:kemail];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.navigationController popViewControllerAnimated:YES];
            }
        
        }];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
