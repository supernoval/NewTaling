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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carrierLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@end
