//
//  MyCouponTVC.h
//  Taling
//
//  Created by ucan on 15/12/18.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void (^CouponBlock)(NSDictionary *dic);

@interface MyCouponTVC : BaseTableViewController
@property (nonatomic, copy)CouponBlock couponBlock;
- (void)chooseCoupon:(CouponBlock)block;

@end
