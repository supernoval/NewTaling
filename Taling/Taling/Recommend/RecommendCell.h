//
//  RecommendCell.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/9.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@property (weak, nonatomic) IBOutlet UILabel *idLabel;//姓名


@property (weak, nonatomic) IBOutlet UILabel *placeLabel;//行业&职位


@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//估值



@property (strong, nonatomic) IBOutlet UILabel *companyLabel;//地址&公司名称



@end
