//
//  ResumeOpetationCell.m
//  Taling
//
//  Created by Leo on 15/10/4.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ResumeOpetationCell.h"
#import "Constants.h"

@implementation ResumeOpetationCell

- (void)awakeFromNib {
    _commentWidth.constant = ScreenWidth/3;
    _goodWidth.constant = ScreenWidth/3;
    _buyWidth.constant = ScreenWidth/3;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
