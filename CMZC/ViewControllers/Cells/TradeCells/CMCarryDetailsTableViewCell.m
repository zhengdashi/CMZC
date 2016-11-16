//
//  CMCarryDetailsTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/6/16.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMCarryDetailsTableViewCell.h"
#import "CMBankBlockList.h"



@interface CMCarryDetailsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab; //银行卡名字
@property (weak, nonatomic) IBOutlet UILabel *numberLab; //银行卡编号
@property (weak, nonatomic) IBOutlet UILabel *attestLab; //是否认证
@property (weak, nonatomic) IBOutlet UIImageView *selectImage; //是否选中

@end


@implementation CMCarryDetailsTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
//    @property (nonatomic,copy) NSString *amount; //优惠券的金额
//    @property (nonatomic,copy) NSString *validitydate; //优惠券失效时间
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)cm_alerViewTableViewNameStr:(CMBankBlockList *)bankBlock
                              style:(CMCarryDetailsTableViewStyle)style {
    if (style == CMCarryDetailsTableViewStylebankCard) { //银行卡
        _nameLab.text = bankBlock.banktype;
        NSInteger index = bankBlock.number.length -4;
        NSString *numberStr = [bankBlock.number substringFromIndex:index];
        _numberLab.text = numberStr;
        if (!bankBlock.authentication) {
            _attestLab.hidden = YES;
        } else {
            _attestLab.hidden = NO;
        }
        
    } else { //优惠券
        _nameLab.text = [NSString stringWithFormat:@"可抵用金额:%@元",bankBlock.amount];
        _numberLab.text = [NSString stringWithFormat:@"到期时间:%@",bankBlock.validitydate];
        _attestLab.hidden = YES;
    }
    
    
}

- (void)setIsSelect:(BOOL)isSelect {
    _selectImage.hidden = isSelect;
    
}


@end
