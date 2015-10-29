//
//  CommentViewController.h
//  Taling
//
//  Created by Haikun Zhu on 15/10/14.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface CommentViewController : BaseViewController

@property (nonatomic) NSString *resumeid;

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)sumitAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *appraiseButton;

@end
