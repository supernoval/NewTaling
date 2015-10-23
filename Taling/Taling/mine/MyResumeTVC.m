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
#import "ResumeDetailVC.h"

typedef NS_ENUM(NSInteger,ResumeListType)
{
    ResumeListTypeBuy,
    ResumeListTypeSell,
    ResumeListTypeReserv,
    
   
};
@interface MyResumeTVC ()
{
    NSInteger upLoadIndex;
    NSInteger buyIndex;
    NSInteger reservIndex;
    
    
    NSInteger pageSize;
    
    NSMutableArray *_buyArray;
    NSMutableArray *_upLoadArray;
    NSMutableArray *_reservArray;
    
    
    
}
@property (nonatomic)ResumeListType segMentType;

@end

@implementation MyResumeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _segMentType = ResumeListTypeBuy;
    self.tableView.tableHeaderView = [self buyTableHeadView];
    
    _buyArray = [[NSMutableArray alloc]init];
    _upLoadArray = [[NSMutableArray alloc]init];
    _reservArray = [[NSMutableArray alloc]init];
    pageSize = 10;
    
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
    [self.tableView.header beginRefreshing];
    
    
}

-(void)headerRefresh
{
    
    
    switch (_segMentType) {
        case ResumeListTypeBuy:
        {
            buyIndex = 1;
            
            [self requestBuyResumes];
            
        }
            break;
        case ResumeListTypeSell:
        {
            upLoadIndex = 1;
            
            [self requestUpLoadResumes];
        }
            break;
        case ResumeListTypeReserv:
        {
            reservIndex = 1;
            
            [self requestReserv];
            
        }
            break;
            
            
        default:
            break;
    }
 
}



