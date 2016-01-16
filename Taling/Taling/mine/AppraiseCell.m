//
//  AppraiseCell.m
//  Taling
//
//  Created by ucan on 16/1/14.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import "AppraiseCell.h"
#import "TagButton.h"
#import "Constants.h"
@implementation AppraiseCell


- (void)awakeFromNib {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Configure the view for the selected state
}
- (void)assignView:(NSDictionary *)dic{
    NSString *title = [dic objectForKey:@"title"];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, ScreenWidth-30, 18)];
    titleLabel.font = FONT_15;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    NSArray *optionArray = [dic objectForKey:@"option"];

    float tagWidth = (ScreenWidth-30-3*TagGap)/4;
    float tagHeight = 24;

    for (NSInteger i = 0; i < optionArray.count; i++) {
        NSDictionary *oneTag = [optionArray objectAtIndex:i];
        NSString *tagTitle = [oneTag objectForKey:@"answer"];
        BOOL selected = [[oneTag objectForKey:@"selected"]boolValue];
        
        TagButton *tagButton = [[TagButton alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap)+32, tagWidth, tagHeight)];
        
        [tagButton setTitle:tagTitle forState:UIControlStateNormal];
        
        if (selected == NO) {
            tagButton.selected = NO;
        }else{
            
            tagButton.selected = YES;
        }
        
        tagButton.tag = i;
        
        [tagButton addTarget:self action:@selector(chooseTagAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tagButton];
        
    }
    
}

- (void)chooseTagAction:(UIButton *)button{
    
    if (self.delegate) {
        [self.delegate clickButtonDelegate:self.tag answerNum:button.tag];
    }
}

@end
