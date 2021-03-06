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
#import "ResumeDetailVC.h"

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
    isBuyOrderList = YES;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [self buyTableHeadView];
    
}

- (UIView *)sellTableHeadView{
    
    UIView *buyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    buyView.backgroundColor = kContentColor;
    
    UILabel *buyNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth/3, 30)];
    buyNum.font = FONT_17;
    buyNum.textAlignment = NSTextAlignmentCenter;
    buyNum.textColor = [UIColor blackColor];
    buyNum.text = @"128份";
    [buyView addSubview:buyNum];
    
    UILabel *buyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth/3, 20)];
    buyLabel.text = @"已售简历数";
    buyLabel.textColor = kDarkGrayColor;
    buyLabel.font = FONT_15;
    buyLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:buyLabel];
    
    UILabel *sellMoney = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 15, ScreenWidth/3, 30)];
    sellMoney.font = FONT_17;
    sellMoney.textAlignment = NSTextAlignmentCenter;
    sellMoney.textColor = [UIColor blackColor];
    sellMoney.text = @"7590元";
    [buyView addSubview:sellMoney];
    
    UILabel *sellLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 45, ScreenWidth/3, 20)];
    sellLabel.text = @"已售简历总估值";
    sellLabel.textColor = kDarkGrayColor;
    sellLabel.font = FONT_15;
    sellLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:sellLabel];
    
    
    UILabel *earnMoney = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*2/3, 15, ScreenWidth/3, 30)];
    earnMoney.font = FONT_17;
    earnMoney.textAlignment = NSTextAlignmentCenter;
    earnMoney.textColor = [UIColor blackColor];
    earnMoney.text = @"7590元";
    [buyView addSubview:earnMoney];
    
    UILabel *earnLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*2/3, 45, ScreenWidth/3, 20)];
    earnLabel.text = @"已赚取总额";
    earnLabel.textColor = kDarkGrayColor;
    earnLabel.font = FONT_15;
    earnLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:earnLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 79, ScreenWidth-15, 1)];
    line.backgroundColor = kLineColor;
    [buyView addSubview:line];
    return buyView;
}


- (UIView *)buyTableHeadView{
    
    UIView *buyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    buyView.backgroundColor = kContentColor;
    
    UILabel *buyNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth/3, 30)];
    buyNum.font = FONT_17;
    buyNum.textAlignment = NSTextAlignmentCenter;
    buyNum.textColor = [UIColor blackColor];
    buyNum.text = @"128份";
    [buyView addSubview:buyNum];
    
    UILabel *buyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth/3, 20)];
    buyLabel.text = @"已购简历数";
    buyLabel.textColor = kDarkGrayColor;
    buyLabel.font = FONT_15;
    buyLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:buyLabel];
    
    UILabel *sellMoney = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 15, ScreenWidth/3, 30)];
    sellMoney.font = FONT_17;
    sellMoney.textAlignment = NSTextAlignmentCenter;
    sellMoney.textColor = [UIColor blackColor];
    sellMoney.text = @"7590元";
    [buyView addSubview:sellMoney];
    
    UILabel *sellLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 45, ScreenWidth/3, 20)];
    sellLabel.text = @"已购简历总估值";
    sellLabel.textColor = kDarkGrayColor;
    sellLabel.font = FONT_15;
    sellLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:sellLabel];
    
    
    UILabel *earnMoney = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*2/3, 15, ScreenWidth/3, 30)];
    earnMoney.font = FONT_17;
    earnMoney.textAlignment = NSTextAlignmentCenter;
    earnMoney.textColor = [UIColor blackColor];
    earnMoney.text = @"7590元";
    [buyView addSubview:earnMoney];
    
    UILabel *earnLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*2/3, 45, ScreenWidth/3, 20)];
    earnLabel.text = @"已花费总额";
    earnLabel.textColor = kDarkGrayColor;
    earnLabel.font = FONT_15;
    earnLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:earnLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 79, ScreenWidth-15, 1)];
    line.backgroundColor = kLineColor;
    [buyView addSubview:line];
    
    return buyView;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 111;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
    
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
        
        static NSString *buyId = @"BuyOrderCell";
        BuyOrderCell *buyCell = [tableView dequeueReusableCellWithIdentifier:buyId];
        
        if (buyCell == nil) {
            buyCell = [[[NSBundle mainBundle]loadNibNamed:@"BuyCell" owner:self options:nil]firstObject];
        }
        
        
        
        
        
        return buyCell;
        
    }
    else
    {
        
        static NSString *sellId = @"SellOrderCell";
        SellOrderCell *sellCell = [tableView dequeueReusableCellWithIdentifier:sellId];
        
        if (sellCell == nil) {
            sellCell = [[[NSBundle mainBundle] loadNibNamed:@"SellOrderCell" owner:self options:nil]firstObject];

        }
        
        
        
        return sellCell;
        
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ResumeDetailVC *detail = [sb instantiateViewControllerWithIdentifier:@"ResumeDetailVC"];
    detail.type = 2;
    [self.navigationController pushViewController:detail animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)switchOrderList:(id)sender {
    
    UISegmentedControl *seg = sender;
    
    if (seg.selectedSegmentIndex == 0) {
        
        isBuyOrderList = YES;
        self.tableView.tableHeaderView = [self buyTableHeadView];
    }
    else
    {
        isBuyOrderList = NO;
        self.tableView.tableHeaderView = [self sellTableHeadView];
        
    }
    
    [self.tableView reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
