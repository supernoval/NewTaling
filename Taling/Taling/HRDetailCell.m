//
//  HRDetailCell.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "HRDetailCell.h"

@implementation HRDetailCell

- (void)awakeFromNib {
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0;
    _focusButton.clipsToBounds = YES;
    _focusButton.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
