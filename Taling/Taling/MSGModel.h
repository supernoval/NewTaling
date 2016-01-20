//
//  MSGModel.h
//  Taling
//
//  Created by ZhuHaikun on 16/1/20.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import "JSONModel.h"

@interface MSGModel : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *level;
@property (nonatomic) NSString *recipient_id;
@property (nonatomic) BOOL Unread;
@property (nonatomic) int acotr_conten_type_id;
@property (nonatomic) NSInteger  actionObjectContentTypeId;
@property (nonatomic) NSInteger  actionObjectObjectId;
@property (nonatomic) NSInteger  actorContentTypeId;
@property (nonatomic) NSInteger  actorObjectId;
@property (nonatomic) NSString  *description_user;
@property (nonatomic) NSInteger  endpage;
@property (nonatomic) NSInteger  messageType;
@property (nonatomic) NSInteger  publicData;
@property (nonatomic) NSString  *recipientId;
@property (nonatomic) NSInteger  startpage;
@property (nonatomic) NSString  *timestamp;
@property (nonatomic) BOOL       unread;
@property (nonatomic) NSString  *userId;
@property (nonatomic) NSString  *verb;



@end
