//
//  SelectView.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/8.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantsHeaders.h"

@protocol SelectViewDelegate <NSObject>

-(void)selectView:(NSDictionary*)conditions;


@end

@interface SelectView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_firstTableView;
    UITableView *_secTableView;
    
    NSArray *_firstArray;
    NSArray *_secArray;
    
    CGFloat firstTableViewWith;
    CGFloat secTableViewWith;
    
    UIControl *controll;
    
    
}
-(id)initWithFrame:(CGRect)frame;

@property (nonatomic) NSDictionary *selectedDict;
@property (nonatomic) id <SelectViewDelegate>delegate;

-(void)show;

-(void)dismiss;

@end
