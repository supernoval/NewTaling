//
//  BindDetailTVC.m
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BindDetailTVC.h"

@interface BindDetailTVC ()

@end

@implementation BindDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定51Job";
    self.tableView.tableFooterView = [self tableFooterView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, ScreenWidth-30, 60)];
    textLabel.font = FONT_14;
    textLabel.textColor = kDarkGrayColor;
    textLabel.numberOfLines = 0;
    textLabel.text = @"在简历接收邮箱中添加TalentBot邮箱，在第三方网站收取简历后，将自动导入到您的TalentBot账户中";
    [footerView addSubview:textLabel];
    
    UILabel *mailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 65, ScreenWidth-30, 20)];
    mailLabel.textColor = kDarkGrayColor;
    mailLabel.font = FONT_14;
    mailLabel.text = @"您的TalentBot邮箱为:xxxx@vip.talentbot.cn";
    [footerView addSubview:mailLabel];
    
    UIButton *bindBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 110, ScreenWidth-30, 40)];
    [bindBtn setTintColor:[UIColor whiteColor]];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    bindBtn.titleLabel.font = FONT_17;
    bindBtn.backgroundColor = NavigationBarColor;
    bindBtn.clipsToBounds = YES;
    bindBtn.layer.cornerRadius = 5.0;
    [bindBtn addTarget:self action:@selector(bindAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:bindBtn];
    return footerView;
}

- (void)bindAction{
}

@end
