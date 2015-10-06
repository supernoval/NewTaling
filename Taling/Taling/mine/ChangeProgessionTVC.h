//
//  ChangeProgessionTVC.h
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//


#import "BaseTableViewController.h"
#import "ConstantsHeaders.h"

typedef void (^ChangeProfessionBlock)(NSString *nick);

@interface ChangeProgessionTVC : BaseTableViewController{
    ChangeProfessionBlock _block;
    
}

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)changeAction:(id)sender;

-(void)setblock:(ChangeProfessionBlock)block;



@end