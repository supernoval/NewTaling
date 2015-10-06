//
//  BuyMessageCell.m
//  Taling
//
//  Created by Leo on 15/10/6.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BuyMessageCell.h"

@implementation BuyMessageCell

- (void)awakeFromNib {
    _buyerImageView.clipsToBounds = YES;
    _buyerImageView.layer.cornerRadius = 5.0;
    _resumeImageView.clipsToBounds = YES;
    _resumeImageView.layer.cornerRadius = 5.0;
    _resumeView.clipsToBounds = YES;
    _resumeView.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
