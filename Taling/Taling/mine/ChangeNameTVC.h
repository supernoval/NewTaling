//
//  ChangeNameTVC.h
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ConstantsHeaders.h"

typedef void (^ChangeNickBlock)(NSString *nick);

@interface ChangeNameTVC : BaseTableViewController{
    ChangeNickBlock _block;
    
}

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)changeAction:(id)sender;

-(void)setblock:(ChangeNickBlock)block;



@end
