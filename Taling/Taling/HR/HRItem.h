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
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSArray *customerCompany;
//@[@"id":xxx,@"companyName":@"name",@"license":@""]
@property (strong, nonatomic) NSString *dateJoined;
@property (strong,nonatomic)  NSString *email;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *id;
@property (strong,nonatomic)  NSString *industry;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isStaff;
@property (nonatomic) BOOL isSuperuser;
@property (nonatomic) BOOL isCompany;
@property (strong, nonatomic) NSString *lastLogin;
@property (strong, nonatomic) NSString *lastName;
@property (strong,nonatomic)  NSString *nickname;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSString *speciality;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *username;
@property (nonatomic,strong) NSString *recommend;
@property (nonatomic,strong) NSString *sex;












@end
