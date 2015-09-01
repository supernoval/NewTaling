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

-(void)tlRequestWithAction:(NSString*)action  Params:(NSDictionary*)param result:(RequestResultBlock)block;


@end
