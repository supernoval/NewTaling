//
//  BuyOrderCell.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/9.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "BuyOrderCell.h"

@implementation BuyOrderCell

- (void)awakeFromNib {
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
