//
//  HRListCell.h
//  Taling
//
//  Created by ZhuHaikun on 15/10/17.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *compayLabel;
@property (weak, nonatomic) IBOutlet UILabel *proffessionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end
