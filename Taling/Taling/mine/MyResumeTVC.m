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
#import "UIImageView+WebCache.h"

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
    NSDictionary *_buyDic;//购买简历份数、金额
    NSDictionary *_upLoadDic;//出售简历份数、金额
    
    
    
}
@property (nonatomic)ResumeListType segMentType;

@end

@implementation MyResumeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _segMentType = ResumeListTypeBuy;
    self.tableView.tableHeaderView = [self buyTableHeadView];
    
    _buyDic = [[NSDictionary alloc]init];
    _upLoadDic = [[NSDictionary alloc]init];
    
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
    
    
    UILabel *buyNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth/2, 30)];
    buyNum.font = FONT_17;
    buyNum.textAlignment = NSTextAlignmentCenter;
    buyNum.textColor = [UIColor blackColor];
    if ([_upLoadDic objectForKey:@"resumesCountSum"] == nil) {
        buyNum.text = @"0份";
    }else{
    buyNum.text = [NSString stringWithFormat:@"%@份",[_upLoadDic objectForKey:@"resumesCountSum"]];
    }
    [buyView addSubview:buyNum];
    
    UILabel *buyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth/2, 20)];
    buyLabel.text = @"已售简历数";
    buyLabel.textColor = kDarkGrayColor;
    buyLabel.font = FONT_15;
    buyLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:buyLabel];
    
    UILabel *sellMoney = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 15, ScreenWidth/2, 30)];
    sellMoney.font = FONT_17;
    sellMoney.textAlignment = NSTextAlignmentCenter;
    sellMoney.textColor = [UIColor blackColor];
    sellMoney.text = [NSString stringWithFormat:@"%.2f元",[[_upLoadDic objectForKey:@"resumesCountPrice"]floatValue]];
    [buyView addSubview:sellMoney];
    
    UILabel *sellLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 45, ScreenWidth/2, 20)];
    sellLabel.text = @"已售简历总估值";
    sellLabel.textColor = kDarkGrayColor;
    sellLabel.font = FONT_15;
    sellLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:sellLabel];
    
    /*
    UILabel *buyNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth/3, 30)];
    buyNum.font = FONT_17;
    buyNum.textAlignment = NSTextAlignmentCenter;
    buyNum.textColor = [UIColor blackColor];
    buyNum.text = [NSString stringWithFormat:@"%@份",[_upLoadDic objectForKey:@"resumesCountSum"]];
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
    sellMoney.text = [NSString stringWithFormat:@"%.2f元",[[_upLoadDic objectForKey:@"resumesCountPrice"]floatValue]];
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
    earnMoney.text = [NSString stringWithFormat:@"%.2f元",[[_upLoadDic objectForKey:@"resumesCountPrice"]floatValue]];
    [buyView addSubview:earnMoney];
    
    UILabel *earnLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*2/3, 45, ScreenWidth/3, 20)];
    earnLabel.text = @"已赚取总额";
    earnLabel.textColor = kDarkGrayColor;
    earnLabel.font = FONT_15;
    earnLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:earnLabel];*/
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 79, ScreenWidth-15, 1)];
    line.backgroundColor = kLineColor;
    [buyView addSubview:line];
    return buyView;
}


