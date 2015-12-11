//
//  CommentItem.h
//  Taling
//
//  Created by ucan on 15/12/11.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentItem : NSObject
@property (nonatomic, strong)NSString *comment;
@property (nonatomic, strong)NSString *commentUser;
@property (nonatomic, strong)NSString *endpage;
@property (nonatomic, strong)NSString *photo;
@property (nonatomic)NSInteger resumesId;
@property (nonatomic, strong)NSString *startpage;
@property (nonatomic, strong)NSString *time;

@end
