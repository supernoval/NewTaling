//
//  CompanyInfoTableView.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "WebViewController.h"
#import "SDPhotoGroup.h"

@interface CompanyInfoTableView : BaseTableViewController


@property (nonatomic) NSString *accountName;


@property (nonatomic) BOOL isShow;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *companDesLabel;


@property (weak, nonatomic) IBOutlet SDPhotoGroup *logoImageView;

@property (weak, nonatomic) IBOutlet SDPhotoGroup *zhizhaoView;

@property (weak, nonatomic) IBOutlet SDPhotoGroup *shuiwuView;

@property (weak, nonatomic) IBOutlet SDPhotoGroup *jigouView;



@property (weak, nonatomic) IBOutlet UIButton *companyLink;




@property (weak, nonatomic) IBOutlet UIButton *nextButton;


- (IBAction)nextAction:(id)sender;

- (IBAction)showCompanyLink:(id)sender;


@end
