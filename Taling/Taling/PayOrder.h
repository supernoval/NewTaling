//
//  PayOrder.h
//  YouKang
//
//  Created by Haikun Zhu on 15/6/18.
//  Copyright (c) 2015年 Ucan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "WXApi.h"
#import "payRequsestHandler.h"
#import "ConstantsHeaders.h"
#import "PayOrderInfoModel.h"

@interface PayOrder : NSObject

#pragma mark -  微信支付
+ (void)sendWXPay:(PayOrderInfoModel*)payInfo;


#pragma mark - 调用支付宝支付
+(void)loadALiPaySDK:(PayOrderInfoModel*)payinfo;

@end
