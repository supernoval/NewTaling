//
//  SellOrderCell.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/9.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "SellOrderCell.h"

@implementation SellOrderCell

- (void)awakeFromNib {
    // Initialization code
    
    self.orderStateLabel.clipsToBounds = YES;
    self.orderStateLabel.layer.cornerRadius = 5.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
