//
//  CompanyInfoTableView.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CompanyInfoTableView.h"
#import "CompanyDoneVC.h"
#import "ChangePerInfoVC.h"

@interface CompanyInfoTableView ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSInteger selectedIndex;
    
}

@end

@implementation CompanyInfoTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isShow) {
        
         _nextButton.hidden = YES;
    }
    else
    {
       
        _nextButton.clipsToBounds = YES;
        
        _nextButton.layer.cornerRadius = 5;
    }
    self.title = @"企业信息";
    

    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedIndex = indexPath.row;
    
    switch (indexPath.row) {
        case 0:  //头像
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
        case 1: // 企业简称
        {
            ChangePerInfoVC *_changeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePerInfoVC"];
            
            _changeVC.block = ^(NSString *string)
            {
                _nameLabel.text = string;
            };
            
            
            _changeVC.title = @"企业简称";
            
            _changeVC.placeHolder = @"请填写企业简称";
            
            [self.navigationController pushViewController:_changeVC animated:YES];
        }
            break;
        case 2:  //企业描述
        {
            ChangePerInfoVC *_changeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePerInfoVC"];
            
            _changeVC.block = ^(NSString *string)
            {
                _companDesLabel.text = string;
            };
            
            
            _changeVC.title = @"企业描述";
            
            _changeVC.placeHolder = @"请填写企业描述";
            
            [self.navigationController pushViewController:_changeVC animated:YES];
            
            
        }
            break;
        case 3: //企业链接
        {
            ChangePerInfoVC *_changeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePerInfoVC"];
            
            _changeVC.block = ^(NSString *string)
            {
                _linkLabel.text = string;
            };
            
            
            _changeVC.title = @"企业链接";
            
            _changeVC.placeHolder = @"请填写企业链接";
            
            [self.navigationController pushViewController:_changeVC animated:YES];
        }
            break;
        case 4:  //营业执照
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
            
          case 5:  //税务登记号
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
        case 6: //组织结构代码
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
    
    
    

}




-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *editImage          = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    UIImage *cutImage           = [self cutImage:editImage size:CGSizeMake(160, 160)];
    UIImage *cutImage  = [CommonMethods  imageWithImage:editImage scaledToSize:CGSizeMake(300, 300)];
    
    if (selectedIndex == 0) {
        
        _headImageView.image = cutImage;
    }
    else if (selectedIndex == 4)
    {
        
        _zhizhaoImageView.image = cutImage;
        
        
    }
    else if (selectedIndex == 5)
    {
        _shuiwuImageView.image = cutImage;
        
    }
    else if (selectedIndex == 6)
    {
        _jigouImageView.image = cutImage;
        
    }
    

    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)nextAction:(id)sender {
   
    
    
    
    [self uploadInfo];
    
    
    
    
//    CompanyDoneVC *_companyDoneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanyDoneVC"];
//    
//    
//    [self.navigationController pushViewController:_companyDoneVC animated:YES];
}


#pragma mark - 上传信息
-(void)uploadInfo
{
//    
//    user_id
//    company_name
//    company_URL      企业链接
//    company_description  企业描述
//    company_code     税务登记号
//    company_number   组织机构代码
//    pic_license    //营业执照
//    pic_IDCARD1
//    pic_IDCARD2
    
    
    if (_nameLabel.text.length == 0 || _headImageView.image == nil || _companDesLabel.text.length == 0 || _linkLabel.text.length == 0 || _zhizhaoImageView.image == nil || _shuiwuImageView.image == nil || _jigouImageView.image == nil) {
        
        
        [CommonMethods showDefaultErrorString:@"请填写完整信息"];
        
        return;
    }
    
    NSString *user_id = [UserInfo getuserid];
    
    NSString *company_name = _nameLabel.text;
    
    NSString *company_URL = _linkLabel.text;
    
    NSString *company_description = _companDesLabel.text;
    
    NSData *pic_license = UIImagePNGRepresentation(_zhizhaoImageView.image);
    
    NSData *company_code = UIImagePNGRepresentation(_shuiwuImageView.image);
    
    NSData *company_number = UIImagePNGRepresentation(_jigouImageView.image);
    
    NSDictionary *params = @{@"user_id":user_id,@"company_name":company_name,@"company_URL":company_URL,@"company_description":company_description};
    
    NSDictionary *datas = @{@"pic_license":pic_license,@"company_code":company_code,@"company_number":company_number};
    
    
    
    [[TLRequest shareRequest] requestWithAction:kuploadCompanyInfo params:params datas:datas result:^(BOOL isSuccess, id data) {
       
        
        if (isSuccess) {
          
            NSLog(@"company info uploadSuccess");
            
            
            
        }
        
        
        
    }];
    
    
    
}
@end
