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


@property (weak, nonatomic) IBOutlet UILabel *idLabel;


@property (weak, nonatomic) IBOutlet UILabel *placeLabel;//地点&行业


@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@property (strong, nonatomic) IBOutlet UILabel *companyLabel;//公司&职业



@end
