//
//  PickInfoTVC.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "PickInfoTVC.h"

@interface PickInfoTVC ()
{
    NSArray *_dataSource;
    
}
@end

@implementation PickInfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *citys = @[@"北京市",@"上海市",@"广州市",@"深圳市",@"杭州市",@"成都市",@"南京市",@"武汉市",@"厦门市",@"天津市"];
    
    NSArray *hangye = @[@"互联网",@"移动互联网",@"游戏",@"电子商务",@"新媒体",@"广告",@"金融",@"IT/软件",@"通信",@"教育",@"健康医疗",@"智能硬件",@"其他"];
    
    NSArray *gangwei = @[@"技术类",@"产品类",@"设计类",@"运营/编辑类",@"市场/销售类",@"职能类"];
    
    if (_type == 1) {
        
        _dataSource = citys;
    }
    else if (_type == 2)
    {
        _dataSource = hangye;
    }
    else
    {
        _dataSource = gangwei;
        
        
    }
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    
    blankView.backgroundColor = [UIColor clearColor];
    
    
    return blankView;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        
        
        
    }
    
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.section];
  
    if ([_beforeString isEqualToString:[_dataSource objectAtIndex:indexPath.section]]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *string = [_dataSource objectAtIndex:indexPath.section];
    
    if (_block) {
        
        _block(string);
        
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)setBlock:(PickInfoBlock)block
{
    _block = block;
    
    
}

@end
