//
//  RegistTableViewController.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "TLRequest.h"

@interface RegistTableViewController : BaseTableViewController


@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)switch:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
- (IBAction)sendCodeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *SMSCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UITextField *checkCodeTF;


@end
