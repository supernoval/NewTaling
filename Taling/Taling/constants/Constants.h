//
//  Constant.h
//  TaLing
//
//  Created by ZhuHaikun on 15/8/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>


/************************支付宝*******************/
//合作者身份 PID
#define kAlipayParnerID @"2088021776221851"
//账号
#define kAliPaySellerID  @"di3zongdui@163.com"
//URL Schemes
#define kAliPayURLSchemes @"TalingAliPay"

//支付宝购买简历 回调地址
#define kAlipayNotifyURL_1  @"http://183.131.151.50/taling-api/order/alipayCallBack"

//支付宝充值回调
#define kAlipayNotifyURL_2   @"http://183.131.151.50/taling-api/money/InpourAliCallBack"


//PKCS8 密匙
#define kAlipayPriviteKey  @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANods7WAuKcVEbYvozB4Nx6s+KZ94+Xgy/N/CmssQXCtZgACCv605XVOrnlfvmwpq/7uG/OX3Xotz5n4rw/40GTotGjNnsNHeYH07715rIEsGq8nmReCdArPznZ3h63eWnDwU5ZU9LVBxOuYKvjOf5dwMSbRaRwSn2Uh0ZqZY7KlAgMBAAECgYEAyo9w+KudUNXZSAe/luDd16gtl3ksb60v22dtBpDoCTuPkYxUJ61Zt3Klx+Rp1MtyhuMcpEGyFqh6tvRjqAKbjJNbUru10U6CmjyNglT3uZN+oNCwZmP+yAI3nW6twCc3ax+A8Tpeiv86Tf2u0IZMaGFSyxlLNU+BBQllI3S4xWECQQD8DETR8XzQqKHnbBR+/lbU0dI6YaX2g6Jfa2zAeTcQUBs27PP9/g2Jm9fOJa1G4Vy2FVuIqDFD8LiDT/PYFNG5AkEA3Yk6oyws3kNGj4csNr+VxiMnRPGXZF72fnIJ4uNhieGXrWEhH/orgx+lakbIwVxTBd+glTMLelWrZLeYmyyOTQJABh1uFgHb21wcAXdXz/Tvul4U0aHI2wA6kkIS82B9e4HWBzEcgk8FmQ8U30V+vLd+/lPqUphyCYnvkBAChH2M0QJAZtYK6C/bbBliqcGfnpJ0nhM3aWOUWT1TwwKA4FeYsX6NACi0Tbm9dRK9oIXXLxsCVxml21xkmZcnBovLRUz7iQJBAMd+Iz9JG0kCqmd4fvbMQopIi8CyO1h0jUMQl7wtUEDYIiyWoP2H8V4EhtJh230R6Oo242u5wvHvURHoxvoVI6c="
/***********************************************/



/*************************微信支付**************/
//appid
#define kWXAppID        @"wx324fc4f1945fcaac" //APPID
#define APP_SECRET      @"681977bb4aa4fcdcd124779e83cf3ef6" //appsecret
//商户号，填写商户对应参数
#define MCH_ID          @"1280743201"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"681977bb4aa4fcdcd124779e83cf3ef6"

//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"

//购买简历 回调地址
#define WXNOTIFY_URL_1     @"http://183.131.151.50/taling-api/order/weChatCallBack"

//充值 回调地址
#define WXNOTIFY_URL_2     @"http://183.131.151.50/taling-api/money/InpourWeChatCallBack"

/**********************************************/


//支付成功通知
#define kPaySucessNotification      @"PaySuccessNotification"

//环信
#define kEaseMobAppKey                @"15900785196#taling"
#define kEaseMobPushCertNameDEV       @"istore_dev"
#define kEaseMobPushCertNameProduct   @"istore_product"

//高德地图
#define kGaodeMapKey                  @"90587cf4e3bc6f8ea43cae1fe5ba2da5"

//短信验证
#define  kShareSDKSMSAppKey           @"9d573f7c6b9e"
#define  kShareSDKSMSAppSecret        @"2346f2597896eed5d144b3cab6b9d7f6"





/*宽高*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define TagGap 10


/*字体*/
#define FONT_20 [UIFont systemFontOfSize:20]
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_17 [UIFont systemFontOfSize:17]
#define FONT_16 [UIFont systemFontOfSize:16]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_13 [UIFont systemFontOfSize:13]
#define FONT_12 [UIFont systemFontOfSize:12]




#define RGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
//tabar 选中颜色
#define kTabbarTintColor RGB(27,152,241,1.0)

//tabar 未选中颜色
#define kTabbarUnSelectTintColor  RGB(216,216,216,0)

//navigationbar 颜色
#define NavigationBarColor  RGB(27,152,241,0.9)

#define kOrangeTextColor    RGB(255,105,0,0.9)

//背景色
#define kBackgroundColor RGB(240,240,240,1)
#define kContentColor [UIColor whiteColor]
//蓝绿字体
#define kBlueColor RGB(131,205,219,1)

//半透明背景色
#define kTransParentBackColor RGB(200,200,200,0.2)
//黄色字体
#define kYellowColor  RGB(255,105,0,0.9)

//浅灰色气体
#define kLightTintColor  RGB(154, 154, 154, 1)

//标题颜色
#define kTitleColor     RGB(11,30,48,1)

//正文灰色
#define kTextLightGrayColor  RGB(119,119,119,1)

//说明浅灰色
#define kExtralLightGrayColor  RGB(181,181,181,1)


#define kDarkGrayColor   RGB(85,85,85,1.0)

#define kDarkTintColor   RGB(49, 46, 46, 1)

#define CheckNil(a) (a)==nil?@"":(a)


//线颜色
#define kLineColor     RGB(240,240,240,1)

//默认头像
#define kDefaultHeadImage  [UIImage imageNamed:@"test"] 


