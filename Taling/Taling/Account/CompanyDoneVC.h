//
//  CompanyDoneVC.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface CompanyDoneVC : BaseViewController

@property (nonatomic) NSString *companyName;

@property (nonatomic) NSString *accountName;


@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneAction:(id)sender;
@end
