//
//  UserInfo.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/7.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+(void)saveUserInfo:(NSDictionary *)userInfo
{
    [userInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      
        [[NSUserDefaults standardUserDefaults ] setObject:obj forKey:key];
        [[NSUserDefaults standardUserDefaults ]synchronize];
        
    }];
    
    
}

+(NSString*)getAccount_id
{
  
    return [[NSUserDefaults standardUserDefaults] objectForKey:kuuid];
    
}



@end
