//
//  CommentMessageTVC.m
//  Taling
//
//  Created by Leo on 15/10/6.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "CommentMessageTVC.h"
#import "CommentMessageCell.h"

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
    
    return 209;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CommentMessageCell";
    CommentMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        NSLog(@"***:%f",cell.frame.size.width);
        cell = [[NSBundle mainBundle]loadNibNamed:@"CommentMessageCell" owner:self options:nil][0];
    }
    //姓名的宽度
    //    cell.nameWidth.constant = 55;
    return cell;
}


@end
