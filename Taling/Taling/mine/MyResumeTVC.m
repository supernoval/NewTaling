//
//  MyResumeTVC.m
//  Taling
//
//  Created by Leo on 15/10/6.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "MyResumeTVC.h"
#import "BuyOrderCell.h"
#import "SellOrderCell.h"
#import "ResumeDetailTVC.h"

@interface MyResumeTVC ()
@property (nonatomic)BOOL isBuyOrderList;

@end

@implementation MyResumeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isBuyOrderList = YES;
    self.tableView.tableHeaderView = [self buyTableHeadView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)uploadTableHeadView{
    
    UIView *buyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    buyView.backgroundColor = kContentColor;
    
    UILabel *buyNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth/3, 30)];
    buyNum.font = FONT_17;
    buyNum.textAlignment = NSTextAlignmentCenter;
    buyNum.textColor = [UIColor blackColor];
    buyNum.text = @"128份";
    [buyView addSubview:buyNum];
    
    UILabel *buyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth/3, 20)];
    buyLabel.text = @"已上传简历数";
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
    sellLabel.text = @"已上传简历总估值";
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
    if (_isBuyOrderList == YES) {
        
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
    ResumeDetailTVC *detail = [sb instantiateViewControllerWithIdentifier:@"ResumeDetailTVC"];
    
    detail.type = 2;
    [self.navigationController pushViewController:detail animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (IBAction)switchAction:(UISegmentedControl *)sender {
    
    UISegmentedControl *seg = sender;
    
    if (seg.selectedSegmentIndex == 0) {
        
        _isBuyOrderList = YES;
        self.tableView.tableHeaderView = [self buyTableHeadView];
    }
    else
    {
        _isBuyOrderList = NO;
        self.tableView.tableHeaderView = [self uploadTableHeadView];
        
    }
    
    [self.tableView reloadData];
}
@end
