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
        
        [self showInfo];
        
    }
    else
    {
       
        _nextButton.clipsToBounds = YES;
        
        _nextButton.layer.cornerRadius = 5;
    }
    self.title = @"企业信息";
    

    
    
}

-(void)showInfo
{
    UserModel *model = [UserInfo getUserInfoModel];
    
    
    _nameLabel.text = model.companyName;
    _companDesLabel.text = model.companyDescription;
    if (model.companyURL) {
        
        [_companyLink setTitle:model.companyURL forState:UIControlStateNormal];
        
    }
    
    
    
    SDPhotoItem * logoItem = [[SDPhotoItem alloc]init];
    logoItem.imageData = model.photo_data;
    logoItem.thumbnail_pic = model.photo;
    
    _logoImageView.photoItemArray = @[logoItem];
    
    
    SDPhotoItem *zhizhaoItem = [[SDPhotoItem alloc]init];
    
    zhizhaoItem.imageData = model.pic_license_data;
    
    zhizhaoItem.thumbnail_pic = model.companyLicense;
    
    
    _zhizhaoView.photoItemArray = @[zhizhaoItem];
    
    
    
    SDPhotoItem *shuiwuItem = [[SDPhotoItem alloc]init];
    
    shuiwuItem.imageData = model.company_number_data;
    
    shuiwuItem.thumbnail_pic = model.companyNum;
    
    _shuiwuView.photoItemArray = @[shuiwuItem];
    
    
    
    SDPhotoItem *jigouItem = [[SDPhotoItem alloc]init];
    
    jigouItem.imageData = model.company_code_data;
    
    jigouItem.thumbnail_pic = model.companyCode;
    
    _jigouView.photoItemArray = @[jigouItem];

    
    

   
    
   
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     UserModel *model = [UserInfo getUserInfoModel];
    
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
                
                
                if (_isShow) {
                    
                    [self updateCompanyInfoWithValue:string key:@"company_name" type:NO];
                    
                    [UserInfo saveModeValue:string key:@"companyName"];
                    
                    
                }
                
                
            };
            
           
            
            NSString *companyname = model.companyName;
            
            if (_isShow && companyname)
            {
                
                     _changeVC.placeHolder = companyname;
            }
            else
            {
              
                     _changeVC.placeHolder = @"请填写企业简称";
                
            }
            
            _changeVC.title = @"企业简称";
            
       
            [self.navigationController pushViewController:_changeVC animated:YES];
            
            
            
        }
            break;
        case 2:  //企业全称
        {
            ChangePerInfoVC *_changeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePerInfoVC"];
            
            _changeVC.block = ^(NSString *string)
            {
                _companDesLabel.text = string;
                
                if (_isShow) {
                    
                    [self updateCompanyInfoWithValue:string key:@"company_description" type:NO];
                    
                    
                    
                    
                     [UserInfo saveModeValue:string key:@"companyDescription"];
                    
                }
                
            };
            
            if (_isShow && model.companyDescription) {
                
                _changeVC.placeHolder = model.companyDescription;
                
            }
            else
            {
               _changeVC.placeHolder = @"请填写企业全称";
                
                
            }
            _changeVC.title = @"企业全称";
            
            
            
            [self.navigationController pushViewController:_changeVC animated:YES];
            
            
        }
            break;
        case 3: //企业链接
        {
            ChangePerInfoVC *_changeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePerInfoVC"];
            
            _changeVC.block = ^(NSString *string)
            {
               
                
                [_companyLink setTitle:string forState:UIControlStateNormal];
                
                if (_isShow) {
                    
                    [self updateCompanyInfoWithValue:string key:@"company_URL" type:NO];
                    
                     [UserInfo saveModeValue:string key:@"companyURL"];
                    
                }
                
                
            };
            
            if (_isShow && model.companyURL) {
                
                _changeVC.placeHolder = model.companyURL;
                
            }
            else
            {
                _changeVC.placeHolder = @"请填写企业链接";
                
                
            }
            
            _changeVC.title = @"企业链接";
            
        
            
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
    UIImage *cutImage  = [CommonMethods  getScreenWithImage:editImage];
    
    
    
    NSData *data = UIImagePNGRepresentation(cutImage);
    
    if (selectedIndex == 0) {
        
        SDPhotoItem *logoItem = [[SDPhotoItem alloc]init];
        
        logoItem.imageData = data;
        
        logoItem.thumbnail_pic = nil;
        
        _logoImageView.photoItemArray = @[logoItem];
      
        
    
        if (_isShow) {
            
            [self uploadHeadImage];
            
//            UserModel *model ;
            
            [UserInfo saveModeValue:data key:@"photo_data"];
            
            
        }
        
    }
    else if (selectedIndex == 4)
    {
        
        SDPhotoItem *zhizhaoItem = [[SDPhotoItem alloc]init];
        
        zhizhaoItem.imageData = data;
        
        zhizhaoItem.thumbnail_pic = nil;
        
        _zhizhaoView.photoItemArray = @[zhizhaoItem];
        
//        _zhizhaoImageView.image = cutImage;
        
        if (_isShow) {
            
            [self updateCompanyInfoWithValue:cutImage key:@"pic_license" type:YES];
            
            [UserInfo saveModeValue:data key:@"pic_license_data"];
            
        }
        
      
        
        
        
    }
    else if (selectedIndex == 5)
    {
        
        SDPhotoItem *shuiwuItem = [[SDPhotoItem alloc]init];
        
        shuiwuItem.imageData = data;
        
        shuiwuItem.thumbnail_pic = nil;
        
        _shuiwuView.photoItemArray = @[shuiwuItem];
        
//        _shuiwuImageView.image = cutImage;
        
        if (_isShow) {
            
            [self updateCompanyInfoWithValue:cutImage key:@"company_number" type:YES];
            
              [UserInfo saveModeValue:data key:@"company_number_data"];
            
        }
       
        
        
    }
    else if (selectedIndex == 6)
    {
        SDPhotoItem *jigouItem = [[SDPhotoItem alloc]init];
        
        jigouItem.imageData = data;
        
        jigouItem.thumbnail_pic = nil;
        
        _jigouView.photoItemArray = @[jigouItem];
        
//        _jigouImageView.image = cutImage;
        
        if (_isShow) {
            
            [self updateCompanyInfoWithValue:cutImage key:@"company_code" type:YES];
            
            [UserInfo saveModeValue:data key:@"company_code_data"];
            
            
            
        }
        
        
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
    
    
    UIButton *logoButton = [[_logoImageView subviews]firstObject];
    
    UIImage *_logo = logoButton.currentImage;
    
    UIButton *zhizhaoButton = [[_zhizhaoView subviews] firstObject];
    
    UIImage *_zhizhao = zhizhaoButton.currentImage;
    
    UIButton *shuiwuButton = [[_shuiwuView subviews]firstObject];
    
    UIImage *_shuiwu = shuiwuButton.currentImage;
    
    
    UIButton *jigouButton = [[_jigouView subviews]firstObject];
    
    UIImage *_jigou = jigouButton.currentImage;
    
    
//    _zhizhaoImageView.image == nil || _shuiwuImageView.image == nil || _jigouImageView.image == nil
    if (_nameLabel.text.length == 0 || _logo == nil || _companDesLabel.text.length == 0 || _companyLink.titleLabel.text.length == 0   || _zhizhao == nil || _shuiwu == nil || _jigou == nil) {
        
        
        [CommonMethods showDefaultErrorString:@"请填写完整信息"];
        
        return;
    }
    
    NSString *user_id = [UserInfo getuserid];
    
    NSString *company_name = _nameLabel.text;
    
    NSString *company_URL = _companyLink.titleLabel.text;
    
    NSString *company_description = _companDesLabel.text;
    
    
    
    NSData *pic_license = UIImagePNGRepresentation(_zhizhao);
    
    NSData *company_code = UIImagePNGRepresentation(_shuiwu);
    
    NSData *company_number = UIImagePNGRepresentation(_jigou);
    
    NSDictionary *params = @{@"user_id":user_id,@"company_name":company_name,@"company_URL":company_URL,@"company_description":company_description};
    
    NSDictionary *datas = @{@"pic_license":pic_license,@"company_code":company_code,@"company_number":company_number};
    
    
    
    [[TLRequest shareRequest] requestWithAction:kuploadCompanyInfo params:params datas:datas result:^(BOOL isSuccess, id data) {
       
        
        if (isSuccess) {
          
            [self uploadHeadImage];
            
            NSLog(@"company info uploadSuccess");
            
          
            
            
        }
        
        
        
    }];
    
    
    
}


#pragma mark 更新企业信息
-(void)updateCompanyInfoWithValue:(id)value key:(NSString*)key type:(BOOL)isData
{
    
    NSString *user_id = [UserInfo getuserid];
    
//    NSString *company_name = _nameLabel.text;
//    
//    NSString *company_URL = _linkLabel.text;
//    
//    NSString *company_description = _companDesLabel.text;
//    
//    NSData *pic_license = UIImagePNGRepresentation(_zhizhaoImageView.image);
//    
//    NSData *company_code = UIImagePNGRepresentation(_shuiwuImageView.image);
//    
//    NSData *company_number = UIImagePNGRepresentation(_jigouImageView.image);
    NSDictionary *datas = nil;
    NSDictionary *params = nil;
    
    if (isData) {
        
        params = @{@"user_id":user_id};
        
         NSData *data = UIImagePNGRepresentation(value);
        
        datas = @{key:data};
        
       
        
       
    }
    else
    {
       
        params = @{@"user_id":user_id,key:value};
    }
   
    
    
    
    [[TLRequest shareRequest] requestWithAction:kuploadCompanyInfo params:params datas:datas result:^(BOOL isSuccess, id data) {
        
        
        if (isSuccess) {
            
            NSLog(@"company info updateSuccess!");
            

            
            
        }
        
        
        
    }];
}

#pragma mark -  更新头像
-(void)uploadHeadImage
{
    
    UIButton *logoButton = [[_logoImageView subviews]firstObject];
    UIImage *_logo = logoButton.currentImage;
    
    NSString *user_id = [UserInfo getuserid];
    
    NSData *imageData = UIImagePNGRepresentation(_logo);
    
    
 
    
  
    
    NSDictionary *param = @{@"user_id":user_id};
    

    
    NSDictionary *dataDic ;
    
    dataDic = @{@"pic_file":imageData};
    
    
    
    [[TLRequest shareRequest] requestWithAction:kuploadPic params:param datas:dataDic result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
         
            if (_isShow) {
                
                
            }
            else
            {
                CompanyDoneVC *_companyDoneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanyDoneVC"];
                
                _companyDoneVC.companyName = _nameLabel.text;
                _companyDoneVC.accountName = _accountName;
                [self.navigationController pushViewController:_companyDoneVC animated:YES];
            }
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"保存失败，请重试"];
            
        }
    }];
    
}

- (IBAction)showCompanyLink:(id)sender {
    
    
    UIButton *button = (UIButton*)sender;
    
    NSString *title = button.titleLabel.text;
    
    
    if (title.length == 0) {
        
        return;
        
    }
    
    
    
    WebViewController * _webViewVC = [[WebViewController alloc]init];
    
    
    
    _webViewVC.url = title;
    
    _webViewVC.title = @"企业网址";
    
    [self.navigationController pushViewController:_webViewVC animated:YES];
    
    
    
}

@end
