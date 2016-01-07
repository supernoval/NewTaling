//
//  DonePeronRegist.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "DonePeronRegist.h"

@interface DonePeronRegist ()

@end

@implementation DonePeronRegist

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"注册成功";
    
    _doneButton.clipsToBounds = YES;
    
    _doneButton.layer.cornerRadius = 5;
    
    
}




- (IBAction)doneAction:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    
         [UserInfo loginWithUsername:[UserInfo getUsername] password:[UserInfo getPassWord]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kFinishRegistNoti object:nil];
        
        
        
        
    }];
    
}
@end
