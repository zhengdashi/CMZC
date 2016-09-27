//
//  CMAlerTableView.h
//  CMZC
//
//  Created by 财猫 on 16/4/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CMAlerTableViewStyle) {
    CMAlerTableViewStylebankCard,          //银行卡
    CMAlerTableViewStyleCoupon         // 优惠券
};

@class CMBankBlockList;
@protocol CMAlerTableViewDelegate <NSObject>

/**
 *  这里应该传出去一个类。暂时传出去一个数据
 *
 *  @param title 类
 */
- (void)cm_cmAlerViewCellTitle:(CMBankBlockList *)title;

@end

@interface CMAlerTableView : UIView

@property (nonatomic,assign)id<CMAlerTableViewDelegate>delegate;

@property (nonatomic,assign) CMAlerTableViewStyle type;

- (instancetype)initWithFrame:(CGRect)frame dataListClass:(NSArray *)dataClass delegate:(id)dlgt;

- (void)show;

@end
