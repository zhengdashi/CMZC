//
//  CMSaleCollectionViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  卖出

#import <UIKit/UIKit.h>

@class CMSaleCollectionViewCell;

@protocol CMSaleCollectionDelegate <NSObject>

- (void)cm_saleCollectionVC:(CMSaleCollectionViewCell *)saleVC;

@end

@interface CMSaleCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign) id<CMSaleCollectionDelegate>delegate;

@property (nonatomic,copy) NSString  *codeName;

@end
