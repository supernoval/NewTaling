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

@interface ResumeDetailTVC ()

@end

@implementation ResumeDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的简历";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
};

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
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
        return 83;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *nameId = @"ResumeNameCell";
    
    ResumeNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:nameId];
    
    if (nameCell == nil) {
        nameCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeNameCell" owner:self options:nil][0];
    }
    
    
    static NSString *ageId = @"ResumeAgeCell";
    UITableViewCell *ageCell = [tableView dequeueReusableCellWithIdentifier:ageId];
    if (ageCell == nil) {
        ageCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeAgeCell" owner:self options:nil][0];
    }
    
    static NSString *experenceId = @"ResumeExperienceCell";
    ResumeExperienceCell *experenceCell = [tableView dequeueReusableCellWithIdentifier:experenceId];
    if (experenceCell == nil) {
        experenceCell = [[NSBundle mainBundle]loadNibNamed:@"ResumeExperienceCell" owner:self options:nil][0];
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
            return nameCell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

@end
