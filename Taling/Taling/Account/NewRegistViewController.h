//
//  NewRegistViewController.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/12.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface NewRegistViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIButton *personButton;

- (IBAction)personAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *companybutton;
- (IBAction)companyAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secViewHeight;

@property (weak, nonatomic) IBOutlet UIView *thirdView;


@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;


@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;


@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;

- (IBAction)sendCodeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *checkSMSCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)nextAtion:(id)sender;


- (IBAction)showprivacyAction:(id)sender;

@end
