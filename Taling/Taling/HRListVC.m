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
#import "HRItem.h"

@interface HRListVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _hrdataArray;
    
    NSInteger index;
    NSInteger pageSize;
}

@property (nonatomic)BOOL isRecommendType;
@property (nonatomic)BOOL isSearch;

@end

@implementation HRListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isRecommendType = YES;
    _isSearch = NO;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:_searchBar.bounds.size];
    _hrdataArray = [[NSMutableArray alloc]init];
    
    
    pageSize = 10;
    
    index = 1;
    
    [self requestHRList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}







#pragma mark - 请求数据
-(void)requestHRList
{
    NSString *search;
    if (_isSearch) {
        search = self.searchBar.text;
    }else{
        search = @"";
    }
    
//    _isRecommendType 推荐、关注
    
    NSDictionary *param =@{@"index":@(index),@"size":@(pageSize),@"search":search};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetHrInfo Params:param result:^(BOOL isSuccess, id data) {
        
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
                HRItem *item = [[HRItem alloc]init];
                [item setValuesForKeysWithDictionary:oneDic];
                
                
                [array addObject:item];
                
                
                
            }
            
            if (index == 1)
            {
                
                [_hrdataArray removeAllObjects];
                
            }
            
            [_hrdataArray addObjectsFromArray:array];
            
            [self.tableView reloadData];
            
        }

        
    }];
    
}


-(void)getGuanZhuList
{
    NSDictionary *param = @{@"user_id":[UserInfo getuserid],@"index":@(index),@"size":@(pageSize),@"type":@(1)};
    
    [[TLRequest shareRequest ] tlRequestWithAction:kgetAttention Params:param result:^(BOOL isSuccess, id data) {
        
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
                HRItem *item = [[HRItem alloc]init];
                [item setValuesForKeysWithDictionary:oneDic];
                
                
                [array addObject:item];
                
                
                
            }
            
            if (index == 1)
            {
                
                [_hrdataArray removeAllObjects];
                
            }
            
            [_hrdataArray addObjectsFromArray:array];
            
            [self.tableView reloadData];
            
        }
    }];
}


- (void)headerRefresh
{
    index = 1;
    
    if (_isRecommendType) {
        
        [self requestHRList];
    }
   else
   {
       [self getGuanZhuList];
       
   }
    
}
- (void)footerRefresh
{
    index ++;
    
    if (_isRecommendType) {
        
        [self requestHRList];
    }
    else
    {
         [self getGuanZhuList];
    }
    
    
    
    
}

#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.8)];
    
    blankFooter.backgroundColor = [UIColor clearColor];
    
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
    return 117;
    
   
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _hrdataArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"HRListCell";
    HRListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"HRListCell" owner:self options:nil][0];
    }
    if (_hrdataArray.count > indexPath.section) {
        HRItem *oneItem = [_hrdataArray objectAtIndex:indexPath.section];
        //头像
        if (oneItem.photo.length > 0) {
            

            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.photo] placeholderImage:kDefaultHeadImage];
        }
        else
        {
            cell.headImageView.image = kDefaultHeadImage;
            
        }
        
        
        //姓名
    
            
            NSString *sex = @"";
            
            if ([oneItem.sex isEqualToString:@"0"]) {
                
                sex = @"女";
            }
            else if ([oneItem.sex isEqualToString:@"1"])
            {
                sex = @"男";
            }
            else
            {
                sex = @"";
            }
        
            if (!oneItem.nickname) {
                
                oneItem.nickname = @"";
            }
        
        if (sex.length > 0) {
            
          cell.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",oneItem.nickname,sex];
        }
        else
        {
            cell.nameLabel.text = oneItem.nickname;
            
        }
        
        CGFloat nameWith = [StringHeight widthtWithText:cell.nameLabel.text font:FONT_14 constrainedToHeight:21];
        
        cell.nameLabelWith.constant = nameWith;
        
  
    
    // 推荐净值
        
         NSInteger  value = [[NSString stringWithFormat:@"%@",oneItem.recommend]integerValue];
        if (value == 0) {
            
            value = 1;
        }
        
        if (value > 5) {
            
            value = 5;
            
        }
        
        
        cell.crownImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"crown_%ld",(long)value]];
        
     
        
        //ID  城市  服务过的企业
        if (!oneItem.city) {
            
            oneItem.city = @"";
            
        }
        if (!oneItem.industry) {
            
            oneItem.industry = @"";
            
        }
        cell.idLabel.text = [NSString stringWithFormat:@"编号%@ %@ 所在行业:%@",oneItem.id,oneItem.city,oneItem.industry];
        
    //擅长行业
        
        if (!oneItem.speciality) {
            
            oneItem.speciality = @"";
            
        }
      cell.disLabel.text = [NSString stringWithFormat:@"擅长行业:%@",oneItem.speciality];
        
        if (!oneItem.city) {
            
            oneItem.city = @"";
        }
        
        

    
    //服务过的企业
        cell.servicedCom.text = [CommonMethods getServicedComList:oneItem.customerCompany];
    
    
        }

    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_hrdataArray.count > indexPath.section) {
        HRItem *oneItem = [_hrdataArray objectAtIndex:indexPath.section];
        
        HRDetailTVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"HRDetailTVC"];
        
        detail.hRitem = oneItem;
        detail.hidesBottomBarWhenPushed = YES;
        
        [detail setblock:^(BOOL cancel) {
          
            if (cancel && !_isRecommendType) {
                
                index =1;

                [self getGuanZhuList];
                
            }
            
        }];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


#pragma mark -  UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    NSArray *subViews;
    subViews = [_searchBar.subviews[0] subviews];
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancelBtn setTitleColor:kTextLightGrayColor forState:UIControlStateNormal];
            cancelBtn.userInteractionEnabled = YES;
            cancelBtn.enabled = YES;
            break;
        }
    }
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;

}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    searchBar.showsCancelButton = YES;
    NSArray *subViews;
    subViews = [(_searchBar.subviews[0]) subviews];
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            [cancelbutton setTitleColor:kTextLightGrayColor forState:UIControlStateNormal];
            cancelbutton.userInteractionEnabled =YES;
            cancelbutton.enabled = YES;
            break;
        }
    }
    _isSearch = YES;
    index = 1;
    //请求搜索数据
    [self.tableView.header beginRefreshing];
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    searchBar.showsCancelButton = NO;
    _isSearch = NO;
    index = 1;
    [self.tableView.header beginRefreshing];
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (IBAction)switchAction:(UISegmentedControl *)sender {
    
    
    if (sender.selectedSegmentIndex == 0) {
    
        _isRecommendType = YES;
        
        [_hrdataArray removeAllObjects];
    
        [self headerRefresh];
        
        
        
        
    }else{
        _isRecommendType = NO;
        
        [_hrdataArray removeAllObjects];
        
        [self headerRefresh];
        
    }
}
@end
