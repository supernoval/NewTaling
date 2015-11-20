//
//  CompanyRegistTVC.m
//  Taling
//
//  Created by ZhuHaikun on 15/11/20.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CompanyRegistTVC.h"

@interface CompanyRegistTVC ()

@end

@implementation CompanyRegistTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}




- (IBAction)summitAction:(id)sender {
    
    /*
     user_id
     company_name
     company_code     税务登记号
     company_number   组织机构代码
     pic_license    //营业执照
     pic_IDCARD1
     pic_IDCARD2
     
     */
    
    NSString *companyName = _companyNameLabel.text;
    
    NSString *shuiwudengji = _shuwuHaoLabel.text;
    
    NSString *gongsidaima = _zuzhijigouLabel.text;
    
    NSData *picOneData = UIImagePNGRepresentation(_YYZZImageView.image);
    
    NSData *pictwoData = UIImagePNGRepresentation(_SFZImageOne.image);
    
    NSData *pictthreeData = UIImagePNGRepresentation(_SFZImageTwo.image);
    
    
    NSDictionary *param = @{@"user_id":[UserInfo getuserid],@"company_name":companyName,@"company_code":shuiwudengji,@"company_number":gongsidaima};
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kRequestHeader,kuploadCompanyInfo];
    NSLog(@"url:%@,param:%@",url,param);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.timeoutInterval = 50.0;
    
    [MyProgressHUD showProgress];
    
    
    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        [formData appendPartWithFileData:picOneData name:@"pic_license" fileName:@"pic_license" mimeType:@"png"];
        [formData appendPartWithFileData:pictwoData name:@"pic_IDCARD1" fileName:@"pic_IDCARD1" mimeType:@"png"];
        [formData appendPartWithFileData:pictthreeData name:@"pic_IDCARD2" fileName:@"pic_IDCARD2" mimeType:@"png"];
        
        
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MyProgressHUD dismiss];
        
        NSInteger result = [[responseObject objectForKey:@"result"]integerValue];
        
        if (result == 1) {
            
            [CommonMethods showDefaultErrorString:[responseObject objectForKey:@"err_str"]];
            
            
        }
        if (result == 0)
        {
            id data = [responseObject objectForKey:@"data"];
            
            
            
            
        }
        
        
        NSLog(@"success:%@",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MyProgressHUD dismiss];
        
        
        
        
        NSLog(@"fail:%@,%@",error,operation.responseString);
    }];
    
}
@end
