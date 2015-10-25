//
//  RecommendTableViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendTableViewController.h"
#import "ConstantsHeaders.h"
#import "ResumeDetailVC.h"
#import "BuyResumeDetailTVC.h"
#import "ChatAccountManager.h"
#import "UIImageView+WebCache.h"
#import "SearchTableViewController.h"





@interface RecommendTableViewController ()<UISearchBarDelegate,RecommendHeaderDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    UISearchBar *_searchBar;
    
  
    
    UITapGestureRecognizer *_tap;
    
    NSInteger index;
    NSInteger size;
    
    NSMutableArray *_JDArray;
    
    NSMutableArray *_searchResultsArray;
    
    
 
    
    UISearchDisplayController *_searchController;
    
    
    
}
@end

@implementation RecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐";
    
    _JDArray = [[NSMutableArray alloc]init];
    _searchResultsArray = [[NSMutableArray alloc]init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kBackgroundColor;
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"getdistance"] style:UIBarButtonItemStylePlain target:self action:@selector(showSortView)];
//    
//    
//    self.navigationItem.leftBarButtonItem = item;
    
    _selectedView = [[SelectView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"行业、职位、城市、资历";
    self.navigationItem.titleView = _searchBar;

    
    
    
    

    
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign)];
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
//    
//    // 添加头部选择栏
    [self.view addSubview:self.headerView];
    
    
    index = 1;
    size = 10;
    
    
    [self setTabBarColor];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //登陆注册环信账号
    [self CheckEasyMobLogin];
    
//    [self.tableView.header beginRefreshing];
    
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:kHadLogin])
    {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        UINavigationController *loginNav = [sb instantiateViewControllerWithIdentifier:@"LoginNav"];
        
        [self presentViewController:loginNav animated:YES completion:nil];
        
        
    }
    else
    {
        [self.tableView.header beginRefreshing];
 
    }
    
    
 
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
    
  

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_selectedView removeFromSuperview];
    
}


#pragma mark - 顶部 付费 免费 热门
-(RecommendHeaderView*)headerView
{
    if (!_headerView) {
        
        _headerView = [[RecommendHeaderView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 36)];
        
        _headerView.delegate = self;
       
    }
    
    return _headerView;
    
}



-(void)CheckEasyMobLogin
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kEasyMobHadLogin] && [[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin]) {
        
        NSString *account =[UserInfo getUsername];
        

        [[ChatAccountManager shareChatAccountManager] loginWithAccount:account successBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                NSLog(@"Login EaseMob Success:%@",account);
                
                
            }
            else
            {
                
            }
            
        }];
    }
}

-(void)headerRefresh
{
    index = 1;
    
    [self getData];
    
}

-(void)footerRefresh
{
    index ++;
    
    [self getData];
    
}


-(void)getData
{
    NSDictionary *param = @{@"index":@(index),@"size":@(size)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetCommendResumes Params:param result:^(BOOL isSuccess, id data) {
       
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
       
        
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


-(void)resign
{
    [_searchBar resignFirstResponder];
    
}

-(void)showSortView
{
    [self.navigationController.view addSubview:_selectedView];
    [_selectedView show];
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
#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    
    blankFooter.backgroundColor = [UIColor clearColor];
    
    return blankFooter;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 172;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _searchController.searchResultsTableView) {
        
        return _searchResultsArray.count;
        
    }
    return _JDArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   
     ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    
     //搜索界面
    
    if (tableView == _searchController.searchResultsTableView ) {
        
        oneItem = [_searchResultsArray objectAtIndex:indexPath.section];
        
    }
    
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recomendCell"];
    
    if (_JDArray.count > indexPath.section) {
        
   
    
    //头像
    if (oneItem.url.length > 0) {
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.url]];
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
    
//    if (cell.priseButton.selected == YES) {
//        cell.priseButton.backgroundColor = [UIColor redColor];
//    }else{
//        cell.priseButton.backgroundColor = [UIColor clearColor];
//    }
    
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


#pragma mark -  UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SearchTableViewController *searchTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchTableViewController"];
    
    
    searchTVC.hidesBottomBarWhenPushed =YES;
    
    [self.navigationController pushViewController:searchTVC animated:YES];
    
    
    return NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    [self.view removeGestureRecognizer:_tap];
    
//    [searchBar resignFirstResponder];
    
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    

    
    
    
//    [self.view addGestureRecognizer:_tap];
    
}



#pragma mark - RecommendHeaderDelegate
-(void)selectedButtonIndex:(NSInteger)index
{
    [self headerRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- 购买建立
- (void)buyTheResume:(UIButton *)btn{
    
    ModelItem *buyItem = [_JDArray objectAtIndex:btn.tag];
    
    BuyResumeDetailTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyResumeDetailTVC"];
    
    buy.item = buyItem;
    
    [self.navigationController pushViewController:buy animated:YES];
    
    
}


-(void)setTabBarColor
{
    UITabBar*tabbar = self.tabBarController.tabBar;
   
//    tabbar.backgroundColor = [UIColor whiteColor];
   
    
    
//
    UITabBarItem *item0 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabbar.items objectAtIndex:3];
//
//    item0.selectedImage = [UIImage imageNamed:@"chonen on"];
    item0.image = [[UIImage imageNamed:@"chonen off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    item1.selectedImage = [UIImage imageNamed:@"chonen"];
    item1.image = [[UIImage imageNamed:@"orders off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    item2.selectedImage = [UIImage imageNamed:@"chonen"];
    item2.image = [[UIImage imageNamed:@"message off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    item3.selectedImage = [UIImage imageNamed:@"chonen"];
    item3.image = [[UIImage imageNamed:@"mine off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
}


@end
