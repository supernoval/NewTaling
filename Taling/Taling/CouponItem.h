//
//  CouponItem.h
//  Taling
//
//  Created by ucan on 15/12/23.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponItem : NSObject
@property(nonatomic, strong)NSString *id;
@property(nonatomic)float couponPrice;
@property(nonatomic, strong)NSString *startTime;
@property(nonatomic, strong)NSString *endTime;
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *userId;
@property (nonatomic,strong) NSString *fcd;



@end
