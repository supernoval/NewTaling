//
//  MyCouponTVC.m
//  Taling
//
//  Created by ucan on 15/12/18.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "MyCouponTVC.h"
#import "CouponCell.h"


@interface MyCouponTVC ()
@property(nonatomic, strong) NSMutableArray *couponArray;

@end

@implementation MyCouponTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    _couponArray = [[NSMutableArray alloc]init];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [self getMyCoupon];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (UIView *)noDataFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 30)];
    footerView.backgroundColor = [UIColor clearColor];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:footerView.frame];
    textLabel.font = FONT_14;
    textLabel.textColor = kTextLightGrayColor;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"暂无优惠券";
    [footerView addSubview:textLabel];
    return footerView;
}

- (void)headRefresh{
    [self getMyCoupon];
}

- (void)getMyCoupon{
    
    [[TLRequest shareRequest ] tlRequestWithAction:kGetMyCoupon Params:@{@"user_id":[UserInfo getuserid]} result:^(BOOL isSuccess, id data) {
        
        [self.tableView.header endRefreshing];
        if (isSuccess) {
            if ([data isKindOfClass:[NSArray class]]) {
                
                NSArray *dataArray = [[NSArray alloc]init];
                NSMutableArray *array = [[NSMutableArray alloc]init];
                dataArray = data;
                for (NSInteger i=0; i<dataArray.count; i++) {
                    NSDictionary *oneDic = [dataArray objectAtIndex:i];
                    CouponItem *item = [[CouponItem alloc]init];
                    [item setValuesForKeysWithDictionary:oneDic];
                    if ([item.status integerValue] == 1) {
                        [array addObject:item];
                    }
                    
                }
                [_couponArray removeAllObjects];
                [_couponArray addObjectsFromArray:array];
                if (_couponArray.count==0) {
                    self.tableView.tableFooterView = [self noDataFooterView];
                }else{
                    self.tableView.tableFooterView = nil;
                }
                [self.tableView reloadData];
            }
            
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_couponArray.count > indexPath.section) {
        
        CouponItem *oneItem = [_couponArray objectAtIndex:indexPath.section];
        static NSString *cellId = @"CouponCell";
        
        CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil][0];
        }
        //标题
        NSString *titleStr = [NSString stringWithFormat:@"¥%.0f 优惠券",oneItem.couponPrice];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:titleStr];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(title.length-3, 3)];
        cell.titleLabel.attributedText = title;
        
        //有效期
        NSString *startTime = oneItem.startTime;
        if (startTime.length>10) {
            startTime = [startTime substringFromIndex:10];
        }
        
        NSString *endTime = oneItem.endTime;
        if (endTime.length>10) {
            endTime = [endTime substringFromIndex:10];
        }
        cell.timeLabel.text = [NSString stringWithFormat:@"有效期:%@-%@",startTime,endTime];
        return cell;
    }else{
        
        return nil;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _couponArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_couponArray.count > indexPath.section) {
        CouponItem *item = [_couponArray objectAtIndex:indexPath.section];
        if (self.couponBlock) {
            self.couponBlock(item);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)chooseCoupon:(CouponBlock)block{
    self.couponBlock = block;
}
@end
