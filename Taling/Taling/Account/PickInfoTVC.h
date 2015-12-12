//
//  PickInfoTVC.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void (^PickInfoBlock)(NSString*pickString);

@interface PickInfoTVC : BaseTableViewController

@property (nonatomic) NSInteger type;
@property (nonatomic,strong) PickInfoBlock block;
@property (nonatomic,strong) NSString *beforeString;

@end
