//
//  CMProductDetailsTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMProductDetailsTableViewCell.h"

@interface CMProductDetailsTableViewCell () {
    NSInteger _optionIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *dataLab; //当前价格
@property (weak, nonatomic) IBOutlet UILabel *earlyLab; //开盘lab
@property (weak, nonatomic) IBOutlet UILabel *heighlyLab; //最高
@property (weak, nonatomic) IBOutlet UILabel *droopLab; //最低
@property (weak, nonatomic) IBOutlet UILabel *turnoverLab; //成交量
@property (weak, nonatomic) IBOutlet UILabel *turnoverLimitLab; //成交额
@property (weak, nonatomic) IBOutlet UILabel *upOrFall; //是涨是跌
@property (weak, nonatomic) IBOutlet UILabel *scopeLab; //涨跌额度

@property (weak, nonatomic) IBOutlet UILabel *optionalLab; //自选but
@property (weak, nonatomic) IBOutlet UIButton *optionalBtn; //自选lab


@end


@implementation CMProductDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProductArr:(NSArray *)productArr {
    //MyLog(@"%@",productArr);
    if (productArr.count==0) {
        return;
    }
    NSArray *dataProductArr = productArr.firstObject;
    
    _earlyLab.text = [NSString stringWithFormat:@"%.2f",[dataProductArr[2] floatValue]]; //开盘
    NSString *heighly = [NSString stringWithFormat:@"%.2f", [dataProductArr[4] floatValue]];
    
    if ([heighly isEqualToString:@"0.00"]) {
        _heighlyLab.text = @"--"; //开盘
    } else {
        _heighlyLab.text = heighly; //最高价
    }
    NSString *droopStr = [NSString stringWithFormat:@"%.2f", [dataProductArr[5] floatValue]];
    if ([droopStr isEqualToString:@"0.00"]) {
        _droopLab.text = @"--"; //最低
    } else {
        _droopLab.text = droopStr;
    }
    
    CGFloat earlyFloat = [dataProductArr[2] floatValue];//开盘价
    CGFloat droopFloat = [dataProductArr[5] floatValue];//最低价
    CGFloat heiglyFloat = [dataProductArr[4] floatValue];//最高价
    
    _turnoverLab.text = [NSString stringWithFormat:@"%.f", [dataProductArr[7] floatValue]];//成交量
    
    CGFloat turnoverFloat = [dataProductArr[8] floatValue];
    
    _turnoverLimitLab.text = [self roundFloatDisplay:turnoverFloat]; //成交额
    CGFloat upFloat = [dataProductArr[3] floatValue];
    if (upFloat>earlyFloat) { //大于开盘价
        _dataLab.textColor = [UIColor cmUpColor];
    } else if (upFloat<earlyFloat) { //小于开盘价
        _dataLab.textColor = [UIColor cmFallColor];
    } else { //等于开盘价
        _dataLab.textColor = [UIColor cmDividerColor];
    }
    
    
    _dataLab.text = [NSString stringWithFormat:@"%.2f", [dataProductArr[3] floatValue]]; //当前价格
    
    
    CGFloat upOrFall = [dataProductArr[6] floatValue];
    if (upOrFall == 0) { //不涨不跌
        [self detailsLabTextColor:[UIColor cmFontWiteColor]];
    } else if (upOrFall >0) { //涨
        [self detailsLabTextColor:[UIColor cmUpColor]];
    } else { //跌
        [self detailsLabTextColor:[UIColor cmFallColor]];
    }
    _scopeLab.text = [NSString stringWithFormat:@"%.2f%%",upOrFall];//涨跌幅
    
    _optionIndex = [dataProductArr[10] integerValue];
    if (_optionIndex == 0) {
        [_optionalBtn setBackgroundImage:[UIImage imageNamed:@"add_option_home"] forState:UIControlStateNormal];
        _optionalLab.text = @"自选";
    } else {
        [_optionalBtn setBackgroundImage:[UIImage imageNamed:@"delete_option_trade"] forState:UIControlStateNormal];
        _optionalLab.text = @"删除自选";
    }
    
    
    if (droopFloat < earlyFloat) { //低于开盘价
        if (droopFloat == 0) {
            _droopLab.textColor = [UIColor whiteColor];
        } else {
            _droopLab.textColor = [UIColor cmFallColor];
        }
    } else if (droopFloat == earlyFloat) {
        _droopLab.textColor = [UIColor whiteColor];
    } else { //开盘价
        _droopLab.textColor = [UIColor cmUpColor];
    }
    
    if (heiglyFloat < earlyFloat) {
        if (heiglyFloat == 0) {
            _heighlyLab.textColor = [UIColor whiteColor];
        } else {
            _heighlyLab.textColor = [UIColor cmFallColor];
        }
    } else if (heiglyFloat == earlyFloat) {
        _heighlyLab.textColor = [UIColor whiteColor];
    } else {
        _heighlyLab.textColor = [UIColor cmUpColor];
    }
    
}

- (void)setProductCode:(NSString *)productCode {
    _productCode = productCode;
}

- (void)detailsLabTextColor:(UIColor *)color {
    
    //_earlyLab.textColor = color;
   // _dataLab.textColor = color;
    //_droopLab.textColor = color;
    _scopeLab.textColor = color;
    //_heighlyLab.textColor = color;
    
}

- (IBAction)optionalBtnClick:(UIButton *)sender {
    if (!CMIsLogin()) {
        if ([self.delegate respondsToSelector:@selector(cm_productDetailsViewCell:)]) {
            [self.delegate cm_productDetailsViewCell:self];
        }
        return;
    } else {
        if (_optionIndex == 0) {
            if ([self.delegate respondsToSelector:@selector(cm_productOptionType:)]) {
                [self.delegate cm_productOptionType:CMProductOptionTypeAddOption ];//添加自选
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(cm_productOptionType:)]) {
                [self.delegate cm_productOptionType:CMProductOptionTypeDeleteOption];//删除自选
            }
        }
    }
    
    
    
    
}
/**
 *  格式化float，显示单位，保留2位小数
 *
 *  @return 格式化后的字符串
 */
- (NSString *)roundFloatDisplay:(CGFloat)value{
    
    NSString *unit = @"";
    if (value > 10000) {
        value /= 10000.0;
        unit = @"万";
    } else if (value > 1000000) {
        value /= 1000000.0;
        unit = @"百万";
    }
    
    if ([unit isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%.2f",value];
    }
    return [NSString stringWithFormat:@"%.2f%@",value,unit];
}




@end










































