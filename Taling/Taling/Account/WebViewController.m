//
//  WebView.m
//  Taling
//
//  Created by ZhuHaikun on 16/1/6.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    _myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    _myWebView.delegate = self;
    
    if (![_url hasPrefix:@"h"]) {
        
        _url = [NSString stringWithFormat:@"http://%@",_url];
        
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    
    
    
    [_myWebView loadRequest:request];
    
    [self.view addSubview:_myWebView];
    
    
    
    
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MyProgressHUD dismiss];
    
    NSLog(@"error:%@",error);
    
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
