//
//  OrderListViewController.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/6.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "OrderListViewController.h"
#import "SellOrderCell.h"
#import "BuyOrderCell.h"

@interface OrderListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_sellTableView;
    UITableView *_buyTableView;
    
    NSMutableArray *_sellArray;
    NSMutableArray *_buyArray;
    
    BOOL isBuyOrderList;
    
    
}
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableHeaderView =nil;
    
    self.tableView.backgroundColor = kBackgroundColor;
    
    [self.view addSubview:self.tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    blankView.backgroundColor = [UIColor clearColor];
    
    
    return blankView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 10;
    
//    if (isBuyOrderList) {
//        
//        
//        return _buyArray.count;
//        
//    }
//    
//    return _sellArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isBuyOrderList) {
        
        BuyOrderCell *buyCell = [[[NSBundle mainBundle]loadNibNamed:@"BuyCell" owner:self options:nil]firstObject];
        
        
        
        
        return buyCell;
        
    }
    else
    {
        SellOrderCell *sellCell = [[[NSBundle mainBundle] loadNibNamed:@"SellOrderCell" owner:self options:nil]firstObject];
        
        
        
        return sellCell;
        
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)switchOrderList:(id)sender {
    
    UISegmentedControl *seg = sender;
    
    if (seg.selectedSegmentIndex == 0) {
        
        isBuyOrderList = NO;
    }
    else
    {
        isBuyOrderList = YES;
        
    }
    
    [self.tableView reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
