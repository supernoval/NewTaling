//
//  APIConstants.h
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//



//本地测试
#define  kRequestHeader  @"http://192.168.40.233/taling-api"
//正式
//#define  kRequestHeader  @"http://183.131.151.50/taling-api"




//注册
/*
 
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
 *user_id     用户id
 *work_year   工作年限
 *nickname    昵称
 *industry    行业
 *summary     自我描述
 *company     所在公司
 *photo       图片在appendData 里加
 */
#define kupdateUser   @"/user/updateUser"


//修改头像
/*
 user_id   
 pic_file  这个是文件名
 */
#define kuploadPic    @"/uploadPic"


//获取推荐列表
// http://183.131.151.50/taling-api/resume/getCommendResumes?index=1&size=10
/*
 *index
 *size
 */

#define kgetCommendResumes @"/resume/getCommendResumes"


//获取评价
/*
 *resumes_id    简历ID
 *index
 *size

 */
#define kgetAppraise  @"/appraise/getAppraise"

//评价简历
/*
 *user_id  用户id
 *resumes_id  简历id
 *comment     评价内容
 */
#define kaddAppraise    @"/appraise/addAppraise"


//获取推荐简历列表
/*

 *index  
 *size
 */
#define kgetCommendResumes @"/resume/getCommendResumes"


//获取上传的简历
/*
 * user_id  用户id
 * index    页码
 *  size    每页数量
 */
#define kgetMyResumes   @"/resume/getMyResumes"

//获取已购买的简历
/*
 *index
 *size
 *user_id
 */
#define kgetMyBuyResumes   @"/resume/getMyBuyResumes"

//获取有简历的 HR列表
/*
 *index
 *size
 */
#define kgetHrInfo           @"/resume/getHrInfo"



//创建订单
/*
 resumes_id 是简历ID   你在获取简历的时候 会获取到
 seller_id   是卖家ID  也就是简历上传者的ID  你在获取简历的时候 也会获取到这个值
 buyer_id  这个是买家ID也是 登录用户的ID  也就是 你登录APP的时候  我会返回给你的用户相关信息
 order_price  这个是简历价格   会在简历相关信息里面。
 */
#define kcreatOrder          @"/order/createOrder"

//简历点赞
#define ksupportTheResume @"/support/resumesSupport"


//简历取消点赞
#define kcancelSupportTheResume @"/support/CancelSupport"

#pragma mark － 预定简历
/*reserv/reservResume?resumes_id=1&user_id=1
 * resumes_id
 * user_id
 */
#define kreservResume         @"/reserv/reservResume"

#pragma mark - 取消预定
/*/reserv/cancelReserv?resumes_id=1&user_id=1 
 * resumes_id
 * user_id
 */
#define kcancelReserv         @"/reserv/cancelReserv"

#pragma mark - 获取预定列表
/*/reserv/GetReservResumes?user_id=1&index=&size= 
 * user_id
 * index
 * size
 */
#define kGetReservResumes     @"/reserv/GetReservResumes"


