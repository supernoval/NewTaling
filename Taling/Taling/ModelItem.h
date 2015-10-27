//
//  ModelItem.h
//  Taling
//
//  Created by ucan on 15/10/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelItem : NSObject
//简历
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *appraiseNum;
@property (strong, nonatomic) NSString *buyNum;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *currentCompany;
@property (strong, nonatomic) NSString *currentIndustry;
@property (strong, nonatomic) NSString *currentPosition;
@property (strong, nonatomic) NSString *currentSalary;

@property (strong, nonatomic)NSArray *eduexpenrience;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *expectCity;
@property (strong, nonatomic) NSString *expectIndustry;
@property (strong, nonatomic) NSString *expectPosition;
@property (strong, nonatomic) NSString *expectSalary;
@property (strong, nonatomic) NSString *fromResource;
@property (strong, nonatomic) NSString *goodNum;
@property (strong, nonatomic) NSString *marriage;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *resumesId;
@property (strong, nonatomic) NSString *sex;

@property (strong, nonatomic)NSArray *skills;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic)NSArray *workexpenrience;
@property (strong, nonatomic)NSString *workYears;
@property (strong, nonatomic)NSString *sellerName;
@property (strong, nonatomic)NSString *buyerName;
@property (strong, nonatomic)NSString *buyTime;


//下单成功返回
@property (strong, nonatomic) NSString *buyerId;
@property (strong, nonatomic) NSString *fcd;
@property (strong, nonatomic) NSString *lmd;
@property (strong, nonatomic) NSString *orderNo;
@property (strong, nonatomic) NSString *orderPrice;
@property (strong, nonatomic) NSString *resumeId;
@property (strong, nonatomic) NSString *sellerId;

@end
