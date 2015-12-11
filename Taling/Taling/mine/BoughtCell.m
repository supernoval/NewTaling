//
//  BoughtCell.m
//  Taling
//
//  Created by ucan on 15/12/8.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BoughtCell.h"

@implementation BoughtCell

- (void)awakeFromNib {
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
