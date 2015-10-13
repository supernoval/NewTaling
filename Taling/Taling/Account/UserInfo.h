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



@end
