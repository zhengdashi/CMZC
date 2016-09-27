//
//  CMCarryDetailsTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/6/16.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CMCarryDetailsTableViewStyle) {
    CMCarryDetailsTableViewStylebankCard,          //银行卡
    CMCarryDetailsTableViewStyleCoupon         // 优惠券
};


@class CMBankBlockList;

@interface CMCarryDetailsTableViewCell : UITableViewCell

@property (nonatomic,assign) BOOL isSelect;

- (void)cm_alerViewTableViewNameStr:(CMBankBlockList *)bankBlock
                              style:(CMCarryDetailsTableViewStyle)style;

@end
