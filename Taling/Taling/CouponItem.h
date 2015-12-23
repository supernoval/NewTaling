//
//  CouponItem.h
//  Taling
//
//  Created by ucan on 15/12/23.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponItem : NSObject
@property (strong, nonatomic) NSString *id;
@property (nonatomic) float couponPrice;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *userId;

@end
