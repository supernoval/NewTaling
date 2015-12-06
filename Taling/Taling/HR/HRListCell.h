//
//  HRListCell.h
//  Taling
//
//  Created by ZhuHaikun on 15/10/17.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *disLabel;

@property (strong, nonatomic) IBOutlet UILabel *recomValue;

@property (strong, nonatomic) IBOutlet UILabel *servicedCom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *disHeight;



@end
