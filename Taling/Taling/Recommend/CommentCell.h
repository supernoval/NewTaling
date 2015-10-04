//
//  CommentCell.h
//  Taling
//
//  Created by Leo on 15/10/4.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@end
