//
//  HRDetailCell.h
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *disLabel;
@property (strong, nonatomic) IBOutlet UILabel *recomValue;
@property (strong, nonatomic) IBOutlet UIButton *focusButton;

@property (weak, nonatomic) IBOutlet UIImageView *crownImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelWith;


@end
