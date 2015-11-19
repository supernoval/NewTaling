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
#import "BindEmailTVC.h"

@interface MineTableViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic)NSDictionary *countDic;

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
    _countDic = [[NSDictionary alloc]init];
    
//    [self getResumeCount];
    
    
}

- (void)getResumeCount{
    
    NSDictionary *param = @{@"user_id":[UserInfo getuserid]};
    
    [[TLRequest shareRequest]tlRequestWithAction:kresumesCount Params:param result:^(BOOL isSuccess ,id data){
        
        if (isSuccess) {
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                _countDic = data;
                _resumeNum.text = [NSString stringWithFormat:@"%@份",[_countDic objectForKey:@"resumesCountSum"]];
                _resumeMoney.text = [NSString stringWithFormat:@"%@元",[_countDic objectForKey:@"resumesCountPrice"]];
                [self.tableView reloadData];
            }
            
        }
        
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self  getResumeCount];
    
    NSString *nickName = [[NSUserDefaults standardUserDefaults ]objectForKey:knickname];
    
    if (nickName) {
        
        _nameLabel.text = nickName;
        
    }
    
    _professionLabel.text = [[NSUserDefaults standardUserDefaults ] objectForKey:kindustry];
    _companyLabel.text = [[NSUserDefaults standardUserDefaults ] objectForKey:kcompany];
    
    
    NSString *photoURL = [[NSUserDefaults standardUserDefaults ] objectForKey:kphoto];
    
    if (photoURL.length > 0) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:photoURL] placeholderImage:[UIImage imageNamed:@"test"]];
        
    }
    else
    {
        NSData *headImageData = [[NSUserDefaults standardUserDefaults] objectForKey:kLocatePhoto];
        
        if (headImageData) {
            
            _headImageView.image = [UIImage imageWithData:headImageData];
            
            
        }
    }
    
    NSString *bindEmail = [[NSUserDefaults standardUserDefaults]objectForKey:kemail];
    
    if (bindEmail.length > 0) {
        _bindEmail.text = bindEmail;
    }else{
        _bindEmail.text = @"未绑定";
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        
        return 2;
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
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin]) {
        
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        return;
        
    }
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
                resume.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:resume animated:YES];
            }
                break;
                
                case 1:
            {
                //钱包
                WalletViewController *wallet = [self.storyboard instantiateViewControllerWithIdentifier:@"WalletViewController"];
                wallet.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:wallet animated:YES];
            }
                break;
                
                
                
            default:
                break;
        }
        

        
    }else if (indexPath.section == 2){
        
        switch (indexPath.row) {
            case 0:
            {
//                //绑定账号
//                BindAccountTVC *bindAccount = [self.storyboard instantiateViewControllerWithIdentifier:@"BindAccountTVC"];
//                bindAccount.hidesBottomBarWhenPushed = YES;
//                
//                [self.navigationController pushViewController:bindAccount animated:YES];
                
                [[TLRequest shareRequest ] tlRequestWithAction:kGetMyCoupon Params:@{@"user_id":[UserInfo getuserid]} result:^(BOOL isSuccess, id data) {
                   
                    
                }];
                
                

            }
                break;
                
                case 1:
            {
                //绑定邮箱
                
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:kis_active]boolValue] == YES) {
                    
                    
                }else{
                    BindEmailTVC *bindEmail = [self.storyboard instantiateViewControllerWithIdentifier:@"BindEmailTVC"];
                    [self.navigationController pushViewController:bindEmail animated:YES];
                
                }
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 3){
        
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
