//
//  CMHoldCollectionViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  持有

#import <UIKit/UIKit.h>

#import "CMAccountinfo.h"
#import "CMHoldInquire.h"

@protocol CMHoldCollectionViewDelegate <NSObject>

/**
 *  点击详情的时候
 *
 *  @param inquire inquiry类
 */
- (void)cm_holdCollectionViewInquire:(CMHoldInquire *)inquire;

@end


typedef void(^CMHoldCollectionBlock)();

@interface CMHoldCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) CMAccountinfo *tinfo;

@property (nonatomic,assign)id<CMHoldCollectionViewDelegate>delegate;

@property (nonatomic,copy) CMHoldCollectionBlock block;

@end
