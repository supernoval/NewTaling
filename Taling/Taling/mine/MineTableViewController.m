//
//  MineTableViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "MineTableViewController.h"
#import "PersonalInfoTableView.h"
#import "NSUserDefaultKeys.h"
#import "LoginViewController.h"
#import "WalletViewController.h"
#import "BindAccountTVC.h"
#import "SettingTVC.h"
#import "MyResumeTVC.h"

@interface MineTableViewController ()<UIAlertViewDelegate>

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0;
    _numberWidth.constant = (ScreenWidth-25)/2;
    _moneyWidth.constant = (ScreenWidth-25)/2;
    _numberTextWidth.constant = (ScreenWidth-25)/2;
    _moneyTextWidth.constant = (ScreenWidth-25)/2;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        
        return 3;
    }
    
    return 1;
    
   
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        
    
    
            PersonalInfoTableView *personInfoTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalInfoTableView"];
            
            personInfoTVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:personInfoTVC animated:YES];
      
        
    }else if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:
            {
                //简历
                MyResumeTVC *resume = [self.storyboard instantiateViewControllerWithIdentifier:@"MyResumeTVC"];
                [self.navigationController pushViewController:resume animated:YES];
            }
                break;
                
                case 1:
            {
                //钱包
                WalletViewController *wallet = [self.storyboard instantiateViewControllerWithIdentifier:@"WalletViewController"];
                [self.navigationController pushViewController:wallet animated:YES];
            }
                break;
                
                
            case 2:
            {
                BindAccountTVC *bindAccount = [self.storyboard instantiateViewControllerWithIdentifier:@"BindAccountTVC"];
                [self.navigationController pushViewController:bindAccount animated:YES];
            }
                break;
                
            default:
                break;
        }
        

        
    }else if (indexPath.section == 2){
        
        SettingTVC *setting = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingTVC"];
        [self.navigationController pushViewController:setting animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
