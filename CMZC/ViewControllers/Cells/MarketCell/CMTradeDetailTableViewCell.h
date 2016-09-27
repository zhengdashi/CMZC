//
//  CMTradeDetailTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTradeDetailTableViewCell : UITableViewCell


@property (strong, nonatomic) NSArray *contDataArr;

- (void)setContDataArr:(NSArray *)contDataArr openPrict:(float)prict;

+ (instancetype)cell;


@end
