//
//  CMTradeMeansTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  买入 持有 cell

#import <UIKit/UIKit.h>

#import "CMAccountinfo.h"

@protocol CMTradeMeansTableViewCellDelegate <NSObject>
/**
 *  delegate 是跳转到子界面
 *
 *  @param index 传出点击了那个item
 */
- (void)cm_tradeMeadsTableViewIndex:(NSInteger)index;

@end

@interface CMTradeMeansTableViewCell : UITableViewCell

@property (nonatomic,assign)id<CMTradeMeansTableViewCellDelegate>delegate;

@property (strong, nonatomic) CMAccountinfo *info;

@end
