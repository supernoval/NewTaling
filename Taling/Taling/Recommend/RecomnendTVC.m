//
//  RecomnendTVC.m
//  Taling
//
//  Created by Leo on 15/12/4.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "RecomnendTVC.h"
#import "ResumeDetailVC.h"
#import "ChatAccountManager.h"
#import "UIImageView+WebCache.h"
#import "RecommendCell.h"
#import "TagLabel.h"
#import "RecommendDetailVC.h"

@interface RecomnendTVC ()<UISearchBarDelegate>
{
    UISearchBar *_searchBar;
    
    NSInteger pageindex;
    NSInteger size;
    
    NSMutableArray *_JDArray;
    

}

@end

@implementation RecomnendTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _JDArray = [[NSMutableArray alloc]init];
    
    self.tableView.backgroundColor = kBackgroundColor;
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"行业、职位、城市、资历";
    self.navigationItem.titleView = _searchBar;

    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    pageindex = 1;
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
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
//        [self getData];
    
//    [self searchFromTag];
    
    
}

-(void)footerRefresh
{
    pageindex ++;
    
//    [self getData];
    
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

#pragma mark  - 通过标签搜索

/*
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
}*/


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
    
    UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(0, blankFooter.frame.size.height-10, ScreenWidth, 10)];
    gap.backgroundColor = kBackgroundColor;
    [blankFooter addSubview:gap];
    
    return blankFooter;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 90;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 73;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
//    return _JDArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
//    ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    static NSString *cellId = @"RecommendCell";
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RecommendCell" owner:self options:nil][0];
    }
    
//    if (_JDArray.count > indexPath.section) {
    
        
        
        //头像
//        if (oneItem.photo.length > 0) {
//            
//            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo]];
//        }
        
        
        //ID
        //    cell.idLabel.text = oneItem.name;
        
        // 简历估值
        //    cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",oneItem.price] ;
        
        
        //城市&行业
        
        //    cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,edu];
        
        
        //公司&职业
        //    cell.companyLabel.text = [NSString stringWithFormat:@"公司:%@",oneItem.currentCompany];
        
        
//    }
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendDetailVC"];
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
