//
//  EmailRegistTVC.h
//  Taling
//
//  Created by ZhuHaikun on 15/11/20.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface EmailRegistTVC : BaseTableViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTF;


@property (weak, nonatomic) IBOutlet UITextField *codeTF;
- (IBAction)nextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end
