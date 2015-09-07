//
//  PersonalInfoTableView.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/27.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "PersonalInfoTableView.h"
#import "PickAddressViewController.h"
#import "ChangeNickNameVC.h"

@interface PersonalInfoTableView ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@end

@implementation PersonalInfoTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人信息";
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _nickName.text = [[NSUserDefaults standardUserDefaults] objectForKey:knickname];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
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
                ChangeNickNameVC *changeNickName = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeNickNameVC"];
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
              
                

            }
                break;
            case 3:
            {
                
            }
                break;
                
            default:
                break;
        }
        
        
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
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
