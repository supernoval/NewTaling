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


+ (BOOL)isResuemSupport:(NSInteger)resumeId{
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:ksupportResumeArray]]
;
    NSInteger theId = -9999;
    
    
    if (array.count == 0) {
        return NO;
    }else{
        
        NSLog(@"resumeId:%li",resumeId);
        
        for (int i = 0; i < array.count; i++) {
            NSInteger oneId = [[array objectAtIndex:i]integerValue];
            
            if (resumeId == oneId) {
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

+ (BOOL)hasSupportTheResume:(NSInteger)resumeId{
    
    NSMutableArray *array =[[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:ksupportResumeArray]];
    
    
    NSInteger theId = -88888;
    NSInteger theNum = 0;
    
    
        for (NSInteger i = 0; i < array.count; i++) {
            NSInteger oneId = [[array objectAtIndex:i]integerValue];
            
            if (oneId == resumeId) {
                theId = oneId;
                theNum = i;
            }
            
        }
        
        if (theId != -88888) {
            [array removeObjectAtIndex:theNum];
            [[NSUserDefaults standardUserDefaults]setObject:array forKey:ksupportResumeArray];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"i_____d:%li",resumeId);
            
            NSLog(@"_____-zhanshuzhu:%@",array);

            
            return YES;
        }else{
            [array addObject:@(resumeId)];
            
            
            NSLog(@"id:%li",resumeId);
            
            NSLog(@"_____-shuzhu:%@",array);
            [[NSUserDefaults standardUserDefaults]setObject:array forKey:ksupportResumeArray];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            return NO;
        }
        
        
        
//    }
    
    
}

//if (array.count == 0) {
//    
//    [array addObject:resumeId];
//    return NO;
//}else{
//    
//    for (NSInteger i = 0; i < array.count; i++) {
//        NSString *oneId = [array objectAtIndex:i];
//        
//        if ([resumeId isEqualToString:oneId]) {
//            return YES;
//        }else{
//            
//            [array addObject:resumeId];
//            return NO;
//        }
//        
//    }
//    
//    return NO;
//}

//return NO;

@end