- (UIView *)buyTableHeadView{
    
    UIView *buyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    buyView.backgroundColor = kContentColor;
    
    UILabel *buyNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth/2, 30)];
    buyNum.font = FONT_17;
    buyNum.textAlignment = NSTextAlignmentCenter;
    buyNum.textColor = [UIColor blackColor];
    if ([_buyDic objectForKey:@"resumesCountSum"] == nil) {
        buyNum.text = @"0份";
    }else{
    buyNum.text = [NSString stringWithFormat:@"%@份",[_buyDic objectForKey:@"resumesCountSum"]];
    }
    [buyView addSubview:buyNum];
    
    UILabel *buyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth/2, 20)];
    buyLabel.text = @"已购简历数";
    buyLabel.textColor = kDarkGrayColor;
    buyLabel.font = FONT_15;
    buyLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:buyLabel];
    
    UILabel *sellMoney = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 15, ScreenWidth/2, 30)];
    sellMoney.font = FONT_17;
    sellMoney.textAlignment = NSTextAlignmentCenter;
    sellMoney.textColor = [UIColor blackColor];
    
    sellMoney.text = [NSString stringWithFormat:@"%.2f元",[[_buyDic objectForKey:@"resumesCountPrice"]floatValue]];
    [buyView addSubview:sellMoney];
    
    UILabel *sellLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 45, ScreenWidth/2, 20)];
    sellLabel.text = @"已购简历总估值";
    sellLabel.textColor = kDarkGrayColor;
    sellLabel.font = FONT_15;
    sellLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:sellLabel];

    
    /*
    UILabel *buyNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth/3, 30)];
    buyNum.font = FONT_17;
    buyNum.textAlignment = NSTextAlignmentCenter;
    buyNum.textColor = [UIColor blackColor];
    buyNum.text = @"0份";
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
    sellMoney.text = @"0元";
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
    earnMoney.text = @"0元";
    [buyView addSubview:earnMoney];
    
    UILabel *earnLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*2/3, 45, ScreenWidth/3, 20)];
    earnLabel.text = @"已花费总额";
    earnLabel.textColor = kDarkGrayColor;
    earnLabel.font = FONT_15;
    earnLabel.textAlignment = NSTextAlignmentCenter;
    [buyView addSubview:earnLabel];*/
    
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
    switch (_segMentType) {
        case ResumeListTypeBuy:
        {
            return 111;
        }
            break;
        case ResumeListTypeSell:
        {
            return 111;
        }
            break;
        case ResumeListTypeReserv:
        {
           return 85;
        }
            break;
            
            
        default:
        {
            return 0;
            
        }
            break;
    }

    
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
            
          ModelItem *oneItem = [_buyArray objectAtIndex:indexPath.section];
            
            //头像
            if (oneItem.url.length > 0) {
                
                [buyCell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.url]];
            }
            
            //姓名
            buyCell.nameLabel.text = oneItem.name;
            
            CGFloat namewith = [StringHeight widthtWithText:oneItem.name font:FONT_15 constrainedToHeight:20] + 5;
            
            buyCell.nameWidth.constant = namewith;
            
            //性别
            if ([oneItem.sex isEqualToString:@"男"]) {
                buyCell.sexImageView.image = [UIImage imageNamed:@"male"];
            }else if ([oneItem.sex isEqualToString:@"女"]){
                buyCell.sexImageView.image = [UIImage imageNamed:@"female"];
            }else{
                buyCell.sexImageView.image = [UIImage imageNamed:@""];
            }
            // 简历估值
            buyCell.buyMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[oneItem.price floatValue]] ;
            
            //城市、教育程度
            NSString *edu = @"";
            if (oneItem.eduexpenrience.count > 0) {
                NSDictionary *eduDic = [oneItem.eduexpenrience firstObject];
                edu = [eduDic objectForKey:@"degree"];
            }
            buyCell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,edu];
            
            //职业、经验
            
            buyCell.professionLabel.text = [NSString stringWithFormat:@"%@ %@年经验",oneItem.currentPosition,oneItem.workYears];
            
            //购买自
            buyCell.buyNameLabel.text = @"购买于谁";
            
            //购买时间
            buyCell.timeLabel.text = @"201111111";
            
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
            
            ModelItem *oneItem = [_upLoadArray objectAtIndex:indexPath.section];
            
            
            
            //头像
            if (oneItem.url.length > 0) {
                
                [sellCell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.url]];
            }
            
            //姓名
            sellCell.nameLabel.text = oneItem.name;
            
            CGFloat namewith = [StringHeight widthtWithText:oneItem.name font:FONT_15 constrainedToHeight:20] + 5;
            
            sellCell.nameWidth.constant = namewith;
            
            //性别
            if ([oneItem.sex isEqualToString:@"男"]) {
                sellCell.sexImageView.image = [UIImage imageNamed:@"male"];
            }else if ([oneItem.sex isEqualToString:@"女"]){
                sellCell.sexImageView.image = [UIImage imageNamed:@"female"];
            }else{
                sellCell.sexImageView.image = [UIImage imageNamed:@""];
            }
            //被购买次数
            sellCell.buyNumLabel.text = oneItem.buyNum;
            
            //城市、教育程度
            NSString *edu = @"";
            if (oneItem.eduexpenrience.count > 0) {
                NSDictionary *eduDic = [oneItem.eduexpenrience firstObject];
                edu = [eduDic objectForKey:@"degree"];
            }
            sellCell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,edu];
            
            //职业、经验
            sellCell.professionLabel.text = [NSString stringWithFormat:@"%@ %@年经验",oneItem.currentPosition,oneItem.workYears];
            
            //最近被购买人
            sellCell.buyNameLabel.text = @"购买于谁";
            
            //最近被购买时间
            sellCell.timeLabel.text = @"201111111";

            
            
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
            
            ModelItem *oneItem = [_reservArray objectAtIndex:indexPath.section];
            
            reservCell.buyTextLabel.hidden = YES;
            
            //头像
            if (oneItem.url.length > 0) {
                
                [reservCell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.url]];
            }
            
            //姓名
            reservCell.nameLabel.text = oneItem.name;
            
            CGFloat namewith = [StringHeight widthtWithText:oneItem.name font:FONT_15 constrainedToHeight:20] + 5;
            
            reservCell.nameWidth.constant = namewith;
            
            //性别
            if ([oneItem.sex isEqualToString:@"男"]) {
                reservCell.sexImageView.image = [UIImage imageNamed:@"male"];
            }else if ([oneItem.sex isEqualToString:@"女"]){
                reservCell.sexImageView.image = [UIImage imageNamed:@"female"];
            }else{
                reservCell.sexImageView.image = [UIImage imageNamed:@""];
            }
            // 简历估值
            reservCell.buyMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[oneItem.price floatValue]] ;
            
            //城市、教育程度
            NSString *edu = @"";
            if (oneItem.eduexpenrience.count > 0) {
                NSDictionary *eduDic = [oneItem.eduexpenrience firstObject];
                edu = [eduDic objectForKey:@"degree"];
            }
            reservCell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,edu];
            
            //职业、经验
            
            reservCell.professionLabel.text = [NSString stringWithFormat:@"%@ %@年经验",oneItem.currentPosition,oneItem.workYears];
            
            //最近预定人
            reservCell.buyNameLabel.hidden = YES;
            
            //最近预定时间
            reservCell.timeLabel.hidden = YES;
  
        }

        return reservCell;
    }
    
    return nil;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ResumeDetailVC *detail = [sb instantiateViewControllerWithIdentifier:@"ResumeDetailVC"];
    
    ModelItem *item ;
    
    if (_segMentType == ResumeListTypeBuy) {
        
        item = [_buyArray objectAtIndex:indexPath.section];
        detail.type = 2;
        
        
    }
    else if(_segMentType == ResumeListTypeSell)
    {
        item = [_upLoadArray objectAtIndex:indexPath.section];
        detail.type = 2;
        
    }else{
        
        item = [_reservArray objectAtIndex:indexPath.section];
        detail.type = 1;
    }
    
    
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
        
        self.tableView.tableHeaderView = nil;
        
        
        
    }
    
    
    
    [self.tableView reloadData];
    
    
    [self headerRefresh];
    
}

