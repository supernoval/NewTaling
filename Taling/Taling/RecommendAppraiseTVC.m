//
//  RecommendAppraiseTVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendAppraiseTVC.h"
#import "CommentCell.h"

@interface RecommendAppraiseTVC ()

@end

@implementation RecommendAppraiseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    float tagWidth = (ScreenWidth-30-3*TagGap)/4;
    float tagHeight = 30;
    NSInteger count = 7;
    NSInteger tagRow;
    if (count%4 == 0) {
        tagRow = count/4;
    }else{
        tagRow = count/4 + 1;
    }
    
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*tagRow+10)];
    
    blankFooter.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i < count; i++) {
        
        TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
        tagLabel.text = [NSString stringWithFormat:@"高级%li",(long)i];
        [blankFooter addSubview:tagLabel];
        
    }
    
//    UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-1, ScreenWidth, 1)];
//    gap.backgroundColor = kLineColor;
//    [blankFooter addSubview:gap];
    
    return blankFooter;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100+[StringHeight heightWithText:@"丰富经历：描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历\n专家擅长：主要擅长什么主要擅长什么主要擅长什么主要擅长什么主要擅长什么\n关键业绩：关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩\n优缺点：你的也有缺点赶紧爆出来你会打篮球吗" font:FONT_14 constrainedToWidth:ScreenWidth-30];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"HRListCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
    }
    
    //头像
    //            cell.headImageView
    
    //姓名
    //            cell.nameLabel
    
    //id
    //            cell.idLabel
    
    //time
    //            cell.timeLabel
    
    //评论内容
    //            cell.commentLabel
    
    NSString *text = @"丰富经历：描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历描述丰富的经历\n专家擅长：主要擅长什么主要擅长什么主要擅长什么主要擅长什么主要擅长什么\n关键业绩：关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩关键干了做了什么好的业绩\n优缺点：你的也有缺点赶紧爆出来你会打篮球吗";
    cell.commentLabel.text = text;
    
    return cell;
}


@end
