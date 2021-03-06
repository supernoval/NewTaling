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
#import "BuyResumeDetailTVC.h"
#import "CommentViewController.h"
#import "UIImageView+WebCache.h"



@interface ResumeDetailTVC ()
{
    NSInteger appraseIndex;
    NSInteger appraseSize;
    
}
@property (nonatomic, strong)NSMutableArray *commentArry;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger size;
@property (nonatomic)CGFloat schoolHeight;
@property (nonatomic)CGFloat workHeight;
@property (nonatomic)CGFloat skillsHeight;
@property (nonatomic)CGFloat likeHeight;

@end

@implementation ResumeDetailTVC
@synthesize type;//1 购买 2 评价
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_VCtitle) {
        
         self.title = _VCtitle;
    }
    else
    {
         self.title = @"我的简历";
    }

    
    _commentArry = [[NSMutableArray alloc]init];
    
  
    
//    [self addHeaderRefresh];
//    [self addFooterRefresh];
    
    _index = 1;
    _size = 10;
    
    appraseIndex = 1;
    appraseSize = 10;
    
    
//    [self.tableView.header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _index = 1;
    
    [self getData];
    
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
    
    if (!item.resumesId) {
        
        return;
        
    }
    NSDictionary *param = @{@"resumes_id":item.resumesId,@"index":@(appraseIndex),@"size":@(appraseSize)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetAppraise Params:param result:^(BOOL isSuccess, id data) {
        
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
/*
- (UIView *)sectionHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headerView.backgroundColor = kContentColor;
    UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-15, 40)];
    sectionLabel.text = @"经历概述";
    sectionLabel.font = [UIFont boldSystemFontOfSize:15];
    sectionLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:sectionLabel];
    return headerView;
}

- (UIView *)tableFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    
    footerView.backgroundColor = kBackgroundColor;
    

    CGFloat buttonWith = ScreenWidth/2 - 30;
    
    
    UIButton *reservButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, buttonWith, 30)];
    reservButton.clipsToBounds = YES;
    reservButton.layer.cornerRadius = 5;
    
    
    [reservButton addTarget:self action:@selector(reservResume) forControlEvents:UIControlEventTouchUpInside];
    
    [reservButton setTitle:@"预定" forState:UIControlStateNormal];
    reservButton.backgroundColor = NavigationBarColor;
    
    [reservButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reservButton setTitleColor:kDarkGrayColor forState:UIControlStateHighlighted];
    
    [footerView addSubview:reservButton];
    
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(40 + buttonWith, 5, buttonWith, 30)];
    
    [buyBtn setTintColor:[UIColor whiteColor]];
    [buyBtn setTitleColor:kDarkGrayColor forState:UIControlStateHighlighted];
    buyBtn.clipsToBounds = YES;
    buyBtn.layer.cornerRadius = 5;
    
  
    
    buyBtn.backgroundColor = NavigationBarColor;
    
    if (self.type == 1) {
        [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    }else if (self.type == 2){
        [buyBtn setTitle:@"评价" forState:UIControlStateNormal];
    }
    
    
    
    [buyBtn addTarget:self action:@selector(buyTheResume) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:buyBtn];
    
    return footerView;
    
}*/

#pragma mark- 购买、评价简历

- (void)buyTheResume{
    
    if (self.type == 1) {
        //购买
        
        BuyResumeDetailTVC *buy = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyResumeDetailTVC"];
        buy.item = self.item;
        [self.navigationController pushViewController:buy animated:YES];
    }else if (self.type == 2){
        //评价
        
        CommentViewController *commentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentViewController"];
        commentVC.resumeid = self.item.resumesId;
        [self.navigationController pushViewController:commentVC animated:YES];
        
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
};

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return 4;
        
    }else if (section == 4) {
        
        return _commentArry.count;
    }
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 83;
    }else if (indexPath.section == 1){
        return 88;
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            return _schoolHeight+51;
        }else if (indexPath.row == 1){
            
            return _workHeight;
            
        }else if (indexPath.row == 2){
            
            return _skillsHeight+18;
            
        }else if (indexPath.row == 3){
            
            return _likeHeight+18;
        }
        
        return 0;
        
    }else if (indexPath.section == 3){
        return 119;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            //姓名等基本信息
            static NSString *nameId = @"ResumeNameCell";
            
            ResumeNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:nameId];
            
            if (nameCell == nil) {
                nameCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeNameCell" owner:self options:nil][0];
            }
            
            
            
            //头像
            if (self.item.url.length > 0) {
                
                [nameCell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.item.url]];
            }
            
            //姓名
            nameCell.nameLabel.text = self.item.name;
            nameCell.nameWidth.constant = [StringHeight widthtWithText:self.item.name font:FONT_15 constrainedToHeight:21];
            //性别
            if ([self.item.sex isEqualToString:@"男"]) {
                nameCell.sexImageView.image = [UIImage imageNamed:@"male"];
            }else if ([self.item.sex isEqualToString:@"女"]){
                
                nameCell.sexImageView.image = [UIImage imageNamed:@"female"];
            }else{
                
                nameCell.sexImageView.image = [UIImage imageNamed:@""];
            }
            
            // 简历估值
            nameCell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[self.item.price floatValue]];
            
            
            //城市、教育程度
            NSString *edu = @"";
            if (self.item.eduexpenrience.count > 0) {
                NSDictionary *eduDic = [self.item.eduexpenrience firstObject];
                edu = [eduDic objectForKey:@"degree"];
            }
            nameCell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",self.item.city,edu];
            
            //职业
            nameCell.professionLabel.text = [NSString stringWithFormat:@"%@ %@年经验",self.item.currentPosition,self.item.workYears];

            return nameCell;
            
        }
            break;
            
        case 1:
        {
            //年龄、城市、公司
            static NSString *ageId = @"ResumeAgeCell";
            UITableViewCell *ageCell = [tableView dequeueReusableCellWithIdentifier:ageId];
            if (ageCell == nil) {
                ageCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeAgeCell" owner:self options:nil][0];
            }
            //年龄
            UILabel *ageLabel = (UILabel *)[ageCell viewWithTag:100];
            ageLabel.text = [NSString stringWithFormat:@"年龄:%@",self.item.age];
            
            //城市
            UILabel *cityLabel = (UILabel *)[ageCell viewWithTag:101];
            cityLabel.text = [NSString stringWithFormat:@"城市:%@",self.item.city];
            
            //公司
            UILabel *companyLabel = (UILabel *)[ageCell viewWithTag:102];
            companyLabel.text = [NSString stringWithFormat:@"公司:%@",self.item.currentCompany];
            
            return ageCell;
        }
            break;
            
        case 2:
        {
            //经历概述
            
            switch (indexPath.row) {
                case 0:
                {
                    //毕业学校
                    static NSString *schoolId = @"GraduateCell";
                    UITableViewCell *schoolCell = [tableView dequeueReusableCellWithIdentifier:schoolId];
                    if (schoolCell == nil) {
                        schoolCell = [[NSBundle mainBundle]loadNibNamed:@"GraduateCell" owner:self options:nil][0];
                    }
                    
                    //学校
                    UILabel *schoolLabel = (UILabel *)[schoolCell viewWithTag:101];
                    
                    NSString *school = @" ";
                    if (self.item.eduexpenrience.count > 0 ) {
                        NSDictionary *dic = [self.item.eduexpenrience firstObject];
                        school = [dic objectForKey:@"school"];
                    }
                    schoolLabel.text = school;
                    _schoolHeight = [StringHeight heightWithText:school font:FONT_15 constrainedToWidth:ScreenWidth-96];
                    
                    return schoolCell;
                    
                }
                    break;
                    
                case 1:
                {
                    static NSString *experenceId = @"ResumeExperienceCell";
                    ResumeExperienceCell *experenceCell = [tableView dequeueReusableCellWithIdentifier:experenceId];
                    if (experenceCell == nil) {
                        experenceCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeExperienceCell" owner:self options:nil][0];
                    }
                    //工作经历
                    experenceCell.titleLabel.text = @"工作经历:";
                    NSString *experienceStr = [CommonMethods getTheWorkExperience:self.item.workexpenrience];
                    experenceCell.contentLabel.text = experienceStr;
                    _workHeight = [StringHeight heightWithText:experienceStr font:FONT_15 constrainedToWidth:ScreenWidth-96];
                    
                    return experenceCell;
                    
                }
                    break;
                    
                case 2:
                {
                    static NSString *experenceId = @"ResumeExperienceCell";
                    ResumeExperienceCell *experenceCell = [tableView dequeueReusableCellWithIdentifier:experenceId];
                    if (experenceCell == nil) {
                        experenceCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeExperienceCell" owner:self options:nil][0];
                    }
                    //办公技巧
                    NSString *skillsStr = [CommonMethods getTheSkills:self.item.skills];
                    experenceCell.titleLabel.text = @"办公技巧:";
                    experenceCell.contentLabel.text = skillsStr;
                    _skillsHeight = [StringHeight heightWithText:skillsStr font:FONT_15 constrainedToWidth:ScreenWidth-96];
                    
                    return experenceCell;
                    
                }
                    break;
                    
                case 3:
                {
                    static NSString *experenceId = @"ResumeExperienceCell";
                    ResumeExperienceCell *experenceCell = [tableView dequeueReusableCellWithIdentifier:experenceId];
                    if (experenceCell == nil) {
                        experenceCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeExperienceCell" owner:self options:nil][0];
                    }
                    //生活喜好
                    experenceCell.titleLabel.text = @"个人总结:";
                    experenceCell.contentLabel.text = self.item.summary;
                    _likeHeight = [StringHeight heightWithText:self.item.summary font:FONT_15 constrainedToWidth:ScreenWidth-96];
                    
                    return experenceCell;
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
//        case 3:
//        {
//            
//            //评价、点赞、购买数
//            static NSString *operationId = @"ResumeOperationCell";
//            ResumeOpetationCell *operationCell = [tableView dequeueReusableCellWithIdentifier:operationId];
//            if (operationCell == nil) {
//                operationCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeOperationCell" owner:self options:nil][0];
//            }
//            
//            //评价
//            [operationCell.commentBtn setTitle:@"24" forState:UIControlStateNormal];
//            
//            //点赞
//            [operationCell.goodBtn setTitle:@"29" forState:UIControlStateNormal];
//            
//            //购买数
//            [operationCell.buyBtn setTitle:@"24" forState:UIControlStateNormal];
//            
//            return operationCell;
//        }
//            break;
            
        case 3:
        {

            //评论
            static NSString *commentId = @"CommentCell";
            CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:commentId];
            if (commentCell == nil) {
                commentCell = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil][0];
            }
            
            
//            NSDictionary *oneComment = [_commentArry objectAtIndex:indexPath.row];
//            commentCell.commentLabel.text = [oneComment objectForKey:@"comment"];
            
            commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return commentCell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

#pragma mark - 预定
-(void)reservResume
{
    
    NSString *userid = [UserInfo getuserid];
    
    NSString *resumeid = self.item.resumesId;
    
    NSDictionary *param = @{@"user_id":userid,@"resumes_id":resumeid};
    
    [[TLRequest shareRequest] tlRequestWithAction:kreservResume Params:param result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"预定成功"];
            
        }
        else
        {
           [CommonMethods showDefaultErrorString:@"预定失败，请重试"];
        }
    }];
    
}

@end
