//
//  CompanyInfoTableView.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CompanyInfoTableView.h"
#import "CompanyDoneVC.h"

@interface CompanyInfoTableView ()

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



- (IBAction)nextAction:(id)sender {
    
    CompanyDoneVC *_companyDoneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanyDoneVC"];
    
    
    [self.navigationController pushViewController:_companyDoneVC animated:YES];
}
@end
