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

+(NSString*)getAccount_id; //uuid

+(NSString*)getuserid;

+(NSString*)getUsername;

#pragma mark- 界面展示时判断简历是否已经点赞

+ (BOOL)isResuemSupport:(NSInteger)resumeId;

#pragma mark- 简历点赞存储本地

+ (BOOL)hasSupportTheResume:(NSInteger)resumeId;



@end
