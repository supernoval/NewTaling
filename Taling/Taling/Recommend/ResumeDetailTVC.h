//
//  ResumeDetailTVC.h
//  Taling
//
//  Created by Leo on 15/10/3.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ModelItem.h"

@interface ResumeDetailTVC : BaseTableViewController

@property (nonatomic) NSInteger type;//1 购买 2 评价
<<<<<<< .mine
@property (nonatomic) NSString *resumes_id; // 简历ID
=======
@property (strong, nonatomic)ModelItem *item;
>>>>>>> .r40

@end
