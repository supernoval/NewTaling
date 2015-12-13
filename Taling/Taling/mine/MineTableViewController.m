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
#import "BoughtResumeTVC.h"
#import "SharedResumeTVC.h"
#import "CollectedResumeTVC.h"

#import "PersonInfoTVC.h"
#import "CompanyInfoTableView.h"


@interface MineTableViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic)NSDictionary *countDic;

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0;
    _countDic = [[NSDictionary alloc]init];
    
    [self getResumeCount];
    
    
}

- (void)getResumeCount{
    
    NSDictionary *param = @{@"user_id":[UserInfo getuserid]};
    
    [[TLRequest shareRequest]tlRequestWithAction:kresumesCount Params:param result:^(BOOL isSuccess ,id data){
        
        if (isSuccess) {
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                _countDic = data;
//                _resumeNum.text = [NSString stringWithFormat:@"%@份",[_countDic objectForKey:@"resumesCountSum"]];
//                _resumeMoney.text = [NSString stringWithFormat:@"%@元",[_countDic objectForKey:@"resumesCountPrice"]];
                [self.tableView reloadData];
            }
            
        }
        
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*
//    [self  getResumeCount];
    
    NSString *nickName = [[NSUserDefaults standardUserDefaults ]objectForKey:knickname];
    
    if (nickName) {
        
        _nameLabel.text = nickName;
        
    }
    
//    _professionLabel.text = [[NSUserDefaults standardUserDefaults ] objectForKey:kindustry];
//    _companyLabel.text = [[NSUserDefaults standardUserDefaults ] objectForKey:kcompany];
    
    
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
    
//    if (bindEmail.length > 0) {
//        _bindEmail.text = bindEmail;
//    }else{
//        _bindEmail.text = @"未绑定";
//    }*/
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
            
        case 1:
        {
            return 5;
        }
            break;
            
        case 2:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
    
   
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
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin]) {
//        
//        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        return;
//        
//    }
    if (indexPath.section == 0) {
        
        
    
    
//            PersonalInfoTableView *personInfoTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalInfoTableView"];
//            
//            personInfoTVC.hidesBottomBarWhenPushed = YES;
//            
//            [self.navigationController pushViewController:personInfoTVC animated:YES];
        
        
        PersonInfoTVC *_personInfo = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonInfoTVC"];
        
        
        _personInfo.hidesBottomBarWhenPushed = YES;
        
        _personInfo.isShowed = YES;
        
        [self.navigationController pushViewController:_personInfo animated:YES];
        
        
      
        
    }else if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:
            {
                //购买的简历
                BoughtResumeTVC *bought = [self.storyboard instantiateViewControllerWithIdentifier:@"BoughtResumeTVC"];
                [self.navigationController pushViewController:bought animated:YES];
            }
                break;
                
            case 1:
            {
                //购买的简历
                SharedResumeTVC *bought = [self.storyboard instantiateViewControllerWithIdentifier:@"SharedResumeTVC"];
                [self.navigationController pushViewController:bought animated:YES];
                
            }
                break;
                
            case 2:
            {
                //收藏的简历
                CollectedResumeTVC *bought = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectedResumeTVC"];
                [self.navigationController pushViewController:bought animated:YES];
            }
                break;
                
            case 3:
            {
                //我的钱包
                WalletViewController *wallet = [self.storyboard instantiateViewControllerWithIdentifier:@"WalletViewController"];
                wallet.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:wallet animated:YES];
            }
                break;
                
                case 4:
            {
                //我的优惠券
                
                [[TLRequest shareRequest ] tlRequestWithAction:kGetMyCoupon Params:@{@"user_id":[UserInfo getuserid]} result:^(BOOL isSuccess, id data) {
                    
                    
                }];
//                WalletViewController *wallet = [self.storyboard instantiateViewControllerWithIdentifier:@"WalletViewController"];
//                wallet.hidesBottomBarWhenPushed = YES;
//                
//                [self.navigationController pushViewController:wallet animated:YES];
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
