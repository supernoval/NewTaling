//
//  UserInfo.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/7.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


+(void)saveModeValue:(id)value key:(NSString*)mykey
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoDic];
    
    if (dic) {
        
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        [muDic setObject:value forKey:mykey];
        [[NSUserDefaults standardUserDefaults ] setObject:muDic forKey:kUserInfoDic];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
     
    }
}
+(UserModel*)getUserInfoModel
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoDic];
    
       UserModel *model = [[UserModel alloc]init];
    if (dic) {
        
     
        
        [model setValuesForKeysWithDictionary:dic];
        
        return model;
    }
    
    
    return model;
    
}
+(void)saveUserInfoDic:(NSDictionary *)dic
{
    
    if (!dic) {
        
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kUserInfoDic];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}
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

+(void)saveInfo:(NSString*)value key:(NSString*)key
{
    
    if (!value) {
        
        return;
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
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
+(NSString*)getnickName
{
    return [[NSUserDefaults standardUserDefaults ] objectForKey:knickname];
}
+(NSString*)getindustry
{
    return [[NSUserDefaults standardUserDefaults ] objectForKey:kindustry];
}
+(NSString*)getcompany
{
    return [[NSUserDefaults standardUserDefaults ] objectForKey:kcompany];
}
+(NSString*)getspecaility
{
    return [[NSUserDefaults standardUserDefaults ] objectForKey:kspeciality];
}

+(NSString*)getphoto
{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kphoto];
    
}

+(NSString*)getcity
{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kcity];
    
}

+(NSString*)getsex
{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:ksex];
    
}

+(BOOL)savecity:(NSString*)city
{
    if (!city) {
        
        return  NO;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:kcity];
    
    return [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(BOOL)saveUserInfo:(id)value key:(NSString *)key
{
    if (!value) {
        
        return NO;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    
    return [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}
+(BOOL)getIsCompany
{
    
    return [[NSUserDefaults standardUserDefaults]boolForKey:kisCompany];
    
}
+ (BOOL)isFocusedHR:(NSInteger)userId{
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:kfocusdHRArray]];
    
    NSLog(@"_____%@",array);
    NSInteger theId = -9999;
    
    
    if (array.count == 0) {
        return NO;
    }else{
        
      
        for (int i = 0; i < array.count; i++) {
            NSInteger oneId = [[array objectAtIndex:i]integerValue];
            
            if (oneId == userId) {
                theId = oneId;
            }
            
        }
        
        if (theId != -9999) {
            return YES;
        }else{
            
            return NO;
        }
        
    }
    
}

+ (BOOL)hasFocusedHR:(NSInteger)userId{
    
    NSMutableArray *array =[[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:kfocusdHRArray]];
    
    
    NSInteger theId = -88888;
    NSInteger theNum = 0;
    
    
        for (NSInteger i = 0; i < array.count; i++) {
            NSInteger oneId = [[array objectAtIndex:i]integerValue];
            
            if (oneId == userId) {
                theId = oneId;
                theNum = i;
            }
            
        }
        
        if (theId != -88888) {
            [array removeObjectAtIndex:theNum];
            [[NSUserDefaults standardUserDefaults]setObject:array forKey:kfocusdHRArray];
            [[NSUserDefaults standardUserDefaults]synchronize];
            return YES;
        }else{
            [array addObject:@(userId)];
            
        
            [[NSUserDefaults standardUserDefaults]setObject:array forKey:kfocusdHRArray];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            return NO;
        }
    
    
}


@end
