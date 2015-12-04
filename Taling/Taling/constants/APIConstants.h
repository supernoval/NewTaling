//
//  APIConstants.h
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//



//本地测试
//#define  kRequestHeader   @"http://192.168.40.176/taling-api"
//正式
#define  kRequestHeader     @"http://183.131.151.50/taling-api"

//#define  kRequestHeader     @"http://www.talentbot.cn/taling-api"




//注册
/*
 
 * username      公司账号传 公司邮箱
 * password
 
 * is_company     公司 1   个人 0
 * phone          只有公司注册 并且通过手机验证才有
 */
#define kRegist       @"/user/register"

//上传公司信息
/*
    user_id
    company_name
    company_code     税务登记号
    company_number   组织机构代码
    pic_license    //营业执照
    pic_IDCARD1
    pic_IDCARD2
 
 */
#define kuploadCompanyInfo   @"/user/uploadCompanyInfo"

//登陆
/*
 * username
 * password
 
 返回 is_active   0未激活 1已激活
 返回  userStatus  0已传公司信息   1公司账号未激活   2账号已激活 未传资料
 */
#define kLogin     @"/user/login"

//修改个人信息
/*
 *user_id     用户id
 *work_year   工作年限
 *nickname    昵称
 *industry    行业
 *summary     自我描述  标签 
 *company     所在公司
 *photo       图片在appendData 里加
 *speciality   擅长
 
 */
#define kupdateUser   @"/user/updateUser"


//修改头像
/*
 user_id   
 pic_file  这个是文件名
 */
#define kuploadPic    @"/uploadPic"

//修改密码
/*
 前段验证
 nickname=xxx&password=xxxx
 */
#define kupdatePwd    @"/user/updatePwd"


//获取统计 简历、简历估值
#define kresumesCount    @"/user/resumesCount"


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
 * search  //可选

 */
#define kgetCommendResumes @"/resume/getCommendResumes"


//搜索标签 获取简历数据
/*
 search
 index
 size
 user_id
 */
#define ksearchResumes    @"/resume/searchResumes"


// 获取我搜索过的标签记录
/*
 user_id    用户id
 */
#define kgetUserLabel      @"/resume/getUserLabel"

//获取上传的简历
/*
 * user_id
 * index    页码
 * size    每页数量
 */
#define kgetMyResumes   @"/resume/getMyResumes"

//获取 已买／已卖 的简历
/*
 *index
 *size
 *sale_user_id  (获取已卖时给)
 *buy_user_id    (获取已买时给)
 */
#define kgetMyBuyResumes   @"/resume/getMyBuyResumes"

//获取有简历的 HR列表
/*
 *index
 *size
 */
#define kgetHrInfo           @"/resume/getHrInfo"

//搜索HR信息
#define ksearchHrInfo        @"/resume/getHrInfoBySearch"

//创建订单
/*
 resumes_id 是简历ID   你在获取简历的时候 会获取到
 seller_id   是卖家ID  也就是简历上传者的ID  你在获取简历的时候 也会获取到这个值
 buyer_id  这个是买家ID也是 登录用户的ID  也就是 你登录APP的时候  我会返回给你的用户相关信息
 order_price  这个是简历价格   会在简历相关信息里面。
 coupon_id   优惠券 ID
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


#pragma mark - 余额购买简历
/*
 * order_no 下单生成的订单号
 */
#define kBuyResumeByRemaim     @"/money/buyResume"

#pragma mark - 获取钱包数据
/*
 * user_id
 */
#define kGetAuthMoney     @"/money/getAuthMoney"

#pragma mark - 充值提现
/*
 * user_id
 * money
 * type 1 支付宝 2微信
 * action 1 提现 2 充值
 *account  //提现的时候账号     /充值的时候如果需要发票，则为发票抬头
 */
#define kBuyAndCash     @"/money/inpour"

#pragma mark - 绑定邮箱
/*
 * user_id
 * email
 */
#define kBindingEmail     @"/user/bindingEmail"


#pragma mark -获取我的优惠券
/*
 * user_id   用户id
 *
 */
#define kGetMyCoupon    @"/user/getMyCoupon"


#pragma mark - H5分享地址
/*
 *app      填用户id  user_id
 */
#define kShareH5         @"/test.jsp"


#pragma mark 添加关注 
/*
 * hr_id
 * user_id  
 */
#define kAttentionHr    @"/attention/attentionHr"

#pragma mark - 取消关注
/*
 *  hr_id
    user_id
 */
#define kcancelAttention  @"/attention/cancelAttention"



#pragma mark - 获取关注列表
/*
 * user_id
 */
#define kgetAttention    @"/attention/getAttention"
