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
      
        if (![key isEqualToString:@"password"]) {
            
            NSCharacterSet *whitespace = [NSCharacterSet  whitespaceAndNewlineCharacterSet];
            
            NSString * objStr = [NSString stringWithFormat:@"%@",obj];
            
            
            objStr = [objStr  stringByTrimmingCharactersInSet:whitespace];
            
            
            [[NSUserDefaults standardUserDefaults ] setObject:objStr forKey:key];
            [[NSUserDefaults standardUserDefaults ]synchronize];
        }
     
        
    }];
    
    
}

+(NSString*)getAccount_id
{
  
    return [[NSUserDefaults standardUserDefaults] objectForKey:kuuid];
    
}

+(NSString*)getuserid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kuserid];
}

+(NSString*)getUsername
{
    return [[NSUserDefaults standardUserDefaults ] objectForKey:kusername];
    
}


@end
