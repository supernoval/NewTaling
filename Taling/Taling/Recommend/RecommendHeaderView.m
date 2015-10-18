//
//  RecommendHeaderView.m
//  Taling
//
//  Created by ZhuHaikun on 15/10/18.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendHeaderView.h"
#import "ConstantsHeaders.h"

CGFloat buttonHeight = 42;

@implementation RecommendHeaderView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.payButton];
        [self addSubview:self.freeButton];
        [self addSubview:self.hotButton];
        [self addSubview:self.slideView];
        [self addSubview:self.bottonLineView];
        
        
        
        
    }
    
    return self;
    
}

-(UIButton*)payButton
{
    if (!_payButton) {
        
        _payButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, buttonHeight)];
        
        [_payButton setTitle:@"付费" forState:UIControlStateNormal];
        
        [_payButton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
        
        [_payButton addTarget:self action:@selector(selectPayButton) forControlEvents:UIControlEventTouchUpInside];
        [_payButton setTitleColor:kDarkTintColor forState:UIControlStateHighlighted];
        
        
    }
    
    return _payButton;
    
}

-(UIButton*)freeButton
{
    if (!_freeButton) {
        
        _freeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, buttonHeight)];
        
        [_freeButton setTitle:@"免费" forState:UIControlStateNormal];
        
        [_freeButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
        
        [_freeButton addTarget:self action:@selector(selectFreeButton) forControlEvents:UIControlEventTouchUpInside];
        [_freeButton setTitleColor:kDarkTintColor forState:UIControlStateHighlighted];
        
        
    }
    
    return _freeButton;
    
}

-(UIButton*)hotButton
{
    if (!_hotButton) {
        
        _hotButton = [[UIButton alloc]initWithFrame:CGRectMake(2*ScreenWidth/3, 0, ScreenWidth/3, buttonHeight)];
        
        [_hotButton setTitle:@"热门" forState:UIControlStateNormal];
        
        [_hotButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
        
        [_hotButton addTarget:self action:@selector(selectHotButton) forControlEvents:UIControlEventTouchUpInside];
        [_hotButton setTitleColor:kDarkTintColor forState:UIControlStateHighlighted];
        
        
    }
    
    return _hotButton;
    
}

-(UIView*)slideView
{
    if (!_slideView) {
        
        _slideView = [[UIView alloc]initWithFrame:CGRectMake(0, buttonHeight, ScreenWidth/3, 2)];
        
        _slideView.backgroundColor = NavigationBarColor;
        
    }
    
    return _slideView;
    
}

-(UIView*)bottonLineView
{
    if (!_bottonLineView) {
        
        _bottonLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, ScreenWidth, 1)];
        _bottonLineView.backgroundColor = kLineColor;
        
        
    }
    
    return _bottonLineView;
    
}
-(void)selectPayButton
{
    [self animateSlideView:0];
    
    [self.payButton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
    [self.freeButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    [self.hotButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    
    if (self.delegate) {
        
        [self.delegate selectedButtonIndex:0];
        
    }
}

-(void)selectFreeButton
{
    [self animateSlideView:1];
    
    [self.payButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    [self.freeButton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
    [self.hotButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    
    if (self.delegate) {
        
        [self.delegate selectedButtonIndex:1];
        
    }
}

-(void)selectHotButton
{
    
    [self animateSlideView:2];
    
    [self.payButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    [self.freeButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    [self.hotButton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
    
    
    if (self.delegate) {
        
        [self.delegate selectedButtonIndex:2];
        
    }
}

-(void)animateSlideView:(NSInteger)selectedindex
{
    [UIView animateWithDuration:0.3 animations:^{
     
        _slideView.frame = CGRectMake(selectedindex *ScreenWidth/3, buttonHeight, ScreenWidth/3, 2);
        
    }];
}

@end
