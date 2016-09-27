//
//  CMAlerViewTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/6/15.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CMAlerViewTableStyle) {
    CMAlerViewTableStylebankCard,          //银行卡
    CMAlerViewTableStyleCoupon         // 优惠券
};


@interface CMAlerViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;

- (void)cm_alerViewTableViewNameStr:(NSString *)nameStr
                          numberStr:(NSString *)number
                              style:(CMAlerViewTableStyle)style;

+ (instancetype)cell;


@end
