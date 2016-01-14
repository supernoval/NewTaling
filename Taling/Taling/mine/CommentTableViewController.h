//
//  CommentTableViewController.h
//  Taling
//
//  Created by ucan on 16/1/14.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ModelItem.h"
typedef void (^CommentBlock)(BOOL success);

@interface CommentTableViewController : BaseTableViewController{
    CommentBlock _block;
}
@property (nonatomic, strong)ModelItem *item;

-(void)setblock:(CommentBlock)block;
- (IBAction)cancelAction:(id)sender;
- (IBAction)completeAction:(id)sender;

@end
