//
//  ChangeNickNameVC.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/6.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"
#import "ConstantsHeaders.h"

@interface ChangeNickNameVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)changeAction:(id)sender;

@end
