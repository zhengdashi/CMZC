//
//  CMOptionalTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMOptionalTableViewCell.h"

@interface CMOptionalTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *codeLab; //编码
@property (weak, nonatomic) IBOutlet UILabel *priceLab; //现价
@property (weak, nonatomic) IBOutlet UILabel *upOreFallLab; //涨跌幅


@end


@implementation CMOptionalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOptionalArr:(NSArray *)optionalArr {
    _optionalArr = optionalArr;
    _codeLab.text = optionalArr[0];
    _nameLab.text = optionalArr[1];
    _priceLab.text = optionalArr[2];
    CGFloat upFloat = [optionalArr[3] floatValue];
    
    if (upFloat >0) { //涨
        [self upOreFallLabTextColor:[UIColor cmUpColor]
                         upFallText:[NSString stringWithFormat:@"%.2f%%",upFloat]];
    } else if (upFloat == 0) { //不涨不跌
        [self upOreFallLabTextColor:[UIColor whiteColor]
                         upFallText:[NSString stringWithFormat:@"0.00%%"]];
    } else { //跌
        [self upOreFallLabTextColor:[UIColor cmFallColor]
                         upFallText:[NSString stringWithFormat:@"%.2f%%",upFloat]];
    }
    
    
}
- (void)upOreFallLabTextColor:(UIColor *)color upFallText:(NSString *)text {
    _priceLab.textColor = color;
    _upOreFallLab.textColor = color;
    _upOreFallLab.text = text;
}


@end
























