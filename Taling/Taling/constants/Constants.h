//
//  Constant.h
//  TaLing
//
//  Created by ZhuHaikun on 15/8/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>



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
#define kTabbarTintColor RGB(255,105,0,1.0)

//tabar 未选中颜色
#define kTabbarUnSelectTintColor  RGB(216,216,216,0)

//navigationbar 颜色
#define NavigationBarColor  RGB(255,105,0,0.9)

#define kOrangeTextColor    RGB(255,105,0,0.9)

//背景色
#define kBackgroundColor RGB(240,240,240,1)
#define kContentColor [UIColor whiteColor]
#define kLineColor RGB(240,240,240,1)
//蓝绿字体
#define kBlueColor RGB(65,174,158,1)

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

