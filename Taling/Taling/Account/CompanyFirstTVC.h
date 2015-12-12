//
//  CompanyFirstTVC.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CompanyFirstTVC : BaseTableViewController


@property (weak, nonatomic) IBOutlet UITextField *emailTF;


@property (weak, nonatomic) IBOutlet UITextField *codeTF;


@property (weak, nonatomic) IBOutlet UIButton *nextAtion;

- (IBAction)next:(id)sender;

@end
