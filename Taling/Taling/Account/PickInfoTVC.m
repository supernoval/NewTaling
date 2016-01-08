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
    NSMutableString*_goodAtStr;
    
    
}
@end

@implementation PickInfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _goodAtStr = [[NSMutableString alloc]initWithString:_beforeString];
    
    
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
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    
    self.navigationItem.rightBarButtonItem = barButton;
    
    
}

-(void)done
{
    if (_goodAtStr.length == 0) {
        
        
        return;
    }
    
    if (_block) {
        
        _block(_goodAtStr);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
  
    if (_type == 3 || _type == 2) {
        
        
        NSArray *strings = [_goodAtStr componentsSeparatedByString:@","];
        
        BOOL hadSelected = NO;
        
        for (NSString *str in strings) {
            
            if ([str isEqualToString:[_dataSource objectAtIndex:indexPath.section]]) {
                
                hadSelected = YES;
                
            }
          
        }
        
        if (hadSelected) {
            
             cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    else{
    if ([_beforeString isEqualToString:[_dataSource objectAtIndex:indexPath.section]]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *string = [_dataSource objectAtIndex:indexPath.section];
    
    if (_type == 3 || _type == 2) {
       
        
        NSArray *strings = [_goodAtStr componentsSeparatedByString:@","];
        
        NSMutableArray *muArray = [[NSMutableArray alloc]initWithArray:strings];
        
        BOOL hadSelected = NO;
        
        for (int i = 0; i < strings.count; i++) {
            
            NSString *str = [strings objectAtIndex:i];
            
            if ([str isEqualToString:string]) {
                
                [muArray removeObjectAtIndex:i];
                
                hadSelected = YES;
                
            }
            
            
        }
        
        if (hadSelected) {
            
            _goodAtStr = [[NSMutableString alloc]init];
            
            for (NSString *temstr in muArray) {
                
                if (_goodAtStr.length == 0) {
                    
                    [_goodAtStr appendString:temstr];
                }
                else
                {
                    [_goodAtStr appendFormat:@",%@",temstr];
                    
                }
            }
        }
        
        else
        {
        if (_goodAtStr.length == 0) {
            
    
            [_goodAtStr appendString:string];
            
            
            
        }
        else
        {
            
            [_goodAtStr appendFormat:@",%@",string];
            
            
            
        }
             }
        
        [self.tableView reloadData];
        
       
    }
    else
    {
        
    if (_block) {
        
        _block(string);
        
    }
        
         [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
   
    
    
}

-(void)setBlock:(PickInfoBlock)block
{
    _block = block;
    
    
}

@end
