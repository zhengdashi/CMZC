//
//  CMInquireCollectionViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  查询

#import <UIKit/UIKit.h>


@protocol CMInquireCollectionViewCellDelegate <NSObject>
/**
 *  传出所点击的indexPath
 *
 *  @param indexPath 所点击的indexPath
 */
- (void)cm_inquireCollectionIndexPath:(NSIndexPath *)indexPath;

@end

@interface CMInquireCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign)id<CMInquireCollectionViewCellDelegate>delegate;

@end