-(void)footerRefresh
{
    
    
    switch (_segMentType) {
        case ResumeListTypeBuy:
        {
            buyIndex ++;
            
            [self requestBuyResumes];
        }
            break;
        case ResumeListTypeSell:
        {
            upLoadIndex ++;
            
            [self requestUpLoadResumes];
        }
            break;
        case ResumeListTypeReserv:
        {
            
        }
            break;
            
            
        default:
            break;
    }
    
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (reservIndex == ResumeListTypeReserv) {
        
        return  YES;
    }
    
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 111;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
   
    switch (_segMentType) {
        case ResumeListTypeBuy:
        {
                return _buyArray.count;
        }
            break;
        case ResumeListTypeSell:
        {
                return _upLoadArray.count;
        }
            break;
        case ResumeListTypeReserv:
        {
            return _reservArray.count;
        }
            break;
            
            
        default:
        {
            return 0;
            
        }
            break;
    }
    
    
    
 
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segMentType == ResumeListTypeBuy) {
        
        static NSString *buyId = @"BuyOrderCell";
        BuyOrderCell *buyCell = [tableView dequeueReusableCellWithIdentifier:buyId];
        
        if (buyCell == nil) {
            buyCell = [[[NSBundle mainBundle]loadNibNamed:@"BuyCell" owner:self options:nil]firstObject];
        }
        
        
        if (indexPath.section < _buyArray.count) {
            
          ModelItem *item = [_buyArray objectAtIndex:indexPath.section];
          
            buyCell.nameLabel.text = item.name;
            
            CGFloat namewith = [StringHeight widthtWithText:item.name font:FONT_15 constrainedToHeight:20] + 5;
            
            buyCell.nameWidth.constant = namewith;
            
            buyCell.buyMoneyLabel.text = item.price;
            
  
            
        }
        
        
        
        
        
        
        
        return buyCell;
        
    }
    else if (_segMentType == ResumeListTypeSell)
    {
        
        static NSString *sellId = @"SellOrderCell";
        SellOrderCell *sellCell = [tableView dequeueReusableCellWithIdentifier:sellId];
        
        if (sellCell == nil) {
            sellCell = [[[NSBundle mainBundle] loadNibNamed:@"SellOrderCell" owner:self options:nil]firstObject];
            
        }
        
        if (indexPath.section < _upLoadArray.count) {
            
            ModelItem *item = [_upLoadArray objectAtIndex:indexPath.section];
            
            sellCell.nameLabel.text = item.name;
            
            CGFloat namewith = [StringHeight widthtWithText:item.name font:FONT_15 constrainedToHeight:20];
            
            sellCell.nameWidth.constant = namewith;
            
            sellCell.buyNumLabel.text = item.price;
            
            
            
        }
        
        
        return sellCell;
        
    }
    else
    {
        static NSString *buyId = @"BuyOrderCell";
        BuyOrderCell *reservCell = [tableView dequeueReusableCellWithIdentifier:buyId];
        
        if (reservCell == nil) {
            reservCell = [[[NSBundle mainBundle]loadNibNamed:@"BuyCell" owner:self options:nil]firstObject];
        }
        
        
        if (indexPath.section < _reservArray.count) {
            
            ModelItem *item = [_reservArray objectAtIndex:indexPath.section];
            
            reservCell.nameLabel.text = item.name;
            
            CGFloat namewith = [StringHeight widthtWithText:item.name font:FONT_15 constrainedToHeight:20] + 5;
            
            reservCell.nameWidth.constant = namewith;
            
            reservCell.buyMoneyLabel.text = item.price;
            
            
            
        }
        
        
        
        
        
        
        
        return reservCell;
    }
    
    return nil;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ModelItem *item ;
    
    if (_segMentType == ResumeListTypeBuy) {
        
        item = [_buyArray objectAtIndex:indexPath.section];
        
        
    }
    else if(_segMentType == ResumeListTypeSell)
    {
        item = [_upLoadArray objectAtIndex:indexPath.section];
        
    }
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ResumeDetailVC *detail = [sb instantiateViewControllerWithIdentifier:@"ResumeDetailVC"];
    
    detail.type = 2;
    detail.item = item;
    
    [self.navigationController pushViewController:detail animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (IBAction)switchAction:(UISegmentedControl *)sender {
    
    UISegmentedControl *seg = sender;
    
    if (seg.selectedSegmentIndex == ResumeListTypeBuy) {
        
        _segMentType = ResumeListTypeBuy;
        self.tableView.tableHeaderView = [self buyTableHeadView];
    }
    else if(seg.selectedSegmentIndex == ResumeListTypeSell)
    {
        _segMentType = ResumeListTypeSell;
        self.tableView.tableHeaderView = [self sellTableHeadView];
        
    }
    else
    {
        _segMentType = ResumeListTypeReserv;
        
        
    }
    
    
    
    [self.tableView reloadData];
    
    
    [self headerRefresh];
    
}

#pragma mark - 请求数据
-(void)requestUpLoadResumes
{
    NSString *userid = [UserInfo getuserid];
    
    NSDictionary *param = @{@"user_id":userid,@"index":@(upLoadIndex),@"size":@(pageSize)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetMyResumes Params:param result:^(BOOL isSuccess, id data) {
    
        [self endFooterRefresh];
        [self endHeaderRefresh];
        
        
        if (isSuccess) {
         
            
            if (upLoadIndex == 1) {
                
                [_upLoadArray removeAllObjects];
                
            }
            
            if ([data isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dict in data) {
                    
                    ModelItem *item = [[ModelItem alloc]init];
                    
                    [item setValuesForKeysWithDictionary:dict];
                    
                    
                    [_upLoadArray addObject:item];
                    
                    
                }
                
                 [self.tableView reloadData];
                
            }
            
        }
        
    }];
    
 }


-(void)requestBuyResumes
{
    NSString *userid = [UserInfo getuserid];
    
    NSDictionary *param = @{@"user_id":userid,@"index":@(buyIndex),@"size":@(pageSize)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetMyBuyResumes Params:param result:^(BOOL isSuccess, id data) {
        
        [self endFooterRefresh];
        [self endHeaderRefresh];
        
        
        if (isSuccess) {
            
            if (buyIndex == 1) {
                
                [_buyArray removeAllObjects];
                
            }
            
            if ([data isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dict in data) {
                    
                    ModelItem *item = [[ModelItem alloc]init];
                    
                    [item setValuesForKeysWithDictionary:dict];
                    
                    
                    [_buyArray addObject:item];
                    
                    
                }
                
                [self.tableView reloadData];
                
            }
            
        }
        
    }];
    
}

-(void)requestReserv
{
    NSString *user_id = [UserInfo getuserid];
    
   NSDictionary *param = @{@"user_id":user_id,@"index":@(reservIndex),@"size":@(pageSize)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kGetReservResumes Params:param result:^(BOOL isSuccess, id data) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (isSuccess) {
            
            
            if (reservIndex == 1) {
                
                [_reservArray removeAllObjects];
                
            }
            
            if ([data isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dict in data) {
                    
                    ModelItem *item = [[ModelItem alloc]init];
                    
                    [item setValuesForKeysWithDictionary:dict];
                    
                    
                    [_reservArray addObject:item];
                    
                    
                }
                
                [self.tableView reloadData];
                
            }
            
        }
        else
        {
            
        }
        
    }];
}

@end
