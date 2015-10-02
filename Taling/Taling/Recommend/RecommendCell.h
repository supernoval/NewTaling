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


@property (weak, nonatomic) IBOutlet UILabel *placeLabel;


@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UILabel *businessLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *businessWidth;


@property (strong, nonatomic) IBOutlet UILabel *companyLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *companyWidth;


@property (strong, nonatomic) IBOutlet UILabel *professionLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *professionWidth;


@property (strong, nonatomic) IBOutlet UILabel *yearLabel;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *yeatWidth;


@property (strong, nonatomic) IBOutlet UIButton *priseButton;


@property (strong, nonatomic) IBOutlet UIButton *messageButton;


@property (strong, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end
