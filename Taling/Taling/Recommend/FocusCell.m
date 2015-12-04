//
//  FocusCell.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "FocusCell.h"

@implementation FocusCell

- (void)awakeFromNib {
    // Initialization code
    _focusButton.clipsToBounds = YES;
    _focusButton.layer.cornerRadius = 4.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
