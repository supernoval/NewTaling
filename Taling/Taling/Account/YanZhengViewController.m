//
//  YanZhengViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "YanZhengViewController.h"
#import "CompanyInfoTableView.h"
#import "CompanyDoneVC.h"

@interface YanZhengViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    BOOL isEmailCheck;
    
}
@end

@implementation YanZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title = @"验证";
    
    _deleteButton.hidden = YES;
    
    _sendCodeButton.clipsToBounds =YES;
    
    _sendCodeButton.layer.cornerRadius = 5;
    
    _doneButton.clipsToBounds = YES;
    
    _doneButton.layer.cornerRadius = 5;
    
    
    
    
    
}




- (IBAction)phoneAction:(id)sender {
    
    isEmailCheck = NO;
    
    
    [_phoneCheckButton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
    
    [_emailcheckbutton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    _phoneNunTF.text = nil;
    
    _phoneNunTF.placeholder = @"手机号";
    
    _secondView.hidden = NO;
    
    _sendCodeButton.hidden = NO;
    
    
    
    _phoneNunTF.userInteractionEnabled = YES;
    
}
- (IBAction)emailAction:(id)sender {
    
    isEmailCheck = YES;
    
    [_phoneCheckButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    
    [_emailcheckbutton setTitleColor:kOrangeTextColor forState:UIControlStateNormal];

    
    _phoneNunTF.placeholder  = @"邮箱";
    
    _secondView.hidden = YES;
    
    _sendCodeButton.hidden = YES;
    
    
    _phoneNunTF.text = _email;
    
    _phoneNunTF.userInteractionEnabled = NO;
    
    
    
    
}
- (IBAction)sendCodeAction:(id)sender {
    
    
    if ([CommonMethods checkTel:_phoneNunTF.text])
    {
        
        
        
        _sendCodeButton.enabled = NO;
        
        [self getAutoCodeTime];
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNunTF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                
                NSLog(@"sendsms!");
                
                
            }
            else
            {
                NSLog(@"error:%@",error);
                
            }
        }];
        
        
        
        
    }
    else
    {
        [MyProgressHUD showError:@"手机号码不正确"];
        
    }
    
    
    
    
}
- (IBAction)deleteAction:(id)sender {
    
    
    
    _cartimageView.image = nil;
    
    
    
    
}
- (IBAction)addPhoto:(id)sender {
    
    
    UIActionSheet *_pickActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    _pickActionSheet.delegate = self;
    
    [_pickActionSheet addButtonWithTitle:@"相册"];
    [_pickActionSheet addButtonWithTitle:@"照相"];
    
    [_pickActionSheet addButtonWithTitle:@"取消"];
    
    _pickActionSheet.cancelButtonIndex = 2;
    
    _pickActionSheet.tag = 99;
    
    [_pickActionSheet showInView:self.view];
    
    
    
}
- (IBAction)doneAction:(id)sender {
    
    

    

    
    
    if (isEmailCheck) {
    
        
        [self bindEmail];
        
      
        
        
    }
    else
    {
        
        if (_codeTF.text.length == 0) {
            
            
            [CommonMethods showDefaultErrorString:@"请填写验证码"];
            
            return;
            
            
        }
        
        if (_cartimageView.image == nil) {
            
            [CommonMethods showDefaultErrorString:@"请上传工作证照片"];
            
            return;
        }
        
        
        
        [self checkSMSCode:_codeTF.text];
        
    }
    
    
    
}


#pragma mark - 倒计时
-(void)getAutoCodeTime{
    __block int timeout=30;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal] ;
                _sendCodeButton.enabled = YES;
                _sendCodeButton.hidden = NO;
                
                _coundownLabel.text = nil;
                
                _coundownLabel.hidden = YES;
                
                
                
            });
        }else{
            int seconds = timeout % 31;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //                NSLog(@"____%@",strTime);
                
                
                _sendCodeButton.alpha = 0;
                
                _sendCodeButton.hidden = YES;
                
                _coundownLabel.hidden = NO;
                _coundownLabel.text = [NSString stringWithFormat:@"%@s",strTime];
                
                
//                [_sendCodeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal] ;
                
                
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark -  校验验证码
-(void)checkSMSCode:(NSString *)SMSCode
{
    
    [MyProgressHUD showProgress];
    
    [SMSSDK commitVerificationCode:SMSCode phoneNumber:_phoneNunTF.text zone:@"86" result:^(NSError *error) {
        
        
        if (!error)
        {
            
            
            [self uploadpicture];
            
        }
        else
        {
            [MyProgressHUD dismiss];
            
            [CommonMethods showDefaultErrorString:@"验证码不正确"];
            
            
        }
    }];
    
    
    
}


#pragma  mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 99) {
        
        switch (buttonIndex) {
            case 0:
            {
                UIImagePickerController *_picker = [[UIImagePickerController alloc]init];
                _picker.editing = NO;
                _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                _picker.delegate = self;
                
                [self presentViewController:_picker animated:YES completion:nil];
                
            }
                break;
            case 1:
            {
                UIImagePickerController *_picker = [[UIImagePickerController alloc]init];
                _picker.editing = NO;
                _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                _picker.delegate = self;
                
                [self presentViewController:_picker animated:YES completion:nil];
            }
                break;
                
                
            default:
                break;
        }
    }
    
    
    
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *editImage          = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    UIImage *cutImage           = [self cutImage:editImage size:CGSizeMake(160, 160)];
    UIImage *cutImage  = [CommonMethods  imageWithImage:editImage scaledToSize:CGSizeMake(300, 300)];
    
    _cartimageView.image = cutImage;

    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)uploadpicture
{
//    //修改头像
//    /*
//     user_id
//     pic_file       头像
//     calling_card   名片
//     */
//#define kuploadPic    @"/uploadPic"
    
    
    
    NSString *user_id = [UserInfo getuserid];
    
    
    NSData *calling_card = UIImagePNGRepresentation(_cartimageView.image);
    
    
    [[TLRequest shareRequest] requestWithAction:kuploadPic params:@{@"user_id":user_id} data:calling_card fileName:@"calling_card" minetype:@"png" result:^(BOOL isSuccess, id data) {
      
        if (isSuccess) {
            
            NSLog(@"名片上传成功");
            
            
                CompanyInfoTableView *_infoTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanyInfoTableView"];
                 _infoTVC.accountName = _email;
            
                [self.navigationController pushViewController:_infoTVC animated:YES];
            
        }
        else
        {
            
            NSLog(@"名片上传失败");
            
        }
    }];
    
}

-(void)bindEmail
{
    
    NSString *user_id = [UserInfo getuserid];
    
    
    NSDictionary *param = @{@"user_id":user_id,@"email":_email};
    
    
    [[TLRequest shareRequest] tlRequestWithAction:kBindingEmail Params:param result:^(BOOL isSuccess, id data) {
       
        
        if (isSuccess) {
            
            
            [CommonMethods showDefaultErrorString:@"已发送验证邮件到您的邮箱，请点击里面的链接激活账号"];
            
            [self uploadpicture];
            
        }
        else
        {
             [CommonMethods showDefaultErrorString:@"发送验证链接失败，请重试"];
        }
        
    }];
    
}
@end
