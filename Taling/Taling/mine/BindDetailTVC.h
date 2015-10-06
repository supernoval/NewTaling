//
//  BindDetailTVC.h
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BindDetailTVC : BaseTableViewController
@property (strong, nonatomic) IBOutlet UILabel *domainLabel;
@property (strong, nonatomic) IBOutlet UILabel *bindLabel;

@property (strong, nonatomic) IBOutlet UITextField *accountTextField;
@property (strong, nonatomic) IBOutlet UITextField *codeTextfield;
@end
