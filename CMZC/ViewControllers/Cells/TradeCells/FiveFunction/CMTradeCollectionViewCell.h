//
//  CMTradeCollectionViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  六个item

#import <UIKit/UIKit.h>

@interface CMTradeCollectionViewCell : UICollectionViewCell

/**
 *  传入所需要的数据
 *
 *  @param name      名字
 *  @param introduce 介绍
 *  @param titImage  头像名字
 */
- (void)cm_tradeCollectionNameStr:(NSString *)name
                     introduceStr:(NSString *)introduce
                   titleImageName:(NSString *)titImage;

@end
