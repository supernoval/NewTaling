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

@interface MineTableViewController ()<UIAlertViewDelegate>
{
    
    
    NSArray *titlesArray;
    
    UIAlertView *_logoutAlertView;
    
    
    
    
}
@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    
    titlesArray = @[@"我的简历",@"个人信息",@"资质认证",@"我的钱包",@"充  值",@"提  现"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return titlesArray.count;
    }
    
    return 1;
    
   
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        
        UITableViewCell *mineCell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
        
        mineCell.textLabel.text = [titlesArray objectAtIndex:indexPath.row];
        
        mineCell.textLabel.font = FONT_15;
        
        mineCell.textLabel.textAlignment = NSTextAlignmentLeft;
        mineCell.textLabel.textColor = kDarkTintColor;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UILabel *contentLabel = (UILabel*)[mineCell viewWithTag:100];
            NSString *content = nil;
            
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    
                    
                }
                    break;
                case 2:
                {
                    content = @"未认证";
                    
                }
                    break;
                case 3:
                {
                    content = @"余额:100.0元";
                }
                    break;
                case 4:
                {
                    
                }
                    break;
                    
                    
                    
                default:
                    break;
            }
            
            contentLabel.text = content;
            
        });
        return mineCell;
        
    }
    else
    {
        UITableViewCell *logoutCell = [tableView dequeueReusableCellWithIdentifier:@"logoutCell"];
        
        if (logoutCell == nil) {
            
            logoutCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logoutCell"];
            
            logoutCell.textLabel.text = @"退出登录";
            
            logoutCell.textLabel.font = FONT_18;
            
            logoutCell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            
        }
        
        return logoutCell;
        
    }
   
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        
    
    switch (indexPath.row) {
        case 0:
        {
          
            
            
        }
            break;
        case 1:
        {
            PersonalInfoTableView *personInfoTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalInfoTableView"];
            
            personInfoTVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:personInfoTVC animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
            
            
        default:
            break;
    }
        
    }
    
    if (indexPath.section == 1) {
        
        _logoutAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定退出登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [_logoutAlertView show];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _logoutAlertView && buttonIndex == 1)
    {
        
        [[NSUserDefaults standardUserDefaults ] setObject:@(0) forKey:kHadLogin];
        [[NSUserDefaults standardUserDefaults ] synchronize];
        
        UINavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        
        [self presentViewController:loginNav animated:YES completion:nil];
        
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
