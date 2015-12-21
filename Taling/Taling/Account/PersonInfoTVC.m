//
//  PersonInfoTVC.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "PersonInfoTVC.h"
#import "ChangePerInfoVC.h"
#import "PickInfoTVC.h"
#import "DonePeronRegist.h"


@interface PersonInfoTVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSInteger selectedIndex;
    
    
}

@end

@implementation PersonInfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (_isShowed) {
        
        self.title = @"个人信息";
        
        _footerView.hidden = YES;
        
        [self showInfo];
        
        
    }
    else
    {
       self.title = @"填写个人信息";
        
        _footerView.frame = CGRectMake(0, 0, ScreenWidth, 140);
        
        _doneButton.clipsToBounds = YES;
        
        _doneButton.layer.cornerRadius = 5;
        
    }
    
   

    
    
}

-(void)showInfo
{
    _nickNameLabel.text =[UserInfo getnickName];
    
    _hangyeLabel.text = [UserInfo getindustry];
    
    _qiyeLabel.text = [UserInfo getcompany];
    
    _gangweiLabel.text = [UserInfo getspecaility];
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[UserInfo getphoto]]];
    
    _cityLabel.text = [UserInfo  getcity];
    
    NSInteger sex = [[UserInfo getsex]integerValue];
    
    if (sex == 1) {
        
        _sexLabel.text = @"男";
    }
    else
    {
        _sexLabel.text = @"女";
        
    }
    
    
    
    
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedIndex = indexPath.row;
    
    switch (indexPath.row) {
        case 0: // 头像
        {
            UIActionSheet *_pickActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            _pickActionSheet.delegate = self;
            
            [_pickActionSheet addButtonWithTitle:@"相册"];
            [_pickActionSheet addButtonWithTitle:@"照相"];
            
            [_pickActionSheet addButtonWithTitle:@"取消"];
            
            _pickActionSheet.cancelButtonIndex = 2;
            
            _pickActionSheet.tag = 99;
            
            [_pickActionSheet showInView:self.view];
        }
            break;
        case 1://昵称
        {
            ChangePerInfoVC *_changeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePerInfoVC"];
            
            _changeVC.block = ^(NSString *string)
            {
                _nickNameLabel.text = string;
                
                if (_isShowed) {
                    
                    [UserInfo saveInfo:string key:knickname];
                    
                    [self saveInfo];
                    
                }
            };
            
            
            _changeVC.title = @"昵称";
            
            _changeVC.placeHolder = @"填写昵称";
            
            [self.navigationController pushViewController:_changeVC animated:YES];
            
            
            
            
        }
            break;
        case 2: // 性别
        {
            UIActionSheet *_actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            
            [_actionSheet addButtonWithTitle:@"男"];
            
            [_actionSheet addButtonWithTitle:@"女"];
            
            
            [_actionSheet addButtonWithTitle:@"取消"];
            
            _actionSheet.tag = 200;
            
            _actionSheet.cancelButtonIndex = 2;
            
            [_actionSheet showInView:self.view];
            
            
            
        }
            break;
        case 3:
        {
            PickInfoTVC *_pickInfo = [[PickInfoTVC alloc]initWithStyle:UITableViewStylePlain];
            
            _pickInfo.title = @"城市选择";
            _pickInfo.type =1;
            _pickInfo.beforeString = _cityLabel.text;
            _pickInfo.block = ^(NSString*string)
            {
                
                _cityLabel.text = string;
                
                
                [UserInfo saveUserInfo:string key:kcity];
                
                [self saveInfo];
                
                
                
                
            };
            
            [self.navigationController pushViewController:_pickInfo animated:YES];
            
        }
            break;
        case 4:
        {
            PickInfoTVC *_pickInfo = [[PickInfoTVC alloc]initWithStyle:UITableViewStylePlain];
            
            _pickInfo.title = @"所在行业";
            
            _pickInfo.beforeString = _hangyeLabel.text;
            _pickInfo.type =2;
            
            _pickInfo.block = ^(NSString*string)
            {
                
                _hangyeLabel.text = string;
                
                if (_isShowed) {
                    
                     [UserInfo saveInfo:string key:kindustry];
                    
                    [self saveInfo];
                    
                }
                
                
            };
            
            [self.navigationController pushViewController:_pickInfo animated:YES];
        }
            break;
        case 5:
        {
            ChangePerInfoVC *_changeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePerInfoVC"];
            
            _changeVC.block = ^(NSString *string)
            {
                _qiyeLabel.text = string;
                
                if (_isShowed) {
                    
                     [UserInfo saveInfo:string key:kcompany];
                    [self saveInfo];
                    
                }
            };
            
            
            _changeVC.title = @"服务过的企业";
            
            _changeVC.placeHolder = @"企业名称";
            
            [self.navigationController pushViewController:_changeVC animated:YES];
            
            
            
        }
            break;
        case 6:
        {
            PickInfoTVC *_pickInfo = [[PickInfoTVC alloc]initWithStyle:UITableViewStylePlain];
            
            _pickInfo.title = @"擅长招聘岗位";
            _pickInfo.type =3;
            _pickInfo.beforeString = _gangweiLabel.text;
            
            _pickInfo.block = ^(NSString*string)
            {
              
                _gangweiLabel.text = string;
                
                if (_isShowed) {
                    
                     [UserInfo saveInfo:string key:kspeciality];
                    [self saveInfo];
                    
                }
                
            };
            [self.navigationController pushViewController:_pickInfo animated:YES];
        }
            break;
        case 7:
        {
            UIActionSheet *_pickActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            _pickActionSheet.delegate = self;
            
            [_pickActionSheet addButtonWithTitle:@"相册"];
            [_pickActionSheet addButtonWithTitle:@"照相"];
            
            [_pickActionSheet addButtonWithTitle:@"取消"];
            
            _pickActionSheet.cancelButtonIndex = 2;
            
            _pickActionSheet.tag = 99;
            
            [_pickActionSheet showInView:self.view];
            
        }
            break;
     
            
            
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
    
    
    
    if (actionSheet.tag == 200) {
        
        if (buttonIndex == 0) {
            
            _sexLabel.text = @"男";
            [self saveInfo];
            
            [UserInfo saveUserInfo:@(1) key:ksex];
            
            
        }
        else
        {
            _sexLabel.text = @"女";
            
            [self saveInfo];
            
            [UserInfo saveUserInfo:@(0) key:ksex];
        }
    }
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *editImage          = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    UIImage *cutImage           = [self cutImage:editImage size:CGSizeMake(160, 160)];
    UIImage *cutImage  = [CommonMethods  imageWithImage:editImage scaledToSize:CGSizeMake(300, 300)];
    
    if (selectedIndex == 0) {
        
       _headImageView.image = cutImage;
        
        NSData *headImageData = UIImagePNGRepresentation(cutImage);
        
        if (headImageData) {
            
//            [UserInfo saveUserInfo:<#(id)#> key:<#(NSString *)#>]
        }
        
        
    }
    else if (selectedIndex == 7)
    {
        _personCardImageView.image = cutImage;
        
        
    }
   
    
    if (_isShowed) {
        
        [self uploadHeadImage];
        
    }
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}





