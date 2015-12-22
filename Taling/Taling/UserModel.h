//
//  UserModel.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/22.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel


@property (nonatomic) NSString *city;
@property (nonatomic) NSString *company;
@property  (nonatomic) NSString *companyCode;
@property (nonatomic) NSString *companyDescription;
@property (nonatomic) NSString *companyLicense;
@property (nonatomic) NSString *companyName;
@property (nonatomic) NSString *companyNum;
@property (nonatomic) NSString *companyURL;
@property (nonatomic) NSString *dateJoined;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *id;
@property (nonatomic) NSString *industry;
@property (nonatomic) NSInteger is_active;
@property (nonatomic) NSInteger is_company;
@property (nonatomic) NSString *lastLogin;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *nickname;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *photo;
@property (nonatomic) NSString *sex;
@property (nonatomic) NSString *speciality;
@property (nonatomic) NSString *summary;
@property (nonatomic) NSInteger userStatus;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *workingYears;

@property (nonatomic) NSData *photo_data;
@property (nonatomic) NSData *pic_license_data;
@property  (nonatomic) NSData *company_code_data;
@property (nonatomic) NSData *company_number_data;




@end
