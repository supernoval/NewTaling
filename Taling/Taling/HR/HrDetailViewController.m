//
//  HrDetailViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/10/17.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "HrDetailViewController.h"
#import "ChatViewController.h"

@interface HrDetailViewController ()

@end

@implementation HrDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"人才官详情";
    
    _chatButton.clipsToBounds = YES;
    _chatButton.layer.cornerRadius = 5.0;
    
    

}


- (IBAction)chatAction:(id)sender {
    
//    NSString *chatter = @"15900785196";
    NSString *chatter = @"15201931110";
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:chatter isGroup:NO];
    chatVC.title =chatter;
    [self.navigationController pushViewController:chatVC animated:YES];
    
    
    
}


@end
