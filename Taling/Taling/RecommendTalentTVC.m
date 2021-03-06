//
//  RecommendTalentTVC.m
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import "RecommendTalentTVC.h"
#import "RecommendCell.h"
#import "RecommendDetailVC.h"
@interface RecommendTalentTVC ()
{
    NSInteger pageindex;
    NSInteger size;
    NSMutableArray *_JDArray;
}

@end

@implementation RecommendTalentTVC
@synthesize hRitem;

- (void)viewDidLoad {
    [super viewDidLoad];
    _JDArray = [[NSMutableArray alloc]init];
    
    self.title = @"Ta的人才";
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    pageindex = 1;
    size = 10;
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)headerRefresh
{
    pageindex = 1;
    
    [self getData];
    
    
}

-(void)footerRefresh
{
    pageindex ++;
    
    [self getData];
    
}



#pragma mark - 获取人才官推荐的人才
-(void)getData
{
    NSString *userid = hRitem.id;
    
    NSDictionary *param = @{@"user_id":userid,@"index":@(pageindex),@"size":@(size)};
    
    [[TLRequest shareRequest] tlRequestWithAction:kgetMyResumes Params:param result:^(BOOL isSuccess, id data) {
        
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
            
            
        }else
        {
            
        }
        
    }];
    
}



#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_JDArray.count > section) {
        ModelItem *oneItem = [_JDArray objectAtIndex:section];
        
        float tagWidth = (ScreenWidth-30-3*TagGap)/4;
        float tagHeight = 24;
        NSInteger count = oneItem.resumesLabel.count;
        NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
        
        UIView *blankFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 34*tagRow)];
        
        blankFooter.backgroundColor = [UIColor whiteColor];
        for (NSInteger i = 0; i < count; i++) {
            NSDictionary *oneLabel = [oneItem.resumesLabel objectAtIndex:i];
            
            TagLabel *tagLabel = [[TagLabel alloc]initWithFrame:CGRectMake(15+(i%4)*(tagWidth+TagGap), i/4*(tagHeight+TagGap), tagWidth, tagHeight)];
            NSString *word =[NSString stringWithFormat:@"%@",[oneLabel objectForKey:@"word"]];
            
            NSArray *_words = nil;
            
            if (word.length > 0) {
                
                _words = [word componentsSeparatedByString:@"_"];
            }
            
            
            if (_words.count > 1) {
                
                word = [_words firstObject];
            }
            else
            {
                word = @"";
            }
            
            tagLabel.text = word;
          
            [blankFooter addSubview:tagLabel];
            
        }
        
        //    UIView *gap = [[UIView alloc]initWithFrame:CGRectMake(15, blankFooter.frame.size.height-1, ScreenWidth-15, 1)];
        //    gap.backgroundColor = kLineColor;
        //    [blankFooter addSubview:gap];
        
        UIButton *detailAction = [[UIButton alloc]initWithFrame:blankFooter.frame];
        [detailAction addTarget:self action:@selector(pushToDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        detailAction.tag = section;
        [blankFooter addSubview:detailAction];
        
        return blankFooter;
    }
    
    return nil;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_JDArray.count > section) {
        ModelItem *oneItem = [_JDArray objectAtIndex:section];
        NSInteger count = oneItem.resumesLabel.count;
        NSInteger tagRow = count%4==0 ? count/4:count/4 + 1 ;
        if (tagRow>0) {
            return 34*tagRow+5;
        }else{
            return 34*tagRow;
        }

    }
    
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 79;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _JDArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellId = @"RecommendCell";
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RecommendCell" owner:self options:nil][0];
    }
    
        if (_JDArray.count > indexPath.section) {
            
            
        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
    
    
            //头像
            if (oneItem.photo.length > 0) {
                
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:oneItem.userPhoto] placeholderImage:kDefaultHeadImage];
                
            }
            
            //估值
            
            NSString *titleStr = [NSString stringWithFormat:@"估值  ¥%.0f",oneItem.price];
            NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:titleStr];
            [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 2)];
            [title addAttribute:NSForegroundColorAttributeName value:kTextLightGrayColor range:NSMakeRange(0, 2)];
            cell.priceLabel.attributedText = title;
            
            
            //人才名称
            cell.idLabel.text = [NSString stringWithFormat:@"%@",oneItem.name];
            
            
            //地址&公式名称
            cell.companyLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.city,oneItem.currentCompany];
            
            //行业&职位
            cell.placeLabel.text = [NSString stringWithFormat:@"%@ %@",oneItem.currentIndustry,oneItem.currentPosition];
        }
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _JDArray.count) {
        
        ModelItem *oneItem = [_JDArray objectAtIndex:indexPath.section];
        
        NSInteger resumesId = oneItem.resumesId;
        
        
        if (resumesId) {
            
            RecommendDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendDetailVC"];
            detail.item = oneItem;
            [self.navigationController pushViewController:detail animated:YES];
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)pushToDetailAction:(UIButton *)btn{
    
    
        
        ModelItem *oneItem = [_JDArray objectAtIndex:btn.tag];
        
        NSInteger resumesId = oneItem.resumesId;
        
        
        if (resumesId) {
            
            RecommendDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendDetailVC"];
            detail.item = oneItem;
            [self.navigationController pushViewController:detail animated:YES];
        }
        

    
}


@end
