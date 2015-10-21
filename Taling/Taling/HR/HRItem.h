//
//  HRItem.h
//  Taling
//
//  Created by Haikun Zhu on 15/10/21.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRItem : NSObject
//HR
@property (strong, nonatomic) NSString *dateJoined;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *id;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isSuperuser;
@property (strong, nonatomic) NSString *lastLogin;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *username;
@property (strong,nonatomic)  NSString *company;
@property (strong,nonatomic)  NSString *email;
@property (strong,nonatomic)  NSString *nickname;
@property (strong,nonatomic)  NSString *industry;


@end
