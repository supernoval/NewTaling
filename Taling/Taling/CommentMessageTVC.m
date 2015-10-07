//
//  CommentMessageTVC.m
//  Taling
//
//  Created by Leo on 15/10/6.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CommentMessageTVC.h"
#import "CommentMessageCell.h"
#import "StringHeight.h"

@interface CommentMessageTVC ()

@end

@implementation CommentMessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //209-21+评论内容高度
    
    return 188+[StringHeight heightWithText:@"这个小伙子非常不错，活好，懂事听话，态度积极，关键是活好，活好就是好，活好可以找到好工作" font:FONT_14 constrainedToWidth:ScreenWidth - 30];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CommentMessageCell";
    CommentMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CommentMeaageCell" owner:self options:nil][0];
    }
    
    cell.contentLabel.text = @"这个小伙子非常不错，活好，懂事听话，态度积极，关键是活好，活好就是好，活好可以找到好工作";
    //姓名的宽度
    //    cell.nameWidth.constant = 55;
    return cell;
}


@end
