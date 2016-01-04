//
//  YanZhengViewController.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface YanZhengViewController : BaseViewController


@property (nonatomic,strong) NSString *email;

@property (weak, nonatomic) IBOutlet UIButton *phoneCheckButton;


- (IBAction)phoneAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *emailcheckbutton;

- (IBAction)emailAction:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *phoneNunTF;

@property (weak, nonatomic) IBOutlet UILabel *coundownLabel;


@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;

- (IBAction)sendCodeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)deleteAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *cartimageView;

@property (weak, nonatomic) IBOutlet UIView *secondView;



- (IBAction)addPhoto:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneAction:(id)sender;


@end
