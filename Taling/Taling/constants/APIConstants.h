//
//  APIConstants.h
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//



//
#define  kRequestHeader  @"http://183.131.151.50/taling-api"


//注册
/*
 * nickname
 * username
 * password
 */
#define kRegist       @"/user/register"



//登陆
/*
 * username
 * password
 */
#define kLogin     @"/user/login"

//修改个人信息
/*
 *account_id
 *nickname 
 *password
 *is_company
 *is_attestation
 *companyId
 */
#define kupdateUser   @"/user/updateUser"