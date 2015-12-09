//
//  CommentTVC.m
//  Taling
//
//  Created by ucan on 15/12/9.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CommentTVC.h"

@interface CommentTVC ()<UITextViewDelegate>
@property (strong,nonatomic)NSMutableArray *tagArray;
@property (nonatomic)NSInteger chooseNum;

@end

@implementation CommentTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    _experenceTextView.delegate = self;
    _skillsTextView.delegate = self;
    _performTextView.delegate = self;
    _advantageTextView.delegate = self;
    _chooseNum = 0;
    
    NSArray *array = @[
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"},
                          @{@"title":@"ios开发",@"selected":@"0"}
                          ];
    
    _tagArray = [[NSMutableArray alloc]initWithArray:array];
    self.tableView.tableHeaderView = [self tableHeaderView];
    self.tableView.tableFooterView = [self tableFooterView];
                          
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableHeaderView{
    
    
    float gap = 15;
    
    float tagWidth = (ScreenWidth-30-3*TagGap)/4;
    float tagHeight = 30;
    NSInteger count = _tagArray.count;
    NSInteger tagRow;
    if (count%4 == 0) {
        tagRow = count/4;
    }else{
        tagRow = count/4 + 1;
    }
    
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*tagRow+gap)];
    
    blankFooter.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i < count; i++) {
        NSDictionary *oneTag = [_tagArray objectAtIndex:i];
        NSString *tagTitle = [oneTag objectForKey:@"title"];
        NSString *selectedStr = [oneTag objectForKey:@"selected"];
        
        TagButton *tagButton = [[TagButton alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap)+gap, tagWidth, tagHeight)];

        [tagButton setTitle:tagTitle forState:UIControlStateNormal];
        
        if ([selectedStr isEqualToString:@"0"]) {
            tagButton.selected = NO;
        }else{
            
            tagButton.selected = YES;
        }
        
        tagButton.tag = i;
        
        [tagButton addTarget:self action:@selector(chooseTagAction:) forControlEvents:UIControlEventTouchUpInside];
        [blankFooter addSubview:tagButton];
        
    }
    
    return blankFooter;

}

- (void)chooseTagAction:(UIButton *)button{
    
    
    
    
    NSInteger i = button.tag;
    NSDictionary *replaceDic;
    NSDictionary *oneDic = [_tagArray objectAtIndex:i];
    NSString *selected = [oneDic objectForKey:@"selected"];
    NSString *title = [oneDic objectForKey:@"title"];
    if ([selected isEqualToString:@"0"]) {
        if (_chooseNum > 7) {
            [CommonMethods showDefaultErrorString:@"最多只能选择8个标签"];
            return;
        }
        replaceDic = @{@"title":title,@"selected":@"1"};
        _chooseNum ++;
        
    }else{
        replaceDic = @{@"title":title,@"selected":@"0"};
        _chooseNum --;
    }
    
    [_tagArray replaceObjectAtIndex:i withObject:replaceDic];
    self.tableView.tableHeaderView = [self tableHeaderView];
    
}

- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, ScreenWidth-30, 40)];
    [logoutBtn setTintColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"完成并分享" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = FONT_17;
    logoutBtn.backgroundColor = NavigationBarColor;
    logoutBtn.clipsToBounds = YES;
    logoutBtn.layer.cornerRadius = 5.0;
    [logoutBtn addTarget:self action:@selector(completeAndShareAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:logoutBtn];
    return footerView;
}

#pragma mark- 评价没输入内容提示
- (void)alertWithNoContent{
    if (_experenceTextView.text.length == 0) {
        [CommonMethods showDefaultErrorString:@"请输入对人才经历的评价"];
    }else if (_skillsTextView.text.length == 0) {
        [CommonMethods showDefaultErrorString:@"请输入对人才专长的评价"];
    }else if (_performTextView.text.length == 0) {
        [CommonMethods showDefaultErrorString:@"请输入对人才关键业绩的评价"];
    }else if (_advantageTextView.text.length == 0) {
        [CommonMethods showDefaultErrorString:@"请输入对人才优势缺点的评价"];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 0;
    }
    return 5;
}

#pragma mark- textViewDelegate


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
    }
    
    NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (textView == _experenceTextView) {
        if ([toBeString length] > 0) {
            _experenceLabel.text = @"";
            if ([toBeString length] > 60) {
                textView.text = [toBeString substringToIndex:60];
                return NO;
            }
            
        }else{
            _experenceLabel.text = @"点击输入您对人才经历的评价";
        }
    }else  if (textView == _skillsTextView) {
        if ([toBeString length] > 0) {
            _skillsLabel.text = @"";
            if ([toBeString length] > 60) {
                textView.text = [toBeString substringToIndex:60];
                return NO;
            }
            
        }else{
            _skillsLabel.text = @"点击输入您对人才专长的评价";
        }
    }else  if (textView == _performTextView) {
        if ([toBeString length] > 0) {
            _performLabel.text = @"";
            if ([toBeString length] > 60) {
                textView.text = [toBeString substringToIndex:60];
                return NO;
            }
            
        }else{
            _performLabel.text = @"点击输入您对人才关键业绩的评价";
        }
    }else  if (textView == _advantageTextView) {
        if ([toBeString length] > 0) {
            _advantageLabel.text = @"";
            if ([toBeString length] > 60) {
                textView.text = [toBeString substringToIndex:60];
                return NO;
            }
            
        }else{
            _advantageLabel.text = @"点击输入您对人才优势缺点的评价";
        }
    }
    
   
    return YES;
}

//完成并分享
- (void)completeAndShareAction{
    
    [self alertWithNoContent];
}

//取消
- (IBAction)cancelAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//完成
- (IBAction)completeAction:(id)sender {
    [self alertWithNoContent];
}
@end