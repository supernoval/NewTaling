//
//  ResumeOpetationCell.h
//  Taling
//
//  Created by Leo on 15/10/4.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResumeOpetationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;
@property (strong, nonatomic) IBOutlet UIButton *goodBtn;
@property (strong, nonatomic) IBOutlet UIButton *buyBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *commentWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *goodWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buyWidth;

@end
