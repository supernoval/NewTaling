//
//  HRListCell.m
//  Taling
//
//  Created by ZhuHaikun on 15/10/17.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "HRListCell.h"

@implementation HRListCell

- (void)awakeFromNib {
    
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 5.0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
