//
//  RecommendTableViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendTableViewController.h"
#import "ConstantsHeaders.h"
#import "ResumeDetailTVC.h"
#import "BuyResumeDetailTVC.h"
#import "ChatAccountManager.h"


@interface RecommendTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,RecommendHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar *_searchBar;
    
    UISearchDisplayController *_displayController;
    
    UITapGestureRecognizer *_tap;
    
    NSInteger index;
    NSInteger size;
    
    NSMutableArray *_JDArray;
    
    
    
}
@end

@implementation RecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐";
    
    _JDArray = [[NSMutableArray alloc]init];
    

    
    
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
    
    
    // 添加头部选择栏
    [self.view addSubview:self.headerView];
    
    
    index = 1;
    size = 10;
    
  
    
    
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //登陆注册环信账号
    [self CheckEasyMobLogin];
    
    
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

-(RecommendHeaderView*)headerView
{
    if (!_headerView) {
        
        _headerView = [[RecommendHeaderView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 44)];
        
        _headerView.delegate = self;
       
    }
    
    return _headerView;
    
}



-(void)CheckEasyMobLogin
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kEasyMobHadLogin] && [[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin]) {
        
        NSString *account =[UserInfo getAccount_id];
        
//        NSString *account = @"15201931110";
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
    
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recomendCell"];
    
    ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    
    //姓名
    cell.nameLabel.text = oneItem.name;
    
    //城市、教育程度
    cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,oneItem.city];
    
    // 简历估值
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[oneItem.price floatValue]] ;
    
    //公司
    cell.companyLabel.text = [NSString stringWithFormat:@"公司:%@",oneItem.currentCompany];
    
    
    //点赞
    [cell.priseButton setTitle:[NSString stringWithFormat:@"%@",oneItem.goodNum] forState:UIControlStateNormal];
    
    [cell.buyButton addTarget:self action:@selector(buyTheResume:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.buyButton.tag = indexPath.section;
  
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

  


    if (indexPath.section < _JDArray.count) {
        
    ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
        
    NSString *resumesId = oneItem.resumesId;
        
        
      if (resumesId) {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            
            ResumeDetailTVC *resumeDetail = [sb instantiateViewControllerWithIdentifier:@"ResumeDetailTVC"];
            
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
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view removeGestureRecognizer:_tap];
    
    [searchBar resignFirstResponder];
    
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.view addGestureRecognizer:_tap];
    
}


#pragma mark - RecommendHeaderDelegate
-(void)selectedButtonIndex:(NSInteger)index
{
    
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




@end
