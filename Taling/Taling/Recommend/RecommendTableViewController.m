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
#import "RecommendCell.h"



typedef NS_ENUM(NSInteger,ReSumeType) {
    
    ResumeTypePay,
    ResumeTypeFree,
    ResumeTypeHot
    
};


@interface RecommendTableViewController ()<UISearchBarDelegate,RecommendHeaderDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    UISearchBar *_searchBar;
    
  
    
    UITapGestureRecognizer *_tap;
    
    NSInteger pageindex;
    NSInteger size;
    
    NSMutableArray *_JDArray;
    
    NSMutableArray *_searchResultsArray;
    
    
 
    
    UISearchDisplayController *_searchController;
    
     ReSumeType resumeType; // 1.免费  2.付费  3.热门
    
    
    NSString *_searchTag;
    
    
    
    
}
@end

@implementation RecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
//    self.title = @"";
    
    _JDArray = [[NSMutableArray alloc]init];
    _searchResultsArray = [[NSMutableArray alloc]init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kBackgroundColor;
        
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"行业、职位、城市、资历";
    self.navigationItem.titleView = _searchBar;


    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign)];
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
//    
//    // 添加头部选择栏

    
    
    
    pageindex = 1;
    size = 10;
    resumeType = ResumeTypePay;
    
    
    [self getMyTags];
    
    
    [self setTabBarColor];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //登陆注册环信账号
    [self CheckEasyMobLogin];
    
//    [self.tableView.header beginRefreshing];
    
    
//    if (![[NSUserDefaults standardUserDefaults]boolForKey:kHadLogin])
//    {
//        
//        
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        
//        UINavigationController *loginNav = [sb instantiateViewControllerWithIdentifier:@"LoginNav"];
//        
//        [self presentViewController:loginNav animated:YES completion:nil];
//        
//        
//    }
//    else
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

#pragma mark - 获取我的标签
-(void)getMyTags
{
    NSString *user_id = [UserInfo getuserid];
    
    if (!user_id) {
        
        return;
    }
    
    NSDictionary *param = @{@"user_id":user_id};
    
    [[TLRequest shareRequest ] tlRequestWithAction:kgetUserLabel Params:param result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            
        }
    }];
    
    
}
#pragma mark  - 通过标签搜索
-(void)searchFromTag
{
    
    NSString *user_id = [UserInfo getuserid];
    
    _searchTag = @"电子";
    
    if (!user_id || !_searchTag) {
        
        
        return;
    }
    NSDictionary *param = @{@"search":_searchTag,@"index":@(pageindex),@"size":@(10),@"user_id":user_id};
    
    
    
    [[TLRequest shareRequest] tlRequestWithAction:ksearchResumes Params:param result:^(BOOL isSuccess, id data) {
       
        
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
            
            if (pageindex == 1)
            {
                
                [_JDArray removeAllObjects];
                
            }
            
            [_JDArray addObjectsFromArray:array];
            
            [self.tableView reloadData];
            
        }
    }];
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
    pageindex = 1;
    
//    [self getData];
    
    [self searchFromTag];
    
    
}

-(void)footerRefresh
{
    pageindex ++;
    
    [self getData];
    
}


#pragma mark - 默认获取简历列表  或者 搜索 行业 职位 等关键字
-(void)getData
{
    
     NSDictionary *param = @{@"index":@(pageindex),@"size":@(size),@"search":@""};
    
    
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
            
            if (pageindex == 1)
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
    
    NSInteger resumes_id = oneItem.resumesId;
    NSString *user_id = [UserInfo getuserid];
    NSDictionary *param = @{@"resumes_id":@(resumes_id),@"user_id":user_id};
    
    
    if ([UserInfo hasSupportTheResume:resumes_id] == YES) {//已经点赞了，取消点赞
        
        [[TLRequest shareRequest]tlRequestWithAction:kcancelSupportTheResume Params:param result:^(BOOL isSuccess, id data){
            
            if (isSuccess) {
                //                        button.selected = NO;
                
                oneItem.goodNum = oneItem.goodNum-1;
                
                [self.tableView reloadData];
            }
            
        }];
        
    }else{
        
        [[TLRequest shareRequest]moreThanDataRequest:ksupportTheResume Params:param result:^(BOOL isSuccess, id data){
            
            if (isSuccess) {
                
                oneItem.goodNum = oneItem.goodNum+1;
                
                [self.tableView reloadData];
            
            }
        }];
        
        }
    
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
    if (oneItem.photo.length > 0) {
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo]];
    }
    
    
    //ID
//    cell.idLabel.text = oneItem.name;
        
    // 简历估值
//    cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",oneItem.price] ;
    
    
    //城市&行业
    
//    cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,edu];

    
    //公司&职业
//    cell.companyLabel.text = [NSString stringWithFormat:@"公司:%@",oneItem.currentCompany];
    
        
    }
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

  


    if (indexPath.section < _JDArray.count) {
        
    ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
        
    NSInteger resumesId = oneItem.resumesId;
        
        
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
//    SearchTableViewController *searchTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchTableViewController"];
//    
//    
//    searchTVC.hidesBottomBarWhenPushed =YES;
//    
//    [self.navigationController pushViewController:searchTVC animated:YES];
//    
//    
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
    
    switch (index) {
        case 0:
        {
            resumeType = ResumeTypePay;
            
         
            
        }
            break;
        case 1:
        {
            resumeType = ResumeTypeFree;
        }
            break;
        case 2:
        {
            resumeType = ResumeTypeHot;
        }
            break;
            
            
        default:
            break;
    }
    
    
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
