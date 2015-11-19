//
//  ShareH5.m
//  Taling
//
//  Created by ZhuHaikun on 15/11/19.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ShareH5.h"

static NSString *title = @"她灵";
NSString *description = @"《她灵》帮您迅速精准定位人才";
static NSString *kLinkTagName = @"WECHAT_TAG_JUMP_SHOWRANK";

static NSString *H5URL =@"";




@implementation ShareH5



+(void)shareWechatPengYouQuan
{
    
    NSString *user_id = [UserInfo getuserid];
    if (!user_id) {
        
        user_id = @"ios";
        
    }
    H5URL = [NSString stringWithFormat:@"%@%@?app=%@",kRequestHeader,kShareH5,user_id];
    
       NSLog(@"H5URL:%@",H5URL);
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = H5URL;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaObject = ext;
    
    message.mediaTagName = kLinkTagName;
//    [message setThumbImage:thumbImage];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.scene = WXSceneTimeline;
    req.message = message;
    
    [WXApi sendReq:req];
    
    
    
    
}
+(void)shareWechatHaoYou
{
    NSString *user_id = [UserInfo getuserid];
    if (!user_id) {
        
        user_id = @"ios";
        
    }
    H5URL = [NSString stringWithFormat:@"%@%@?app=%@",kRequestHeader,kShareH5,user_id];
    
    NSLog(@"H5URL:%@",H5URL);
    
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = H5URL;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaObject = ext;
    
    message.mediaTagName = kLinkTagName;
//    [message setThumbImage:thumbImage];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.scene = WXSceneSession;
    req.message = message;
    
    [WXApi sendReq:req];
}


@end
