//
//  SelectView.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/8.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "SelectView.h"



@implementation SelectView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        
        firstTableViewWith = 120;
        
        secTableViewWith = 150;
        
        _firstArray = @[@"行业",@"职业",@"城市",@"资历"];
        _secArray = @[@"IT",@"物联网金融"];
        
        controll = [[UIControl alloc]initWithFrame:self.frame];
        [controll addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        controll.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        [self addSubview:controll];
       
        
        [self firstTableView:frame];
        [self secTableView:frame];
        
        
        
    }
    
    return self;
}

-(void)firstTableView:(CGRect)rect
{
    _firstTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, firstTableViewWith,  _firstArray.count * 44) style:UITableViewStylePlain];
    _firstTableView.dataSource = self;
    _firstTableView.delegate = self;
    _firstTableView.backgroundColor = NavigationBarColor;
    
    [self addSubview:_firstTableView];
    
}

-(void)secTableView:(CGRect)rect
{
    _secTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, secTableViewWith,  _secArray.count * 44) style:UITableViewStylePlain];
    _secTableView.dataSource = self;
    _secTableView.delegate = self;
    _secTableView.backgroundColor = NavigationBarColor;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _firstTableView) {
        
        return _firstArray.count;
    }
    
    if (tableView == _secTableView) {
        
        return _secArray.count;
        
    }
    
    return 0;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _firstTableView)
    {
        UITableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        
        if (firstCell == nil) {
            
            firstCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
            firstCell.textLabel.font =  FONT_16;
            firstCell.textLabel.textColor =  [UIColor whiteColor];
            firstCell.textLabel.textAlignment = NSTextAlignmentCenter;
            firstCell.backgroundColor = NavigationBarColor;
            firstCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
        firstCell.textLabel.text = [_firstArray objectAtIndex:indexPath.row];
        
        
        return firstCell;
        
    }
    
    if (tableView == _secTableView)
    {
        
        UITableViewCell *secCell = [tableView dequeueReusableCellWithIdentifier:@"secCell"];
        
        if (secCell == nil) {
            
            secCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secCell"];
            secCell.textLabel.font =  FONT_16;
            secCell.textLabel.textColor =  [UIColor whiteColor];
            secCell.textLabel.textAlignment = NSTextAlignmentCenter;
            secCell.backgroundColor = NavigationBarColor;
            
        }
        
        secCell.textLabel.text = [_secArray objectAtIndex:indexPath.row];
        
        
        return secCell;
        
    }
  
    return nil;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _firstTableView) {
        
        [self showSecWithIndexPath:indexPath];
        
        
    }
    
    if (tableView == _secTableView) {
        
        
        
        
        [self dismiss];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)showSecWithIndexPath:(NSIndexPath*)indexPath
{
    [self addSubview:_secTableView];
      [self bringSubviewToFront:_firstTableView];
    [UIView animateWithDuration:0.2 animations:^{
        
      _secTableView.frame = CGRectMake(firstTableViewWith, 64, secTableViewWith, _secArray.count * 44);
        
    }completion:^(BOOL finished) {
        
        
        
    }];
    
    
    
}

-(void)selectSecTableView:(NSIndexPath*)indexPath
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _secTableView.frame = CGRectMake(secTableViewWith, 64, secTableViewWith, _secArray.count * 44);
        
    }completion:^(BOOL finished) {
        
        [_secTableView removeFromSuperview];
        
        
    }];

}

-(void)show
{
    
    
  
 
    
    [_firstTableView reloadData];
    [UIView animateWithDuration:0.2 animations:^{
       
        _firstTableView.frame = CGRectMake(0, 64, firstTableViewWith, _firstArray.count * 44);
        
        
        
    }];

}

-(void)dismiss
{
    _secTableView.frame = CGRectMake(0,64, secTableViewWith,  _secArray.count * 44);
    [_secTableView removeFromSuperview];
    
    [self removeFromSuperview];
    
}

@end
