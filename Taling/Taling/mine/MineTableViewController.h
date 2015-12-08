//
//  MineTableViewController.h
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ShareH5.h"

@interface MineTableViewController : BaseTableViewController
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *idLabel;

@property (strong, nonatomic) IBOutlet UILabel *boughtLabel;

@property (strong, nonatomic) IBOutlet UILabel *sharedLabel;

@property (strong, nonatomic) IBOutlet UILabel *collectedLabel;
@property (strong, nonatomic) IBOutlet UILabel *walletLabel;
@property (strong, nonatomic) IBOutlet UILabel *coupleLabel;
@end
