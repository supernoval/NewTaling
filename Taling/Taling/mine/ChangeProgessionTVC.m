//
//  ChangeProgessionTVC.m
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ChangeProgessionTVC.h"

@interface ChangeProgessionTVC ()

@end

@implementation ChangeProgessionTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所属行业";
    
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
        
        [CommonMethods showDefaultErrorString:@"行业不能为空"];
        return;
    }
    
    NSString *user_id = [UserInfo getuserid];
    
    NSString *industry = _inputTextField.text;

    
    NSDictionary *param = @{@"user_id":user_id,@"work_year":@"",@"industry":industry,@"summary":@"",@"company":@"",@"nickname":@""};
    
    [[TLRequest shareRequest] tlRequestWithAction:kupdateUser Params:param result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            
            
            [CommonMethods showDefaultErrorString:@"修改成功"];
            
            [[NSUserDefaults standardUserDefaults]setObject:_inputTextField.text forKey:kindustry];
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

-(void)setblock:(ChangeProfessionBlock)block
{
    _block = block;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