- (IBAction)doneAction:(id)sender {
    
    
    if (!_headImageView.image || _nickNameLabel.text.length == 0 || _sexLabel.text == 0 || _cityLabel.text.length == 0 || _hangyeLabel.text.length == 0 || _qiyeLabel.text.length == 0 || _gangweiLabel.text.length == 0 || !_personCardImageView.image ) {
        
        
        [CommonMethods showDefaultErrorString:@"请完善个人信息"];
        
        
        return;
        
        
    }
    
    [self uploadHeadImage];
    
    
//#warning  test
//    DonePeronRegist *_doneRegist = [self.storyboard instantiateViewControllerWithIdentifier:@"DonePeronRegist"];
//    
//    [self.navigationController pushViewController:_doneRegist animated:YES];
    
    
    
    
    
    
    
}

-(void)uploadHeadImage
{
    
    
    NSString *user_id = [UserInfo getuserid];
    
    NSData *imageData = UIImagePNGRepresentation(_headImageView.image);
    
    NSDictionary *param = @{@"user_id":user_id};
    
    NSData *cartData = UIImagePNGRepresentation(_personCardImageView.image);
    
    NSDictionary *dataDic ;
    
    //如果是显示
    if (_isShowed) {
        
        if (selectedIndex == 0) {
            
            dataDic = @{@"pic_file":imageData};
        }
        
        if (selectedIndex == 7) {
            
            dataDic = @{@"calling_card":cartData};
        }
        
    }
    else
    {
       dataDic = @{@"pic_file":imageData,@"calling_card":cartData};
    }
     [[TLRequest shareRequest] requestWithAction:kuploadPic params:param datas:dataDic result:^(BOOL isSuccess, id data) {
    
         if (isSuccess) {
             
             if (!_isShowed) {
                 
                 [self saveInfo];
             }
             
             
         }
         else
         {
             [CommonMethods showDefaultErrorString:@"保存失败，请重试"];
             
         }
     }];
    
}

