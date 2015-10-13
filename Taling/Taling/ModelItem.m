//
//  ModelItem.m
//  Taling
//
//  Created by ucan on 15/10/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ModelItem.h"

@implementation ModelItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"ModelItem 中缺少指定字段");
}
@end
