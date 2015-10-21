//
//  HrDetailViewController.m
//  Taling
//
//  Created by ZhuHaikun on 15/10/17.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "HrDetailViewController.h"
#import "ChatViewController.h"
#import "RecommendCell.h"
#import "ResumeDetailTVC.h"

@interface HrDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSInteger pageIndex;
    
    NSInteger pageSize;
    
    NSMutableArray *_JDArray;
    
    
    
    
}
@end

@implementation HrDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"人才官详情";
    
    _chatButton.clipsToBounds = YES;
    _chatButton.layer.cornerRadius = 5.0;
    
    _JDArray = [[NSMutableArray alloc]init];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    pageSize = 10;
    pageIndex = 1;
    
    [self setHrInfoItem];
    
    [self requestUpLoadResumes];
    
  
    

}

-(void)setHrInfoItem
{
    NSString *username = _hrInfoItem.username;
    NSString *company = _hrInfoItem.company;
    NSString *industry = _hrInfoItem.industry;
    
    if (username.length == 0) {
        
        username = [NSString stringWithFormat:@"匿名用户"];
    }
    
    if (company.length == 0) {
        
        company = [NSString stringWithFormat:@"未填写公司"];
    }
    
    if (industry.length == 0) {
        
        industry = [NSString stringWithFormat:@"未填写行业"];
        
    }
    
    _nameLabel.text = username;
    _companyLabel.text = company;
    _profersionLabel.text = industry;
    
    
 }




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 176;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _JDArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
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



#pragma mark - 获取我的简历列表
-(void)requestUpLoadResumes
{
    NSString *userid = _hrInfoItem.id;
    
    NSDictionary *param = @{@"user_id":userid,@"index":@(pageIndex),@"size":@(pageSize)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetMyResumes Params:param result:^(BOOL isSuccess, id data) {
        
      
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
        
        if (pageIndex == 1)
        {
            
            [_JDArray removeAllObjects];
            
        }
        
        [_JDArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
            
            
     }else
            
        {
            
        }
        
    }];
    
  
    
}



- (IBAction)chatAction:(id)sender {
    
//    NSString *chatter = @"15900785196";
//    NSString *chatter = @"15201931110";
//    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:chatter isGroup:NO];
//    chatVC.title =chatter;
//    [self.navigationController pushViewController:chatVC animated:YES];
    
    
    
}


@end
