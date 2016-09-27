//
//  CMBuyingCollectionViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  买入

#import <UIKit/UIKit.h>

#import "CMAccountinfo.h"

@class CMBuyingCollectionViewCell;
@protocol CMBuyingCellDelegate <NSObject>

- (void)cm_buyingCollectionView:(CMBuyingCollectionViewCell *)buyingVC;

@end

@interface CMBuyingCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) CMAccountinfo *tinfo;

@property (nonatomic,assign) id<CMBuyingCellDelegate>delegate;

@property (nonatomic,copy) NSString  *codeName;

@end
