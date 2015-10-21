//
//  PersonalInfoTableView.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "PersonalInfoTableView.h"
#import "PickAddressViewController.h"
#import "ChangeNameTVC.h"
#import "ChangeCompanyTVC.h"
#import "ChangeProgessionTVC.h"

@interface PersonalInfoTableView ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@end

@implementation PersonalInfoTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5.0;
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    _nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:knickname];
    _companyLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kcompany];
    _professionLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kindustry];
    
    NSData *headImageData = [[NSUserDefaults standardUserDefaults] objectForKey:kLocatePhoto];
    
    if (headImageData) {
        
        _headImageView.image = [UIImage imageWithData:headImageData];
        
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      switch (indexPath.row){
            case 0:// 修改头像
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
            case 1:
            {
                ChangeNameTVC *changeNickName = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeNameTVC"];
//                [changeNickName setblock:^(NSString *nick) {
//                   
//                    if (nick.length > 0) {
//                        
//                        _nickName.text = nick;
//                        
//                    }
//                    
//                }];
                [self.navigationController pushViewController:changeNickName animated:YES];
                
            }
                break;
            case 2:
            {
//                PickAddressViewController *_pickAddress = [[PickAddressViewController alloc]init];
//                [self.navigationController pushViewController:_pickAddress animated:YES];
              
                ChangeCompanyTVC *company = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeCompanyTVC"];
                [self.navigationController pushViewController:company animated:YES];

            }
                break;
            case 3:
            {
                ChangeProgessionTVC *pro = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeProgessionTVC"];
                [self.navigationController pushViewController:pro animated:YES];
                
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
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *editImage          = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    UIImage *cutImage           = [self cutImage:editImage size:CGSizeMake(160, 160)];
    UIImage *cutImage  = [CommonMethods  imageWithImage:editImage scaledToSize:CGSizeMake(300, 300)];
    
    _headImageView.image = cutImage;
    
    NSData *imageData = UIImagePNGRepresentation(cutImage);
    
    
    [self upLoadImageWithImage:cutImage];
    
    
    [[NSUserDefaults standardUserDefaults ] setObject:imageData forKey:kLocatePhoto];
    [[NSUserDefaults standardUserDefaults ] synchronize];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



-(void)upLoadImageWithImage:(UIImage*)image
{
    NSString *user_id = [UserInfo getuserid];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSDictionary *param = @{@"user_id":user_id};
    
    [[TLRequest shareRequest] requestWithAction:kuploadPic params:param data:imageData fileName:@"pic_file" minetype:@"png" result:^(BOOL isSuccess, id data) {
       
        if (isSuccess)
        {
            
            
        }
        else
        {
            
        }
        
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
