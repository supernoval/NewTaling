//
//  ModelItem.h
//  Taling
//
//  Created by ucan on 15/10/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface ModelItem : JSONModel
//简历
@property (nonatomic) NSInteger age;
@property (nonatomic) NSInteger appraiseNum;
@property (nonatomic) NSInteger buyNum;
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
@property (nonatomic) NSInteger goodNum;
@property (strong, nonatomic) NSString *interest;
@property (strong, nonatomic) NSString *marriage;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *photo;
@property (nonatomic) float price;
@property (nonatomic) NSInteger reservNum;
@property (nonatomic) NSInteger resumesId;
@property (strong, nonatomic)NSArray *resumesLabel;
@property (strong, nonatomic) NSString *Resumetype;
@property (strong, nonatomic) NSString *sex;

@property (strong, nonatomic) NSArray *skills;
@property (strong, nonatomic) NSString *status;

@property (strong, nonatomic) NSString *summary;
@property (nonatomic,strong)   NSArray *topsentences; //这个替换上面的summary   里面字典的key: id sentence rank ownerId

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *userId;  //hr_id
@property (nonatomic,strong)  NSString *username;
@property (strong, nonatomic) NSArray *workexpenrience;
@property (nonatomic) NSInteger workYears;


@property (strong, nonatomic) NSString *sellerName;
@property (strong, nonatomic) NSString *buyerName;
@property (strong, nonatomic) NSString *buyTime;
@property (nonatomic,strong) NSString *userPhoto; // 头像




@end
