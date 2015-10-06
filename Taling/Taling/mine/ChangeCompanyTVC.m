//
//  ChangeCompanyTVC.m
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ChangeCompanyTVC.h"

@interface ChangeCompanyTVC ()

@end

@implementation ChangeCompanyTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所在公司";
    
    //    _inputTextField.text = [[NSUserDefaults standardUserDefaults ] objectForKey:knickname];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}

- (IBAction)changeAction:(id)sender {
    /*
     
     if (_inputTextField.text.length == 0) {
     
     [CommonMethods showDefaultErrorString:@"名称不能为空"];
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
     
     */
    
}

-(void)setblock:(ChangeCompanyBlock)block
{
    _block = block;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
