//
//  ChangeNickNameVC.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/6.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"
#import "ConstantsHeaders.h"

typedef void (^ChangeNickBlock)(NSString *nick);

@interface ChangeNickNameVC : BaseViewController
{
    ChangeNickBlock _block;
    
}
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)changeAction:(id)sender;

-(void)setblock:(ChangeNickBlock)block;

@end
