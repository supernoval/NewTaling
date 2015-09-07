//
//  ChangeNickNameVC.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/6.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "ChangeNickNameVC.h"

@interface ChangeNickNameVC ()

@end

@implementation ChangeNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改昵称";
    
    _inputTextField.text = [[NSUserDefaults standardUserDefaults ] objectForKey:knickname];
    
    
}



- (IBAction)changeAction:(id)sender {
    
    if (_inputTextField.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"昵称不能为空"];
        return;
    }
    
    NSString *account_id = [UserInfo getAccount_id];
    
    NSString *nickname = _inputTextField.text;
    
    NSString *username = [[NSUserDefaults standardUserDefaults ] objectForKey:kusername];
    NSString *password = [[NSUserDefaults standardUserDefaults ] objectForKey:kpassword];
    
    NSDictionary *param = @{@"account_id":account_id,@"nickname":nickname,@"username":username,@"password":password};
    
    [[TLRequest shareRequest] tlRequestWithAction:kupdateUser Params:param result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            
            
            [CommonMethods showDefaultErrorString:@"修改成功"];
            
            [[NSUserDefaults standardUserDefaults]setObject:_inputTextField.text forKey:knickname];
            [[NSUserDefaults standardUserDefaults ] synchronize];
            
            if (_block) {
                
                _block(_inputTextField.text);
                
            }
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"修改失败"];
            
        }
        
    }];
    
    
    
}

-(void)setblock:(ChangeNickBlock)block
{
    _block = block;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
