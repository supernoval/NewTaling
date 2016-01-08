//
//  SummaryCell.h
//  Taling
//
//  Created by Leo on 15/12/5.
//  Copyright © 2015年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTF;

@end
