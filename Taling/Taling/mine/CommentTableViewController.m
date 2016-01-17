//
//  CommentTableViewController.m
//  Taling
//
//  Created by ucan on 16/1/14.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import "CommentTableViewController.h"
#import "AppraiseCell.h"

@interface CommentTableViewController ()<UITextViewDelegate,AppraiseCellDelegate>
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (nonatomic, strong)UITextView *textView;

@end

@implementation CommentTableViewController
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    self.view.backgroundColor = kBackgroundColor;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"CommentList" ofType:@"plist"];
    _dataArray = [[NSMutableArray alloc]initWithContentsOfFile:path];
    self.tableView.tableFooterView = [self tableFooterView];
    self.tableView.backgroundColor = kBackgroundColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppraiseCell *cell = [[AppraiseCell alloc]init];
    cell.delegate = self;
    cell.tag = indexPath.section;
    
    NSDictionary *one = [_dataArray objectAtIndex:indexPath.section];
    [cell assignView:one];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *one = [_dataArray objectAtIndex:indexPath.row];
    NSArray *array = [one objectForKey:@"option"];
    NSInteger count = array.count;
    NSInteger tagRow;
    if (count%4 == 0) {
        tagRow = count/4;
    }else{
        tagRow = count/4 + 1;
    }
    return 32+34*tagRow;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    
    blankView.backgroundColor = [UIColor clearColor];
    
    
    return blankView;
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    footerView.backgroundColor = kContentColor;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, ScreenWidth-30, 18)];
    titleLabel.font = FONT_15;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"整体评估(40个字)";
    [footerView addSubview:titleLabel];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, titleLabel.frame.origin.y+titleLabel.frame.size.height+10, ScreenWidth-30, 45)];
    _textView.clipsToBounds = YES;
    _textView.layer.cornerRadius = 5.0;
    _textView.layer.borderWidth = 1.0;
    _textView.layer.borderColor = kTextLightGrayColor.CGColor;
    _textView.textColor = kTextLightGrayColor;
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.font = FONT_14;
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    [footerView addSubview:_textView];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, _textView.frame.origin.y+_textView.frame.size.height+25, ScreenWidth-30, 40)];
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

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.view.frame = CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height);
        
        
    }];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.2 animations:^{
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
    }
    
    NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([toBeString length] > 40) {
        textView.text = [toBeString substringToIndex:40];
        return NO;
    }else{
        return YES;
    }

}

#pragma mark- appraisecellDelegate
- (void)clickButtonDelegate:(NSInteger)num answerNum:(NSInteger)answerNum{
    
    NSMutableDictionary *oneQ = [_dataArray objectAtIndex:num];//点击的问题
    NSMutableArray *optionArray = [oneQ objectForKey:@"option"];//问题的答案
    BOOL isSingle = [[oneQ objectForKey:@"isSingle"]boolValue];//是否单选
    NSMutableDictionary *oneAnswer = [optionArray objectAtIndex:answerNum];//点击的那个答案
    BOOL selected = [[oneAnswer objectForKey:@"selected"]boolValue];//点击的答案是否已选中
    if (isSingle == YES) {//是单选
        if (selected == YES) {//被选中
            [oneAnswer setObject:@(NO) forKey:@"selected"];
            [optionArray replaceObjectAtIndex:answerNum withObject:oneAnswer];
            [oneQ setObject:optionArray forKey:@"option"];
            
        }else{
            
            for (NSInteger i=0; i<optionArray.count; i++) {
                NSMutableDictionary *otherAnswer = [optionArray objectAtIndex:i];
                [otherAnswer setObject:@(NO) forKey:@"selected"];
                [optionArray replaceObjectAtIndex:i withObject:otherAnswer];
            }
            
            [oneAnswer setObject:@(YES) forKey:@"selected"];
            
            NSLog(@"%@",oneAnswer);
            [optionArray replaceObjectAtIndex:answerNum withObject:oneAnswer];
            [oneQ setObject:optionArray forKey:@"option"];
        }
    }else{//多选
        
        if (selected == YES) {//被选中
            [oneAnswer setObject:@(NO) forKey:@"selected"];
            
            
        }else{
            
            [oneAnswer setObject:@(YES) forKey:@"selected"];
            
        }
        
        [optionArray replaceObjectAtIndex:answerNum withObject:oneAnswer];
        [oneQ setObject:optionArray forKey:@"option"];
        
        
    }
    
    [_dataArray replaceObjectAtIndex:num withObject:oneQ];
    
    [self.tableView reloadData];
        
    
}

