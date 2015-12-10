//
//  RecommendDetailVC.h
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface RecommendDetailVC : BaseViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *collectButton;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collectWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buyWidth;

@property (strong, nonatomic)ModelItem *item;

- (IBAction)collecAction:(UIButton *)sender;
- (IBAction)buyAction:(id)sender;
@end
