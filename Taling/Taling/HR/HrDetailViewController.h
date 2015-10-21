//
//  HrDetailViewController.h
//  Taling
//
//  Created by ZhuHaikun on 15/10/17.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"
#import "HRItem.h"

@interface HrDetailViewController : BaseViewController


@property (nonatomic,strong) HRItem*hrInfoItem;


@property (weak, nonatomic) IBOutlet UIImageView *headimageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@property (weak, nonatomic) IBOutlet UILabel *profersionLabel;

@property (weak, nonatomic) IBOutlet UIButton *chatButton;

- (IBAction)chatAction:(id)sender;


@end
