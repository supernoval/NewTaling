//
//  CommentCell.m
//  Taling
//
//  Created by Leo on 15/10/4.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

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
