//
//  TLRequest.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/1.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantsHeaders.h"


typedef void (^RequestResultBlock)(BOOL isSuccess,id data);


@interface TLRequest : NSObject


+(TLRequest*)shareRequest;

#pragma mark - 批量传照片数据 
-(void)requestWithAction:(NSString*)action params:(NSDictionary*)params datas:(NSDictionary*)dataDict result:(RequestResultBlock)block;

-(void)tlRequestWithAction:(NSString*)action  Params:(NSDictionary*)param result:(RequestResultBlock)block;

-(void)requestWithAction:(NSString*)action  params:(NSDictionary*)param data:(id)data fileName:(NSString*)fileName minetype:(NSString*)type result:(RequestResultBlock)block;


-(void)moreThanDataRequest:(NSString*)action  Params:(NSDictionary*)param result:(RequestResultBlock)block;

@end
