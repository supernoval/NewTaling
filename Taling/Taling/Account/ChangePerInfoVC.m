//
//  ChangePerInfoVC.m
//  Taling
//
//  Created by ZhuHaikun on 15/12/13.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ChangePerInfoVC.h"

@interface ChangePerInfoVC ()

@end

@implementation ChangePerInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _changeTF.placeholder = _placeHolder;
    
    
}

-(void)setBlock:(ChangeInfoBlock)block
{
    _block = block;
    
    
}




- (IBAction)saveAction:(id)sender {
    
    
    if (_changeTF.text.length > 0) {
        
        if (_block) {
            
            _block(_changeTF.text);
            
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
}
@end
