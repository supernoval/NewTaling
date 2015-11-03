//
//  BuyResumeDetailTVC.h
//  Taling
//
//  Created by ucan on 15/10/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BuyResumeDetailTVC : BaseTableViewController

@property (strong, nonatomic)ModelItem *item;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameWidth;
@property (strong, nonatomic) IBOutlet UIImageView *sex;
@property (strong, nonatomic) IBOutlet UILabel *place;

@property (strong, nonatomic) IBOutlet UILabel *profession;
@property (strong, nonatomic) IBOutlet UILabel *age;

@property (strong, nonatomic) IBOutlet UILabel *city;

@property (strong, nonatomic) IBOutlet UILabel *company;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIButton *wechatButton;
@property (strong, nonatomic) IBOutlet UIButton *alipayButton;
- (IBAction)wechatAction:(UIButton *)sender;
- (IBAction)alipayAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *remainPayButton;
- (IBAction)remainPayAction:(UIButton *)sender;


@end
