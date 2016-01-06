//
//  TLRequest.m
//  Taling
//
//  Created by Haikun Zhu on 15/9/1.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "TLRequest.h"
#import "MyProgressHUD.h"

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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.timeoutInterval = 20.0;
    
    if ([self showProgress:action]) {
        
        [MyProgressHUD showProgress];
        
    };
    
    [manager POST:url parameters:param  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MyProgressHUD dismiss];
        
        NSInteger result = [[responseObject objectForKey:@"result"]integerValue];
        
        if (result == 1) {
            
            
            if (![action isEqualToString:kRegist]) {
                
                [CommonMethods showDefaultErrorString:[responseObject objectForKey:@"err_str"]];
            }
            
            
            block(NO,nil);
        }
        if (result == 0)
        {
            id data = [responseObject objectForKey:@"data"];
            
            block(YES,data);
            
            
        }
        
        NSLog(@"url:%@,param:%@",url,param);
        
        NSLog(@"success:%@",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MyProgressHUD dismiss];
        
        block(NO,nil);
        
        NSLog(@"url:%@,param:%@",url,param);
        NSLog(@"fail:%@,%@",error,operation.responseString);
    }];
    

   

     
    
}

-(void)requestWithAction:(NSString *)action params:(NSDictionary *)param data:(id)data fileName:(NSString *)fileName minetype:(NSString *)type result:(RequestResultBlock)block
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kRequestHeader,action];
    NSLog(@"url:%@,param:%@",url,param);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.timeoutInterval = 50.0;
    
    if ([self showProgress:action]) {
        
        [MyProgressHUD showProgress];
        
    }
    
    
    
    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (data)
        {
            
         [formData appendPartWithFileData:data name:fileName fileName:fileName mimeType:type];
            
//            [formData appendPartWithFormData:data name:@"photo"];
            
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MyProgressHUD dismiss];
        
        NSInteger result = [[responseObject objectForKey:@"result"]integerValue];
        
        if (result == 1) {
            
            [CommonMethods showDefaultErrorString:[responseObject objectForKey:@"err_str"]];
            
            block(NO,nil);
        }
        if (result == 0)
        {
            id data = [responseObject objectForKey:@"data"];
            
            block(YES,data);
            
            
        }
        
        
        NSLog(@"success:%@",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MyProgressHUD dismiss];
        
        block(NO,nil);
        
        
        NSLog(@"fail:%@,%@",error,operation.responseString);
    }];
    

}



-(void)moreThanDataRequest:(NSString*)action  Params:(NSDictionary*)param result:(RequestResultBlock)block{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kRequestHeader,action];
    NSLog(@"url:%@,param:%@",url,param);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.timeoutInterval = 20.0;
    
    [MyProgressHUD showProgress];
    
    [manager POST:url parameters:param  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MyProgressHUD dismiss];
        
        NSInteger result = [[responseObject objectForKey:@"result"]integerValue];
        
        if (result == 1) {
            
            [CommonMethods showDefaultErrorString:[responseObject objectForKey:@"err_str"]];
            
            block(NO,nil);
        }
        if (result == 0)
        {
//            id data = [responseObject objectForKey:@"data"];
            
            block(YES,responseObject);
            
            
        }
        
        
        NSLog(@"success:%@",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MyProgressHUD dismiss];
        
        block(NO,nil);
        
        
        NSLog(@"fail:%@,%@",error,operation.responseString);
    }];
    

}

-(void)requestWithAction:(NSString *)action params:(NSDictionary *)params datas:(NSDictionary *)dataDict result:(RequestResultBlock)block
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kRequestHeader,action];
    NSLog(@"url:%@,param:%@",url,params);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.timeoutInterval = 20.0;
    
    [MyProgressHUD showProgress];
    
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [dataDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [formData appendPartWithFileData:obj name:key fileName:key mimeType:@"png"];
            
            
        }];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MyProgressHUD dismiss];
        
        NSInteger result = [[responseObject objectForKey:@"result"]integerValue];
        
        if (result == 1) {
            
            [CommonMethods showDefaultErrorString:[responseObject objectForKey:@"err_str"]];
            
            block(NO,nil);
        }
        if (result == 0)
        {
            //            id data = [responseObject objectForKey:@"data"];
            
            block(YES,responseObject);
            
            
        }
        
        
        NSLog(@"success:%@",responseObject);
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MyProgressHUD dismiss];
        
        block(NO,nil);
        
        
        NSLog(@"fail:%@,%@",error,operation.responseString);
        
    }];
    
}


-(BOOL )showProgress:(NSString *)interface
{
    if ([interface isEqualToString:kgetHrInfo] || [interface isEqualToString:kgetCommendResumes] || [interface isEqualToString:kgetAttention] || [interface isEqualToString:kresumesCount] ) {
        
        return NO;
        
    }
    
    return YES;
    
    
}

@end
