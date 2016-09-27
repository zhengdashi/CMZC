//
//  CMOptionCollectionViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/4/6.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  四个选项卡的view

#import <UIKit/UIKit.h>

@interface CMOptionCollectionViewCell : UICollectionViewCell

/**
 *  传入所需要的数据
 *
 *  @param titleName 图片名字
 *  @param nameStr   名字
 */
- (void)cm_optionCollectionCellTitleImageName:(NSString *)titleName
                                   nameLabStr:(NSString *)nameStr;

@end
