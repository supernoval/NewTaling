//
//  ContactTVC.m
//  Taling
//
//  Created by Leo on 15/12/19.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ContactTVC.h"
#import <AddressBook/AddressBook.h>
#import <ContactsUI/ContactsUI.h>
#import <MessageUI/MessageUI.h>
#import "RecommendCell.h"
#import "UserInfo.h"

@interface ContactTVC ()<UITextFieldDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong)NSString *infoStr;

@end

@implementation ContactTVC
@synthesize oneItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系";
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, ScreenWidth, 150);
    _positionTF.delegate = self;
    
    NSString *companyName =nil;
    if ([UserInfo getIsCompany]) {
        
        companyName = [UserInfo getCompanyName];
        
    }
    else
    {
        NSString *temcompany  =  [UserInfo getcompany];
        
        if (temcompany.length > 0) {
            
            NSArray *companys = [temcompany componentsSeparatedByString:@"|"];
            
            if (companys.count > 1) {
                
                companyName = [companys objectAtIndex:1];
                
            }
            else
            {
                companyName = @"";
            }
        }
        else
        {
            companyName = @"";
            
        }
        
    }
    _titleStr = [NSString stringWithFormat:@"%@，您好！%@的人才官正在网络上浏览您的简历信息，如您同意考虑其提供的工作机会，请回复1确认。如您电话号码有变更，请回复新号码。谢谢！",oneItem.name,companyName];
//    _infoStr = @"招聘职位正在公开招聘，欢迎联系，谢谢！";
    _titleLabel.text = _titleStr;
    _infoLabel.text = _infoStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"RecommendCell";
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RecommendCell" owner:self options:nil][0];
    }
    
    cell.priceLabel.hidden = YES;
    
    
        
        //头像
    NSString *photo = [[NSUserDefaults standardUserDefaults] objectForKey:@"photo"];
        if (photo.length > 0) {
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:kDefaultHeadImage];
        }
    else
    {
        cell.headImageView.image = kDefaultHeadImage;
        
    }
    
        
        //我
        cell.idLabel.text = [UserInfo getnickName];
        
        
        //ID
    if ([UserInfo getIsCompany] == YES) {
        cell.companyLabel.text = [NSString stringWithFormat:@"企业 ID%@",[UserInfo getuserid]];
    }else{
        cell.companyLabel.text = [NSString stringWithFormat:@"人才官 ID%@",[UserInfo getuserid]];
    }
    
        
        //所在企业
     NSString *companyName =nil;
    
    if ([UserInfo getIsCompany]) {
        
        companyName = [UserInfo getCompanyName];
        
    }
    else
    {
        NSString *temcompany  =  [UserInfo getcompany];
        
        if (temcompany.length > 0) {
            
            NSArray *companys = [temcompany componentsSeparatedByString:@"|"];
            
            if (companys.count > 1) {
                
                companyName = [companys objectAtIndex:0];
                
            }
            else
            {
                companyName = temcompany;
            }
        }
        else
        {
            companyName = @"";
            
        }
        
    }
        cell.placeLabel.text = companyName;
        
        
        
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark - 发送短信
- (void)sendSMSMessageWithPhoneNum:(NSString*)phone content:(NSString*)content{
    
    MFMessageComposeViewController *_messageVC = [[MFMessageComposeViewController alloc]init];
    
    _messageVC.recipients = @[phone];
    
    _messageVC.body = content;
    _messageVC.messageComposeDelegate = self;
    
    [self presentViewController:_messageVC animated:YES completion:nil];
    
    
    
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendAction:(id)sender {

    
        NSString *content = [NSString stringWithFormat:@"%@",_titleStr];
    
        NSString *phone = oneItem.phone;
        
        [self sendSMSMessageWithPhoneNum:phone content:content];
        
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
    [controller dismissViewControllerAnimated:YES completion:^{
    
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }];
    
}
@end
