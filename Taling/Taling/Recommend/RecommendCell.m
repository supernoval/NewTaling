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
    
    _businessWidth.constant = (ScreenWidth - 31)/2;
    
    _companyWidth.constant = (ScreenWidth - 31)/2;
    
    _professionWidth.constant = (ScreenWidth - 31)/2;
    
    _yeatWidth.constant = (ScreenWidth - 31)/2;
    
    _buyButton.clipsToBounds = YES;
    _buyButton.layer.cornerRadius = 5.0;
    
    _placeLabel.textColor = kExtralLightGrayColor;
    _nameLabel.textColor = kTitleColor;
    
    _companyLabel.textColor = kTextLightGrayColor;
    _professionLabel.textColor = kTextLightGrayColor;
    _yearLabel.textColor = kTextLightGrayColor;
    _businessLabel.textColor = kTextLightGrayColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
