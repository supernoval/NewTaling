//
//  WebView.h
//  Taling
//
//  Created by ZhuHaikun on 16/1/6.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface WebView : BaseViewController


@property (nonatomic) NSString *url;


@property (weak, nonatomic) IBOutlet UIWebView *myWebView;



@end
