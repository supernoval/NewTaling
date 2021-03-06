//
//  SettingTVC.m
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "SettingTVC.h"
#import "NSUserDefaultKeys.h"
#import "ChangePasswordTVC.h"
#import "SDImageCache.h"

@interface SettingTVC ()<UIAlertViewDelegate>
@property (strong, nonatomic)UIAlertView *logoutAlertView;

@end

@implementation SettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.tableFooterView = [self tableFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 15;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                //账号与安全
                ChangePasswordTVC *pwd = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordTVC"];
                [self.navigationController pushViewController:pwd animated:YES];
            }else if (indexPath.row == 1){
                // 清除缓存
                UIAlertView *clearAlert = [[UIAlertView alloc]initWithTitle:nil message:@"确定清除缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                clearAlert.tag = 999;
                
                [clearAlert show];
                
                
                
                
            }
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0) {
                //关于
                
                UINavigationController *_privacy = [self.storyboard instantiateViewControllerWithIdentifier:@"privacyNav"];
                
                [self presentViewController:_privacy animated:YES completion:nil];
                
            }else if (indexPath.row == 1){
                //评价
                NSString *urlStr = [NSString stringWithFormat:
                                    @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=912169073"];
                NSURL *url =[NSURL URLWithString:urlStr];
                [[UIApplication sharedApplication] openURL:url];
            }
            
        }
            break;
            
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, ScreenWidth-30, 40)];
    [logoutBtn setTintColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = FONT_18;
    logoutBtn.backgroundColor = kBlueColor;
    logoutBtn.clipsToBounds = YES;
    logoutBtn.layer.cornerRadius = 5.0;
    [logoutBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:logoutBtn];
    return footerView;
}

- (void)logoutAction{
    
            _logoutAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定退出登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [_logoutAlertView show];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _logoutAlertView && buttonIndex == 1)
    {

        [[NSUserDefaults standardUserDefaults ] setObject:@(0) forKey:kHadLogin];
        [[NSUserDefaults standardUserDefaults ] setBool:NO forKey:kEasyMobHadLogin];
        
        [[NSUserDefaults standardUserDefaults ] synchronize];

        UINavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];

        [self presentViewController:loginNav animated:YES completion:nil];


    }
    
    
    if (alertView.tag == 999 && buttonIndex == 1) {
        
        [[SDImageCache sharedImageCache] cleanDiskWithCompletionBlock:^{
            
            [MyProgressHUD showError:@"清除成功"];
            
        }];
        
    }
}
@end
