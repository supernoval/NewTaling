//
//  CommentItem.m
//  Taling
//
//  Created by ucan on 15/12/11.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CommentItem.h"

@implementation CommentItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"CommentItem 中缺少指定字段:%@",key);
}

@end
