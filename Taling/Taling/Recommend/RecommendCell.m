//
//  RecommendCell.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/9.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendCell.h"
#import "Constants.h"

@implementation RecommendCell

- (void)awakeFromNib {
    // Initialization code
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
