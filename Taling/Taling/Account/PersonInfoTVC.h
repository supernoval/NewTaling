//
//  PersonInfoTVC.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SDPhotoGroup.h"

@interface PersonInfoTVC : BaseTableViewController

@property (nonatomic) BOOL isShowed;  //是否只是显示

@property (weak, nonatomic) IBOutlet SDPhotoGroup *headView;


@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *hangyeLabel;

@property (weak, nonatomic) IBOutlet UILabel *qiyeLabel;

@property (weak, nonatomic) IBOutlet UILabel *gangweiLabel;


@property (weak, nonatomic) IBOutlet SDPhotoGroup *personCardView;

@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneAction:(id)sender;


@end