- (void)completeAndShareAction{
    
    [self showNoneAlert];
    
    
}

- (void)showNoneAlert{
    
    for (NSInteger i=0; i<_dataArray.count; i++) {
        NSDictionary *oneQ = [_dataArray objectAtIndex:i];
        NSString *title = [oneQ objectForKey:@"title"];
        NSArray *optionArray = [oneQ objectForKey:@"option"];
        
        NSInteger unansweredNum = 0;
        for (NSInteger a=0; a<optionArray.count; a++) {
            NSDictionary *oneAnswer = [optionArray objectAtIndex:a];
            BOOL selected = [[oneAnswer objectForKey:@"selected"]boolValue];
            if (selected == NO) {
                unansweredNum ++;
            }
        }
        
        if (unansweredNum == optionArray.count) {
            [CommonMethods showDefaultErrorString:[NSString stringWithFormat:@"%@未填写",title]];
            return;
        }
    }
    
    if (_textView.text.length == 0) {
        [CommonMethods showDefaultErrorString:@"整体评估未填写"];
        return;
    }else{
        [self sumitRequest];
        
        
    }
}
-(void)sumitRequest
{
    NSString *label = @"";//标签
    
    for (NSInteger i = 0; i < _dataArray.count; i++) {
        NSString *oneLabel = @"";
        NSDictionary *oneQ = [_dataArray objectAtIndex:i];
        NSString *title = [oneQ objectForKey:@"title"];
        title = [title stringByAppendingString:@":"];
        NSArray *optionArray = [oneQ objectForKey:@"option"];
        for (NSInteger a=0; a<optionArray.count; a++) {
            NSDictionary *oneAns = [optionArray objectAtIndex:a];
            NSString *answer = [oneAns objectForKey:@"answer"];
            answer = [answer stringByAppendingString:@"、"];
            BOOL selected = [[oneAns objectForKey:@"selected"]boolValue];
            if (selected == YES) {
                oneLabel = [oneLabel stringByAppendingString:answer];
            }
        }
        
        if (oneLabel.length>0) {
            oneLabel = [oneLabel substringToIndex:oneLabel.length-1];
        }
        
        oneLabel = [title stringByAppendingString:oneLabel];
        oneLabel = [oneLabel stringByAppendingString:@"\n\n"];
        
        label = [label stringByAppendingString:oneLabel];
        
        
        
    }
    
    NSString *str = [NSString stringWithFormat:@"整体评估:%@",_textView.text];
    
    //评价内容
    label = [label stringByAppendingString:str];
    
  
    
    NSLog(@"&&&&&&:%@",label);
    
    NSString *userid = [UserInfo getuserid];
    
    NSDictionary *params = @{@"user_id":userid,@"resumes_id":@(item.resumesId),@"comment":label,@"lable":@""};
    
    [[TLRequest shareRequest] tlRequestWithAction:kaddAppraise Params:params result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            if (_block) {
                
                _block(YES);
            }
            [CommonMethods showAlertString:@"评价成功" delegate:self tag:100];
            
            
        }
        else
        {
            
            
            if (_block) {
                
                _block(NO);
                
            }
            
            [CommonMethods showDefaultErrorString:@"评价失败，请重试"];
            
            
        }
        
    }];
    
}
#pragma mark- alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}


-(void)setblock:(CommentBlock)block
{
    _block = block;
    
    
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)completeAction:(id)sender {
    [self showNoneAlert];
}
@end
