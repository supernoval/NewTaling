//
//  ResumeDetailTVC.m
//  Taling
//
//  Created by Leo on 15/10/3.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "ResumeDetailTVC.h"
#import "ResumeNameCell.h"
#import "ResumeExperienceCell.h"
#import "ResumeOpetationCell.h"
#import "CommentCell.h"
#import "ConstantsHeaders.h"


@interface ResumeDetailTVC ()
@property (nonatomic, strong)NSMutableArray *commentArry;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger size;

@end

@implementation ResumeDetailTVC
@synthesize type;//1 购买 2 评价

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的简历";
    
    _commentArry = [[NSMutableArray alloc]init];
    
    self.tableView.tableFooterView = [self tableFooterView];
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
    _index = 1;
    _size = 10;
    
//    [self.tableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headerRefresh{
    _index = 1;
    [self getData];
}
- (void)footerRefresh{
    
    _index ++;
    [self getData];
}

-(void)getData
{
    NSDictionary *param = @{@"index":@(_index),@"size":@(_size)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetCommendResumes Params:param result:^(BOOL isSuccess, id data) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (isSuccess) {
            
            if (_index == 1)
            {
                
                [_commentArry removeAllObjects];
                
            }
            
            [_commentArry addObjectsFromArray:data];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}


- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    
    footerView.backgroundColor = NavigationBarColor;
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    
    [buyBtn setTintColor:[UIColor whiteColor]];
    
    buyBtn.titleLabel.font = FONT_16;
    
    if (self.type == 1) {
        [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    }else if (self.type == 2){
        [buyBtn setTitle:@"评价" forState:UIControlStateNormal];
    }
    
    
    
    [buyBtn addTarget:self action:@selector(buyTheResume) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:buyBtn];
    
    return footerView;
    
}

#pragma mark- 购买、评价简历

- (void)buyTheResume{
    
    if (self.type == 1) {
        //购买
    }else if (self.type == 2){
        //评价
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
};

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 4) {
        return 3;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 83;
    }else if (indexPath.section == 1){
        return 88;
    }else if (indexPath.section == 2){
        return 209;
    }else if (indexPath.section == 3){
        return 45;
    }else if (indexPath.section == 4){
        return 119;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //姓名等基本信息
    static NSString *nameId = @"ResumeNameCell";
    
    ResumeNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:nameId];
    
    if (nameCell == nil) {
        nameCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeNameCell" owner:self options:nil][0];
    }
    
    //年龄、城市、公司
    static NSString *ageId = @"ResumeAgeCell";
    UITableViewCell *ageCell = [tableView dequeueReusableCellWithIdentifier:ageId];
    if (ageCell == nil) {
        ageCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeAgeCell" owner:self options:nil][0];
    }
    
    //经历概述
    static NSString *experenceId = @"ResumeExperienceCell";
    ResumeExperienceCell *experenceCell = [tableView dequeueReusableCellWithIdentifier:experenceId];
    if (experenceCell == nil) {
        experenceCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeExperienceCell" owner:self options:nil][0];
    }
    
    //评价、点赞、购买数
    static NSString *operationId = @"ResumeOperationCell";
    ResumeOpetationCell *operationCell = [tableView dequeueReusableCellWithIdentifier:operationId];
    if (operationCell == nil) {
        operationCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeOperationCell" owner:self options:nil][0];
    }
    
    //评论
    static NSString *commentId = @"CommentCell";
    CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:commentId];
    if (commentCell == nil) {
        commentCell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            return nameCell;
        }
            break;
            
        case 1:
        {
            //年龄
            UILabel *age = (UILabel *)[ageCell viewWithTag:100];
            age.text = [NSString stringWithFormat:@"年龄:%@",@"48"];
            
            //城市
            UILabel *city = (UILabel *)[ageCell viewWithTag:101];
            city.text = [NSString stringWithFormat:@"城市:%@",@"国际市"];
            
            //公司
            UILabel *company = (UILabel *)[ageCell viewWithTag:102];
            company.text = [NSString stringWithFormat:@"公司:%@",@"国际中央政治局"];
            
            return ageCell;
        }
            break;
            
        case 2:
        {
            return experenceCell;
        }
            break;
            
        case 3:
        {
            //评价
            [operationCell.commentBtn setTitle:@"24" forState:UIControlStateNormal];
            
            //点赞
            [operationCell.goodBtn setTitle:@"29" forState:UIControlStateNormal];
            
            //购买数
            [operationCell.buyBtn setTitle:@"24" forState:UIControlStateNormal];
            
            return operationCell;
        }
            break;
            
        case 4:
        {
            return commentCell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

@end
