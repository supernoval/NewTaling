//
//  RecommendDetailVC.h
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"


typedef void (^CancelCollectBlock)(BOOL cancel);

@interface RecommendDetailVC : BaseViewController
{
    
    CancelCollectBlock _block;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;


-(void)setblock:(CancelCollectBlock)block;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collectWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buyWidth;

@property (strong, nonatomic)ModelItem *item;

- (IBAction)collecAction:(UIButton *)sender;
- (IBAction)buyAction:(id)sender;
@end
