//
//  FocusCell.h
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *disLabel;
@property (strong, nonatomic) IBOutlet UIButton *focusButton;
@end
