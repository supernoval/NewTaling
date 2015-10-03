//
//  ResumeExperienceCell.h
//  Taling
//
//  Created by Leo on 15/10/3.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResumeExperienceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *schoolLabel;

@property (strong, nonatomic) IBOutlet UILabel *intershipLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *intershipHeight;

@property (strong, nonatomic) IBOutlet UILabel *workLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *workHeight;

@property (strong, nonatomic) IBOutlet UILabel *skillsLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *skillsHeight;
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *likeHeight;
@end
