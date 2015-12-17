//
//  UserInfo.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/7.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSUserDefaultKeys.h"
#import "Constants.h"

@interface UserInfo : NSObject


+(void)saveUserInfo:(NSDictionary*)userInfo;
+(void)saveInfo:(NSString*)value key:(NSString*)key;

+(NSString*)getAccount_id; //uuid

+(NSString*)getuserid;

+(NSString*)getUsername;
+(NSString*)getnickName;
+(NSString*)getindustry;
+(NSString*)getcompany;
+(NSString*)getspecaility;
+(BOOL)getIsCompany;



#pragma mark- 界面展示时判断HR是否已经关注

+ (BOOL)isFocusedHR:(NSInteger)userId;

#pragma mark- 关注人才官存储本地

+ (BOOL)hasFocusedHR:(NSInteger)userId;

@end
