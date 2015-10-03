//
//  ResumeNameCell.m
//  Taling
//
//  Created by Leo on 15/10/3.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ResumeNameCell.h"

@implementation ResumeNameCell

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
