//
//  SellOrderCell.h
//  Taling
//
//  Created by Haikun Zhu on 15/9/9.
//  Copyright (c) 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;



@end
