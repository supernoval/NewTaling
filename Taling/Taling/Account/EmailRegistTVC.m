//
//  EmailRegistTVC.m
//  Taling
//
//  Created by ZhuHaikun on 15/11/20.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "EmailRegistTVC.h"

@interface EmailRegistTVC ()

@end

@implementation EmailRegistTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.footerView.frame = CGRectMake(0, 0, ScreenWidth, 90);
    
    
}


- (IBAction)nextAction:(id)sender {
    
//    * username      公司账号传 公司邮箱
//    * password
//    
//    * is_company     公司 1   个人 0
//    * phone          只有公司注册 并且通过手机验证才有
    NSDictionary *param = @{@"username":_emailTF.text,@"password":_codeTF.text,@"is_company":@(1),@"phone":@"15900785999"};
    
    [[TLRequest shareRequest] tlRequestWithAction:kRegist Params:param result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            
        }
    }];
    
}
@end
