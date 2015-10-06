//
//  BuyMessageCell.h
//  Taling
//
//  Created by Leo on 15/10/6.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *buyerImageView;
@property (strong, nonatomic) IBOutlet UILabel *buyerName;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UIView *resumeView;
@property (strong, nonatomic) IBOutlet UIImageView *resumeImageView;
@property (strong, nonatomic) IBOutlet UILabel *resumeName;
@property (strong, nonatomic) IBOutlet UIImageView *sexImageView;
@property (strong, nonatomic) IBOutlet UILabel *placeLabel;
@property (strong, nonatomic) IBOutlet UILabel *frofessionLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameWidth;

@end
