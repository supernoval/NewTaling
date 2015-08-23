//
//  Constant.h
//  TaLing
//
//  Created by ZhuHaikun on 15/8/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <Foundation/Foundation.h>




/*宽高*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


/*字体*/
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_17 [UIFont systemFontOfSize:17]
#define FONT_16 [UIFont systemFontOfSize:16]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_13 [UIFont systemFontOfSize:13]
#define FONT_12 [UIFont systemFontOfSize:12]



/*颜色*//*牵手邦里的颜色一共只有红，绿，灰，黑。
       红色：R，255    G，0   B，0
       主打绿色：R,65,  G,174,    B,158
       灰色：R,154    G,154    B,154
       黑色：R,0     G,0     B,0
       下面五个大图标绿色：R,10    G,184    B,7   */


#define RGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
//tabar 选中颜色
#define TabbarTintColor RGB(10,184,7,1.0)

//navigationbar 颜色
#define NavigationBarColor  RGB(255,128,0,0.9)


//背景色
#define kBackgroundColor RGB(239,239,244,1)
#define kContentColor [UIColor whiteColor]
#define kLineColor RGB(240,240,240,1)
//蓝绿字体
#define kBlueColor RGB(65,174,158,1)

//半透明背景色
#define kTransParentBackColor RGB(200,200,200,0.2)
//黄色字体
#define kYellowColor RGB(253,159,8,1)

//浅灰色气体
#define kLightTintColor  RGB(154, 154, 154, 1)

#define kDarkTintColor  RGB(49, 46, 46, 1)

#define CheckNil(a) (a)==nil?@"":(a)



#define kDarkTintColor   RGB(49, 46, 46, 1)