#pragma mark - 请求数据
-(void)requestUpLoadResumes
{
    NSString *userid = [UserInfo getuserid];
    
    NSDictionary *param = @{@"sale_user_id":userid,@"buy_user_id":@"",@"index":@(upLoadIndex),@"size":@(pageSize)};
    
    [[TLRequest shareRequest] moreThanDataRequest:kgetMyResumes Params:param result:^(BOOL isSuccess, id data) {
    
        [self endFooterRefresh];
        [self endHeaderRefresh];
        
        
        if (isSuccess) {
         
            _upLoadDic = [data objectForKey:@"count"];
            NSLog(@"_________________:%@",_upLoadDic);
            if (upLoadIndex == 1) {
                
                [_upLoadArray removeAllObjects];
                
            }
            
            if ([[data objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dict in [data objectForKey:@"data"]) {
                    
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
    
    NSDictionary *param = @{@"buy_user_id":userid,@"sale_user_id":@"",@"index":@(buyIndex),@"size":@(pageSize)};
    
    
    [[TLRequest shareRequest] moreThanDataRequest:kgetMyBuyResumes Params:param result:^(BOOL isSuccess, id data) {
        
        [self endFooterRefresh];
        [self endHeaderRefresh];
        
        
        if (isSuccess) {
            _buyDic = [data objectForKey:@"count"];
            
            if (buyIndex == 1) {
                
                [_buyArray removeAllObjects];
                
            }
            
            if ([[data objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dict in [data objectForKey:@"data"]) {
                    
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