-(void)saveInfo
{
//    *user_id     用户id
//    *work_year   工作年限
//    *nickname    昵称
//    *industry    行业
//    *summary     自我描述  标签
//    *company     所在公司
//    *photo       图片在appendData 里加
//    *speciality   擅长
//    *sex         性别
//    *city       城市
//    *callingCard   名片
    
    
    NSString *user_id = [UserInfo getuserid];
    
    NSString *sex = nil;
    
    if ([_sexLabel.text isEqualToString:@"男"]) {
    
        sex = @"1";
    }
    else
    {
        sex = @"0";
        
    }
    
    NSDictionary *param = @{@"user_id":user_id,@"work_year":@"",@"nickname":_nickNameLabel.text,@"industry":_hangyeLabel.text,@"company":_qiyeLabel.text,@"speciality":_gangweiLabel.text,@"sex":sex,@"city":_cityLabel.text};
    
    if (_isShowed) {
        
        switch (selectedIndex) {
            case 1:
            {
                param = @{@"user_id":user_id,@"work_year":@"",@"nickname":_nickNameLabel.text,@"industry":@"",@"company":@"",@"speciality":@"",@"sex":@"",@"city":@""};
            }
                break;
            case 2://性别
            {
                 param = @{@"user_id":user_id,@"work_year":@"",@"nickname":@"",@"industry":@"",@"company":@"",@"speciality":@"",@"sex":sex,@"city":@""};
            }
                break;
            case 3:  //城市
            {
                param = @{@"user_id":user_id,@"work_year":@"",@"nickname":@"",@"industry":@"",@"company":@"",@"speciality":@"",@"sex":@"",@"city":_cityLabel.text};
               
            }
                break;
            case 4:  //所在行业
            {
                param = @{@"user_id":user_id,@"work_year":@"",@"nickname":@"",@"industry":_hangyeLabel.text,@"company":@"",@"speciality":@""};
            }
                break;
            case 5: //服务过的企业
            {
                param = @{@"user_id":user_id,@"work_year":@"",@"nickname":@"",@"industry":@"",@"company":_qiyeLabel.text,@"speciality":@""};
            }
                break;
            case 6://擅长岗位
            {
                param = @{@"user_id":user_id,@"work_year":@"",@"nickname":@"",@"industry":@"",@"company":@"",@"speciality":_gangweiLabel.text};
            }
                break;
            
                
            default:
                break;
        }
    }
    
    [[TLRequest shareRequest] tlRequestWithAction:kupdateUser Params:param result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
           
            if (!_isShowed) {
                
                DonePeronRegist *_doneRegist = [self.storyboard instantiateViewControllerWithIdentifier:@"DonePeronRegist"];
                
                [self.navigationController pushViewController:_doneRegist animated:YES];
                
            }
     
            
            
            
        }
        else
        {
             [CommonMethods showDefaultErrorString:@"保存失败，请重试"];
        }
        
    }];
    
}
@end
