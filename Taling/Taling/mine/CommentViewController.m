//
//  CommentViewController.m
//  Taling
//
//  Created by Haikun Zhu on 15/10/14.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()<UIAlertViewDelegate>

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appraiseButton.clipsToBounds = YES;
    self.appraiseButton.layer.cornerRadius = 5.0;
    // Do any additional setup after loading the view.
    
    self.title = @"添加评价";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
    
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

- (IBAction)sumitAction:(id)sender {
    
    if (self.textView.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写评价内容"];
        
        return;
        
    }
    
    [self sumitRequest];
    
}

-(void)sumitRequest
{
    NSString *userid = [UserInfo getuserid];
    NSString *coment = self.textView.text;
    
    NSDictionary *params = @{@"user_id":userid,@"resumes_id":@(_resumeid),@"comment":coment};
    
    [[TLRequest shareRequest] tlRequestWithAction:kaddAppraise Params:params result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            [CommonMethods showAlertString:@"评价成功" delegate:self tag:100];
            
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"评价失败，请重试"];
            
            
        }
        
    }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
@end
