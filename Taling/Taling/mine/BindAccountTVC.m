//
//  BindAccountTVC.m
//  Taling
//
//  Created by Leo on 15/10/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "BindAccountTVC.h"
#import "BindDetailTVC.h"

@interface BindAccountTVC ()
@property (nonatomic) BOOL isBindAccount;

@end

@implementation BindAccountTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isBindAccount = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 15;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 79;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"BindAccountCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"BindAccountCell" owner:self options:nil][0];
    }
    
    //图片
    UIImageView *proImage = (UIImageView *)[cell viewWithTag:100];
    
    //名称
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    
    //简介
    UILabel *discription = (UILabel *)[cell viewWithTag:102];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isBindAccount == YES) {
        //
        BindDetailTVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BindDetailTVC"];
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)switchAction:(UISegmentedControl *)sender {
    
    UISegmentedControl *seg = sender;
    
    if (seg.selectedSegmentIndex == 0) {
        
        _isBindAccount = YES;
    }
    else
    {
        _isBindAccount = NO;
        
    }
    
    [self.tableView reloadData];
}
@end
