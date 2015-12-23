//
//  MyCouponTVC.h
//  Taling
//
//  Created by ucan on 15/12/18.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CouponItem.h"

typedef void (^CouponBlock)(CouponItem *item);

@interface MyCouponTVC : BaseTableViewController
@property (nonatomic, copy)CouponBlock couponBlock;
- (void)chooseCoupon:(CouponBlock)block;

@end
