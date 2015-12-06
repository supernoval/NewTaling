//
//  HRListVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "HRListVC.h"
#import "HRListCell.h"
#import "HRDetailTVC.h"

@interface HRListVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic)BOOL isRecommendType;

@end

@implementation HRListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isRecommendType = YES;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.8)];
    
    blankFooter.backgroundColor = kLineColor;
    
    return blankFooter;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.8;
    
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
    
    return 162;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"HRListCell";
    HRListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"HRListCell" owner:self options:nil][0];
    }
    
    //    if (_JDArray.count > indexPath.section) {
    
    
    
    //头像
    //        if (oneItem.photo.length > 0) {
    //
    //            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo]];
    //        }
    
    //姓名
//    cell.nameLabel
    
    //ID
    //    cell.idLabel.text = oneItem.name;
    
    // 推荐净值
//        cell.recomValue.text = [NSString stringWithFormat:@"¥%.2f",oneItem.price] ;
    
    
    //城市&擅长行业
    
        cell.disLabel.text = @"上海 擅长行业：移动互联 移动互联 移动互联 移动互联 移动互联 移动互联 移动互联 移动互联 ";
    
    cell.disHeight.constant = [StringHeight heightWithText:@"上海 擅长行业：移动互联 移动互联 移动互联 移动互联 移动互联 移动互联 移动互联 移动互联 " font:FONT_13 constrainedToWidth:ScreenWidth-151];
    
    NSLog(@"+++++height:%f",cell.disLabel.frame.size.height);
    
    
    //服务过的企业
        cell.servicedCom.text = @"百度 百度 百度 百度 百度 百度 百度 百度 百度百度 百度 百度百度 百度 百度";
    
    
    //    }
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HRDetailTVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"HRDetailTVC"];
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
    
    //    if (indexPath.section < _JDArray.count) {
    //
    //        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    //
    //        NSInteger resumesId = oneItem.resumesId;
    //
    //
    //        if (resumesId) {
    //
    //            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //
    //            ResumeDetailVC *resumeDetail = [sb instantiateViewControllerWithIdentifier:@"ResumeDetailVC"];
    //
    //            resumeDetail.type = 1;
    //            resumeDetail.hidesBottomBarWhenPushed = YES;
    //            resumeDetail.item = oneItem;
    //            resumeDetail.VCtitle = @"简历详情";
    //            [self.navigationController pushViewController:resumeDetail animated:YES];
    //
    //        }
    //
    //
    //
    //
    //
    //    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


#pragma mark -  UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //    SearchTableViewController *searchTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchTableViewController"];
    //
    //
    //    searchTVC.hidesBottomBarWhenPushed =YES;
    //
    //    [self.navigationController pushViewController:searchTVC animated:YES];
    
    
    return NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    //    [searchBar resignFirstResponder];
    
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    
    
    
    
    //    [self.view addGestureRecognizer:_tap];
    
}


- (IBAction)switchAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _isRecommendType = YES;
    }else{
        _isRecommendType = NO;
    }
}
@end
