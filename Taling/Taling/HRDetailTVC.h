//
//  HRDetailTVC.h
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "HRItem.h"

typedef  void (^CancelForcos)(BOOL cancel);

@interface HRDetailTVC : BaseTableViewController
{
    CancelForcos _block;
    
}

-(void)setblock:(CancelForcos)block;

@property (strong, nonatomic)HRItem *hRitem;


@end
