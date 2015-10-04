//
//  SellOrderCell.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/9.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellOrderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameWidth;
@property (strong, nonatomic) IBOutlet UIImageView *sexImageView;
@property (strong, nonatomic) IBOutlet UILabel *placeLabel;
@property (strong, nonatomic) IBOutlet UILabel *professionLabel;
@property (strong, nonatomic) IBOutlet UILabel *buyNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *buyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
