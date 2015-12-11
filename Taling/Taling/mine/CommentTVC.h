//
//  CommentTVC.h
//  Taling
//
//  Created by ucan on 15/12/9.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ModelItem.h"

@interface CommentTVC : BaseTableViewController

- (IBAction)cancelAction:(id)sender;

- (IBAction)completeAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *experenceTextView;
@property (strong, nonatomic) IBOutlet UILabel *experenceLabel;
@property (strong, nonatomic) IBOutlet UITextView *skillsTextView;
@property (strong, nonatomic) IBOutlet UILabel *skillsLabel;
@property (strong, nonatomic) IBOutlet UITextView *performTextView;
@property (strong, nonatomic) IBOutlet UILabel *performLabel;
@property (strong, nonatomic) IBOutlet UITextView *advantageTextView;

@property (strong, nonatomic) IBOutlet UILabel *advantageLabel;

@property (nonatomic, strong)ModelItem *item;
@end
