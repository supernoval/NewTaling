//
//  PickAddressViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/8/30.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import "PickAddressViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <CoreLocation/CoreLocation.h>
static CGFloat tableViewHeight = 160.0;

@interface PickAddressViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MAMapView *_mapView;
    
    AMapSearchAPI *_search;
    
    UITableView *_addressListTVC;
    
    NSMutableArray *_addressArray;
    
    MAPointAnnotation *_pointAnnotation;
    
    UIView *_centerPointView;
    UIButton *_buttonAddress;
    UIImageView *_pinView;
    
    
}
@property (nonatomic) AMapAddressComponent *currentAddressComponent;

@property (nonatomic) NSString *address;
@property (nonatomic)NSString *province;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *district;
@property (nonatomic) NSString *township;

@end

@implementation PickAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择地址";
    
    _addressArray = [[NSMutableArray alloc]init];
    
    
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - tableViewHeight)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    
    _pointAnnotation = [[MAPointAnnotation alloc]init];
    
    
    _search = [[AMapSearchAPI alloc]initWithSearchKey:kGaodeMapKey Delegate:self];
    
    _search.delegate = self;
    
    
    _addressListTVC = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight - tableViewHeight, ScreenWidth, tableViewHeight) style:UITableViewStylePlain];
    _addressListTVC.delegate = self;
    _addressListTVC.dataSource = self;
    _addressListTVC.separatorStyle = UITableViewCellSeparatorStyleNone;
    _addressListTVC.backgroundColor = kBackgroundColor;
    
    [self.view addSubview:_addressListTVC];
    
    [self getCenterPointView];
    
    
}

-(void)getCenterPointView
{
    CGFloat height = [self addresseHeight:_address];
    CGFloat pointViewHeight = 72;
    CGFloat pointWith = 44;
    
    _centerPointView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, height + pointViewHeight)];
    _centerPointView.center = CGPointMake(_mapView.center.x, _mapView.center.y - pointViewHeight);
    
    _buttonAddress = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, height)];
    
    _buttonAddress.titleLabel.text = _address;
    _buttonAddress.titleLabel.numberOfLines = 0;
    _buttonAddress.titleLabel.font = FONT_15;
    _buttonAddress.backgroundColor = [UIColor whiteColor];
    
    
    _buttonAddress.clipsToBounds = YES;
    _buttonAddress.layer.cornerRadius = 5;
    
    [_buttonAddress setTitleColor:kOrangeTextColor forState:UIControlStateNormal];
    [_buttonAddress setTitleColor:kContentColor forState:UIControlStateHighlighted];
    [_buttonAddress addTarget:self action:@selector(addAddressToTableView) forControlEvents:UIControlEventTouchUpInside];
    
    [_centerPointView addSubview:_buttonAddress];
    
    _pinView = [[UIImageView alloc]initWithFrame:CGRectMake((100-pointWith)/2, height, pointWith, pointViewHeight)];
    
  
    
    
    _pinView.image = [UIImage imageNamed:@"redPin"];
    
    [_centerPointView addSubview:_pinView];
    
    
    [self.view addSubview:_centerPointView];
    
    
    
   
}

-(void)resetCenterViewFrame
{
    CGFloat height = [self addresseHeight:_address];
    CGFloat pointViewHeight = 72;
    CGFloat pointWith = 44;
    
    CGRect oldRect = _centerPointView.frame;
    
    _centerPointView.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y, oldRect.size.width, height + pointViewHeight);
  
    _buttonAddress.frame = CGRectMake(0, 0, oldRect.size.width,height);
    
    
    _pinView.frame = CGRectMake((100-pointWith)/2, height, pointWith, pointViewHeight);
    
    [_buttonAddress setTitle:_address forState:UIControlStateNormal];
    
    
}

-(CGFloat)addresseHeight:(NSString*)text
{
    CGFloat height = [StringHeight heightWithText:text font:FONT_16 constrainedToWidth:100];
    
    
    return height + 10;
    
}

#pragma mark -  添加地址
-(void)addAddressToTableView
{
    if (_address && _currentAddressComponent) {
        
        NSDictionary *addressDict = @{@"address":_address,@"component":_currentAddressComponent};
        
        [_addressArray addObject:addressDict];
        
        [_addressListTVC reloadData];
        
    }
}

#pragma mark -  UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _addressArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor clearColor];
    
    return lineView;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        
        cell.textLabel.textColor = kDarkTintColor;
        cell.textLabel.font = FONT_16;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    
    NSDictionary *dict = [_addressArray objectAtIndex:indexPath.section];
    
    NSString *address = [dict objectForKey:@"address"];
    
    cell.textLabel.text = address;
    
    
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - MAMapViewDelegate
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    
   static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        
        [self showUserAddress:userLocation];
        
    });
  
    
    
    
    
    
}

-(void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
  
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect oldRect = _centerPointView.frame;
        
        _centerPointView.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y - 10, oldRect.size.width, oldRect.size.height);
        
    }];
  
}
-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
    
    [self searchChineseAddress:point];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _centerPointView.center = _mapView.center;
        
    }];
}

#pragma mark - AMapSearchDelegate

-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode) {
        
        NSString *result = [NSString stringWithFormat:@"reGeocode:%@",response.regeocode];
        
        NSLog(@"ReGeo:%@",result);
        
        NSString *address = response.regeocode.formattedAddress;
        
        NSLog(@"address:%@",address);
        
        _address = address;
        _currentAddressComponent = response.regeocode.addressComponent;
        
        [self resetCenterViewFrame];
        
        
    }
}


-(void)showUserAddress:(MAUserLocation*)locaiton
{
      [_mapView setRegion:MACoordinateRegionMakeWithDistance(locaiton.coordinate, 500, 500) animated:YES];
    
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:locaiton.location.coordinate.latitude    longitude:locaiton.location.coordinate.longitude];
    
    [self searchChineseAddress:point];
    
    
  
}


#pragma mark - 搜索中文地址
-(void)searchChineseAddress:(AMapGeoPoint*)point
{
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc]init];
    request.location = point;
    request.searchType = AMapSearchType_ReGeocode;
    request.radius = 1000;
    request.requireExtension = NO;
    [_search AMapReGoecodeSearch:request];
    
    
    
    
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
