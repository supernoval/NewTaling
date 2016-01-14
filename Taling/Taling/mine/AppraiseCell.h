//
//  AppraiseCell.h
//  Taling
//
//  Created by ucan on 16/1/14.
//  Copyright © 2016年 ZhuHaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AppraiseCellDelegate<NSObject>
- (void)clickButtonDelegate:(NSInteger)num answerNum:(NSInteger)answerNum;

@end
@interface AppraiseCell : UITableViewCell

@property (nonatomic)NSInteger cellTag;
@property (nonatomic)id<AppraiseCellDelegate>delegate;

- (void)assignView:(NSDictionary *)dic;


@end
