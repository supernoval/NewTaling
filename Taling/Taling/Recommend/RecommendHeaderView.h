//
//  RecommendHeaderView.h
//  Taling
//
//  Created by ZhuHaikun on 15/10/18.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecommendHeaderDelegate <NSObject>

-(void)selectedButtonIndex:(NSInteger)index;


@end

@interface RecommendHeaderView : UIView

@property (nonatomic) UIButton *payButton;
@property (nonatomic) UIButton *freeButton;
@property (nonatomic) UIButton *hotButton;
@property (nonatomic) UIView   *slideView;
@property (nonatomic) UIView    *bottonLineView;

@property (nonatomic) id <RecommendHeaderDelegate> delegate;


-(id)initWithFrame:(CGRect)frame;

@end
