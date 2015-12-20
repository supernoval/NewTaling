//
//  MineTableViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "MineTableViewController.h"
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
#import "ShareH5.h"
#import "MyCouponTVC.h"


@interface MineTableViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
@property (strong, nonatomic)NSDictionary *countDic;
@property (strong, nonatomic)UIActionSheet *shareAC;

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0;
    
    NSString *photo = [[NSUserDefaults standardUserDefaults] objectForKey:@"photo"];
    if (photo.length > 0) {
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:photo]];
    }
    
    _nameLabel.text = [UserInfo getnickName];
    
    if ([UserInfo getIsCompany] == YES) {
        _idLabel.text = [NSString stringWithFormat:@"企业 ID%@",[UserInfo getuserid]];
    }else{
         _idLabel.text = [NSString stringWithFormat:@"人才官 ID%@",[UserInfo getuserid]];
    }
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
                
                _boughtLabel.text = [NSString stringWithFormat:@"%@份",[_countDic objectForKey:@"buyresumesCountSum"]];
                
                _sharedLabel.text = [NSString stringWithFormat:@"%@份",[_countDic objectForKey:@"resumesCountSum"]];
                
                _collectedLabel.text = [NSString stringWithFormat:@"%@份,",[_countDic objectForKey:@"saleresumesCountSum"]];
                
                
                [self.tableView reloadData];
            }
            
        }
        
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
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
            return 6;
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

    if (indexPath.section == 0) {
        
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
                MyCouponTVC *coupon = [self.storyboard instantiateViewControllerWithIdentifier:@"MyCouponTVC"];
                [self.navigationController pushViewController:coupon animated:YES];
                

            }
                break;
                
            case 5:
            {
                //分享
                _shareAC = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"分享到朋友圈",@"分享给微信好友", nil];
                [_shareAC addButtonWithTitle:@"取消"];
                _shareAC.cancelButtonIndex = 2;
                [_shareAC showInView:self.view];
                
                
                
                
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet == _shareAC) {
        if (buttonIndex == 0) {
            //分享到朋友圈
            [ShareH5 shareWechatPengYouQuan];
            
        }else if (buttonIndex == 1){
            //分享到微信好友
            [ShareH5 shareWechatHaoYou];
        }
    }
}

@end
