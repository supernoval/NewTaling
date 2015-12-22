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

@end

@implementation MyCouponTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getMyCoupon];
    
}

- (void)getMyCoupon{
    
    [[TLRequest shareRequest ] tlRequestWithAction:kGetMyCoupon Params:@{@"user_id":[UserInfo getuserid]} result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CouponCell";
    
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil][0];
    }
    
    //标题
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"¥50 优惠券"];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(title.length-3, 3)];
    cell.titleLabel.attributedText = title;
    
    //有效期
    cell.timeLabel.text = @"有效期:2015.10.02-2015.12.20";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
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
    NSDictionary *dic = @{@"money":@(50),@"time":@"2015.02.02-2016.10.10"};
    if (self.couponBlock) {
        self.couponBlock(dic);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)chooseCoupon:(CouponBlock)block{
    self.couponBlock = block;
}
@end
