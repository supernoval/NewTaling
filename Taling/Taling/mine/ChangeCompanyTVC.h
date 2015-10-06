//
//  ChangeCompanyTVC.h
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//


#import "BaseTableViewController.h"
#import "ConstantsHeaders.h"

typedef void (^ChangeCompanyBlock)(NSString *nick);

@interface ChangeCompanyTVC : BaseTableViewController{
    ChangeCompanyBlock _block;
    
}

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)changeAction:(id)sender;

-(void)setblock:(ChangeCompanyBlock)block;

@end