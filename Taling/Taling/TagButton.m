//
//  TagButton.m
//  Taling
//
//  Created by ucan on 15/12/9.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "TagButton.h"
#import "Constants.h"
#import "CommonMethods.h"

@implementation TagButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4.0;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = RGB(151, 151, 151, 1).CGColor;
        self.titleLabel.font = FONT_12;
        [self setTitleColor:kTextLightGrayColor forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setBackgroundImage:[CommonMethods createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[CommonMethods createImageWithColor:kYellowColor] forState:UIControlStateSelected];
        
        
    }
    
    return self;
}

@end
