//
//  YanZhengViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "YanZhengViewController.h"
#import "CompanyInfoTableView.h"
#import "CompanyDoneVC.h"

@interface YanZhengViewController ()
{
    BOOL isEmailCheck;
    
}
@end

@implementation YanZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title = @"验证";
    _deleteButton.hidden = YES;
    
    _sendCodeButton.clipsToBounds =YES;
    
    _sendCodeButton.layer.cornerRadius = 5;
    
    _doneButton.clipsToBounds = YES;
    
    _doneButton.layer.cornerRadius = 5;
    
    
    
    
    
}




- (IBAction)phoneAction:(id)sender {
    
    
    
    [_phoneCheckButton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
    
    [_emailcheckbutton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    _phoneNunTF.text = nil;
    
    _phoneNunTF.placeholder = @"手机号";
    
    
    
}
- (IBAction)emailAction:(id)sender {
    
    [_phoneCheckButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    [_emailcheckbutton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
    
    _phoneNunTF.text = nil;
    
    _phoneNunTF.placeholder  = @"邮箱";
    
    
    
    
}
- (IBAction)sendCodeAction:(id)sender {
    
    
}
- (IBAction)deleteAction:(id)sender {
}
- (IBAction)addPhoto:(id)sender {
}
- (IBAction)doneAction:(id)sender {
    
    
    CompanyInfoTableView *_infoTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanyInfoTableView"];
    
    [self.navigationController pushViewController:_infoTVC animated:YES];
    

    
    
    if (isEmailCheck) {
    
        
    }
    else
    {
        
    }
    
    
    
}
@end
