//
//  AppDelegate.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import <SMS_SDK/SMSSDK.h>
#import "ConstantsHeaders.h"
#import "LoginViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "EaseMob.h"
#import "WXApi.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //设置Navigationbar  背景颜色和字体颜色
    //设置naigationbar 背景颜色和字体颜色
    [[UINavigationBar appearance] setBarTintColor:NavigationBarColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [[UITabBar appearance] setTintColor:kTabbarTintColor];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    

    
    
   #warning 打包注意修改 certname
    
    
    //注册环信
    [[EaseMob sharedInstance] registerSDKWithAppKey:kEaseMobAppKey apnsCertName:kEaseMobPushCertNameDEV];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    
    //注册高德地图
    [MAMapServices sharedServices].apiKey = kGaodeMapKey;
    
    //sharesdk sms 注册
    [SMSSDK registerApp:kShareSDKSMSAppKey withSecret:kShareSDKSMSAppSecret];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
    
    
    //注册微信
    [WXApi registerApp:kWeiChatAPPID];
    
 
    
    return YES;
}

#ifdef __IPHONE_8_0

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
    
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    
}
#endif


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *dToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    dToken = [dToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"STR:%@",dToken);
    
    
    if (dToken)
    {
       
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  
     [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
