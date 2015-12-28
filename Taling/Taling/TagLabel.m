//
//  TagLabel.m
//  Taling
//
//  Created by Leo on 15/12/4.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "TagLabel.h"
#import "Constants.h"

@implementation TagLabel

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4.0;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = kTextLightGrayColor.CGColor;
        self.font = FONT_14;
        self.textColor = kTextLightGrayColor;
        self.textAlignment = NSTextAlignmentCenter;
        self.shadowColor = [UIColor clearColor];
        self.shadowOffset = CGSizeMake(0, 0);
    }
    
    return self;
}

@end
