//
//  RecommendTableViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/23.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendTableViewController.h"
#import "ConstantsHeaders.h"

@interface RecommendTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>
{
    UISearchBar *_searchBar;
    
    UISearchDisplayController *_displayController;
    
    UITapGestureRecognizer *_tap;
    
    
}
@end

@implementation RecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐";
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"getdistance"] style:UIBarButtonItemStylePlain target:self action:@selector(showSortView)];
    
    
    self.navigationItem.leftBarButtonItem = item;
    
    _selectedView = [[SelectView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索关键字";
    self.navigationItem.titleView = _searchBar;
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign)];
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
    
    
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
 
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:kHadLogin])
    {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        UINavigationController *loginNav = [sb instantiateViewControllerWithIdentifier:@"LoginNav"];
        
        [self presentViewController:loginNav animated:YES completion:nil];
        
        
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_selectedView removeFromSuperview];
    
}

-(void)headerRefresh
{
    
}

-(void)footerRefresh
{
    
}


-(void)getData
{
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 162;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    
    footerView.backgroundColor = [UIColor clearColor];
    
    
    return footerView;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recomendCell"];
    
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
