//
//  CompanyRegistTVC.h
//  Taling
//
//  Created by ZhuHaikun on 15/11/20.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface CompanyRegistTVC : BaseTableViewController

@property (weak, nonatomic) IBOutlet UITextField *companyNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *shuwuHaoLabel;
@property (weak, nonatomic) IBOutlet UITextField *zuzhijigouLabel;

@property (weak, nonatomic) IBOutlet UIImageView *YYZZImageView;


@property (weak, nonatomic) IBOutlet UIImageView *SFZImageOne;

@property (weak, nonatomic) IBOutlet UIImageView *SFZImageTwo;
- (IBAction)summitAction:(id)sender;

@end
