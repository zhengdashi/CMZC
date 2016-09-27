//
//  CMNewQualityCollectionViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMNumberous.h"

@interface CMNewQualityCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSArray   *dataArray;

/**
 *  传入数据
 *
 *  @param calss   这是一个类。现在没数据，先用calss
 *  @param bgImage 背景图片name
 */
- (void)cm_newQualityCellClass:(CMNumberous *)number
                    bgImageArr:(NSString *)bgImage;

@end
