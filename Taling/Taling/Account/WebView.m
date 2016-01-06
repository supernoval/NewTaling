//
//  WebView.m
//  Taling
//
//  Created by ZhuHaikun on 16/1/6.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import "WebView.h"

@interface WebView ()<UIWebViewDelegate>

@end

@implementation WebView

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    
    
    [_myWebView loadRequest:request];
    
    
    
    
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MyProgressHUD dismiss];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MyProgressHUD showProgress];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MyProgressHUD dismiss];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
