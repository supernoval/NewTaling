//
//  ChangePasswordTVC.h
//  Taling
//
//  Created by ucan on 15/10/26.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ChangePasswordTVC : BaseTableViewController
@property (strong, nonatomic) IBOutlet UITextField *tl_oldPwd;
@property (strong, nonatomic) IBOutlet UITextField *tl_newPwd;
@property (strong, nonatomic) IBOutlet UITextField *tl_pwdAgain;

@end
