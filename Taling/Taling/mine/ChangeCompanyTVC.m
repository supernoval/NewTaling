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
    
     
     if (_inputTextField.text.length == 0) {
     
     [CommonMethods showDefaultErrorString:@"公司不能为空"];
     return;
     }
    
    
    [_inputTextField resignFirstResponder];
    
    
    NSString *user_id = [UserInfo getuserid];
    
    NSString *company = _inputTextField.text;
    
    
    NSDictionary *param = @{@"user_id":user_id,@"work_year":@"",@"industry":@"",@"summary":@"",@"company":company,@"nickname":@""};
     
     [[TLRequest shareRequest] tlRequestWithAction:kupdateUser Params:param result:^(BOOL isSuccess, id data) {
     
     if (isSuccess) {
     
     
     
     [CommonMethods showDefaultErrorString:@"修改成功"];
     
     [[NSUserDefaults standardUserDefaults]setObject:_inputTextField.text forKey:kcompany];
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

-(void)setblock:(ChangeCompanyBlock)block
{
    _block = block;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
