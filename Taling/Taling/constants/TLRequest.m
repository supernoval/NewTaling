//
//  TLRequest.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/1.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "TLRequest.h"

@implementation TLRequest



TLRequest *request;

+(TLRequest*)shareRequest
{
    static dispatch_once_t onece;
    
    dispatch_once(&onece, ^{
       
        request = [[TLRequest alloc]init];
        
        
    });
    
    return request;
    
}


-(void)tlRequestWithAction:(NSString *)action Params:(NSDictionary *)param result:(RequestResultBlock)block
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kRequestHeader,action];
    NSLog(@"url:%@",url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSInteger result = [[responseObject objectForKey:@"result"]integerValue];
        
        if (result == 1) {
        
            [CommonMethods showDefaultErrorString:[responseObject objectForKey:@"err_str"]];
            
        }
        if (result == 0)
        {
            
            block(YES,responseObject);
            
            
        }
        
        
         NSLog(@"success:%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"fail:%@,%@",error,operation.responseString);

    }];
    
    

     
    
}

@end
