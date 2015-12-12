//
//  ChangePerInfoVC.h
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^ChangeInfoBlock)(NSString *result);


@interface ChangePerInfoVC : BaseViewController



@property (weak, nonatomic) IBOutlet UITextField *changeTF;

@property (nonatomic) NSString *placeHolder;

@property (nonatomic,strong) ChangeInfoBlock block;


- (IBAction)saveAction:(id)sender;



@end
