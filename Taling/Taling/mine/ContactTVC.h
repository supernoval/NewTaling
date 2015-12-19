//
//  ContactTVC.h
//  Taling
//
//  Created by Leo on 15/12/19.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ContactTVC : BaseTableViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *positionTF;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
- (IBAction)cancelAction:(id)sender;
- (IBAction)sendAction:(id)sender;

@property(nonatomic, strong)ModelItem *oneItem;
@end
