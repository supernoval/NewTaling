//
//  WorkExperienceItem.h
//  Taling
//
//  Created by ucan on 15/10/22.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkExperienceItem : NSObject

//工作经历
@property (strong, nonatomic)NSString *candidateId;
@property (strong, nonatomic)NSString *companyDescription;
@property (strong, nonatomic)NSString *companyIndustry;
@property (strong, nonatomic)NSString *companyName;
@property (strong, nonatomic)NSString *companyProperty;
@property (strong, nonatomic)NSString *companyScope;
@property (strong, nonatomic)NSString *department;
@property (strong, nonatomic)NSString *directReports;
@property (strong, nonatomic)NSString *id;
@property (strong, nonatomic)NSString *main;
@property (strong, nonatomic)NSString *performance;
@property (strong, nonatomic)NSString *periodFrom;
@property (strong, nonatomic)NSString *periodTo;
@property (strong, nonatomic)NSString *reportingManager;
@property (strong, nonatomic)NSString *salary;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *workingPosition;


//工作技能
@property (strong, nonatomic)NSString *skillName;
@property (strong, nonatomic)NSString *skillPeriod;
@property (strong, nonatomic)NSString *skillStatus;

@end
