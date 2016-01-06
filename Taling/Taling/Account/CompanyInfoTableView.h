//
//  CompanyInfoTableView.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "WebView.h"

@interface CompanyInfoTableView : BaseTableViewController


@property (nonatomic) NSString *accountName;


@property (nonatomic) BOOL isShow;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *companDesLabel;

@property (weak, nonatomic) IBOutlet UILabel *linkLabel;

@property (weak, nonatomic) IBOutlet UIImageView *zhizhaoImageView;

@property (weak, nonatomic) IBOutlet UIButton *companyLink;

@property (weak, nonatomic) IBOutlet UIImageView *shuiwuImageView;
@property (weak, nonatomic) IBOutlet UIImageView *jigouImageView;


@property (weak, nonatomic) IBOutlet UIButton *nextButton;


- (IBAction)nextAction:(id)sender;

- (IBAction)showCompanyLink:(id)sender;


@end
