//
//  CMAlerViewTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/6/15.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAlerViewTableViewCell.h"


@interface CMAlerViewTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab; //银行卡名字
@property (weak, nonatomic) IBOutlet UILabel *numberLab;


@end


@implementation CMAlerViewTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
}

- (void)cm_alerViewTableViewNameStr:(NSString *)nameStr numberStr:(NSString *)number style:(CMAlerViewTableStyle)style {
    if (style == CMAlerViewTableStylebankCard) {
        _nameLab.text = nameStr;
        NSInteger index = number.length -4;
        NSString *numberStr = [number substringFromIndex:index];
        _numberLab.text = [NSString stringWithFormat:@"(%@)",numberStr];
    } else {
        _nameLab.text = [NSString stringWithFormat:@"优惠券可抵:%@元",nameStr];
        _numberLab.text = number;
    }
    
    
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMAlerViewTableViewCell" owner:nil options:nil].firstObject;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
