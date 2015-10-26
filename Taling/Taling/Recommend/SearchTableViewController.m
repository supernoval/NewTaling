//
//  SearchTableViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/10/25.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "SearchTableViewController.h"
#import "RecommendCell.h"
#import "ResumeDetailVC.h"
#import "BuyResumeDetailTVC.h"




@interface SearchTableViewController ()<UISearchBarDelegate>
{
    NSMutableArray *_JDArray;
    
    NSInteger index;
    NSInteger size;
    
    
}
@property (nonatomic,strong) UISearchDisplayController*mySearchDisplayController;
@property (nonatomic,strong) UISearchBar *searchBar;


@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _JDArray = [[NSMutableArray alloc]init];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _searchBar.delegate = self;
    
    _searchBar.placeholder = @"行业、职位、城市、资历";
    
    self.navigationItem.titleView = _searchBar;
    
    index = 1;
    size = 10;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   [_searchBar becomeFirstResponder];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    
}


-(void)getData
{
    NSDictionary *param = @{@"index":@(index),@"size":@(size),@"search":_searchBar.text};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetCommendResumes Params:param result:^(BOOL isSuccess, id data) {
        
        
        
        
        if (isSuccess) {
            
            NSArray *dataArray = [[NSArray alloc]init];//请求获取到的数据
            
            NSMutableArray *array = [[NSMutableArray alloc]init];//解析后的数据
            
            if ([data isKindOfClass:[NSArray class]]) {
                dataArray = data;
            }
            
            for (NSInteger i = 0; i < dataArray.count; i++) {
                NSDictionary *oneDic = [dataArray objectAtIndex:i];
                ModelItem *item = [[ModelItem alloc]init];
                [item setValuesForKeysWithDictionary:oneDic];
                [array addObject:item];
                
            }
            
            if (index == 1)
            {
                
                [_JDArray removeAllObjects];
                
            }
            
            [_JDArray addObjectsFromArray:array];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}


#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self getData];
    
    
    [searchBar resignFirstResponder];
    
    
}

#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    
    blankFooter.backgroundColor = [UIColor clearColor];
    
    return blankFooter;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 176;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _JDArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    
    //搜索界面

    
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recomendCell"];
    
    if (_JDArray.count > indexPath.section) {
        
        
        
        //头像
        if (oneItem.url.length > 0) {
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.url] placeholderImage:[UIImage imageNamed:@"test"]];
            
            
        }
        
        
        //姓名
        cell.nameLabel.text = oneItem.name;
        
        
        //城市、教育程度
        NSString *edu = @"";
        if (oneItem.eduexpenrience.count > 0) {
            NSDictionary *eduDic = [oneItem.eduexpenrience firstObject];
            edu = [eduDic objectForKey:@"degree"];
        }
        cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,edu];
        
        // 简历估值
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[oneItem.price floatValue]] ;
        
        //行业
        cell.businessLabel.text = @"行业";
        
        //职业
        cell.professionLabel.text = [NSString stringWithFormat:@"职位:%@",oneItem.currentPosition];
        
        //公司
        cell.companyLabel.text = [NSString stringWithFormat:@"公司:%@",oneItem.currentCompany];
        
        //资历
        cell.yearLabel.text = [NSString stringWithFormat:@"资历:%@年",oneItem.workYears];
        
        //点赞数
        [cell.priseButton setTitle:[NSString stringWithFormat:@"%@",oneItem.goodNum] forState:UIControlStateNormal];
        cell.priseButton.tag = indexPath.section;
        [cell.priseButton addTarget:self action:@selector(supportTheResume:) forControlEvents:UIControlEventTouchUpInside];
         cell.priseButton.backgroundColor = [UIColor clearColor];
        
//        if (cell.priseButton.selected == YES) {
//            cell.priseButton.backgroundColor = [UIColor redColor];
//        }else{
//            cell.priseButton.backgroundColor = [UIColor clearColor];
//        }
        
        //评价数
        [cell.messageButton setTitle:[NSString stringWithFormat:@"%@",oneItem.appraiseNum] forState:UIControlStateNormal];
        
        //购买数
        [cell.collectButton setTitle:[NSString stringWithFormat:@"%@",oneItem.buyNum] forState:UIControlStateNormal];
        
        
        [cell.buyButton addTarget:self action:@selector(buyTheResume:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.buyButton.tag = indexPath.section;
        
    }
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if (indexPath.section < _JDArray.count) {
        
        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
        
        NSString *resumesId = oneItem.resumesId;
        
        
        if (resumesId) {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            
            ResumeDetailVC *resumeDetail = [sb instantiateViewControllerWithIdentifier:@"ResumeDetailVC"];
            
            resumeDetail.type = 1;
            resumeDetail.hidesBottomBarWhenPushed = YES;
            resumeDetail.item = oneItem;
            resumeDetail.VCtitle = @"简历详情";
            [self.navigationController pushViewController:resumeDetail animated:YES];
            
        }
        
        
        
        
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


#pragma mark- 简历点赞
- (void)supportTheResume:(UIButton *)button{
    
    ModelItem *oneItem = [_JDArray objectAtIndex:button.tag];
    
    NSString *resumes_id = oneItem.resumesId;
    NSString *user_id = [UserInfo getuserid];
    NSDictionary *param = @{@"resumes_id":resumes_id,@"user_id":user_id};
    if (button.selected == NO) {//赞
        
        [[TLRequest shareRequest]tlRequestWithAction:ksupportTheResume Params:param result:^(BOOL isSuccess, id data){
            
            if (isSuccess) {
                button.selected = YES;
                NSInteger num = [oneItem.goodNum integerValue];
                oneItem.goodNum = [NSString stringWithFormat:@"%li",num+1];
            }
            
        }];
    }else if (button.selected == YES){//取消点赞
        
        [[TLRequest shareRequest]tlRequestWithAction:kcancelSupportTheResume Params:param result:^(BOOL isSuccess, id data){
            
            if (isSuccess) {
                button.selected = NO;
                NSInteger num = [oneItem.goodNum integerValue];
                oneItem.goodNum = [NSString stringWithFormat:@"%li",num-1];
            }
            
        }];
    }
    
    [self.tableView reloadData];
    
    //    [self.tableView reloadSections:button.tag withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark- 购买建立
- (void)buyTheResume:(UIButton *)btn{
    
    ModelItem *buyItem = [_JDArray objectAtIndex:btn.tag];
    
    BuyResumeDetailTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyResumeDetailTVC"];
    
    buy.item = buyItem;
    
    [self.navigationController pushViewController:buy animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
