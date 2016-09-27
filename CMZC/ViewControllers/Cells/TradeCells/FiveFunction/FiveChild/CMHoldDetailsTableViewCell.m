//
//  CMHoldDetailsTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMHoldDetailsTableViewCell.h"

@interface CMHoldDetailsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *holdNameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *holdCodeLab; //编号
@property (weak, nonatomic) IBOutlet UILabel *holdGradesLab; // marketValue
@property (weak, nonatomic) IBOutlet UILabel *holdUsableGradesLab; //可用份数 equity
@property (weak, nonatomic) IBOutlet UILabel *holdDayMarketLab; //当前市值
@property (weak, nonatomic) IBOutlet UILabel *holdProfitLab; //盈亏
@property (weak, nonatomic) IBOutlet UILabel *holdCurrentPriceLab; //现价 price
@property (weak, nonatomic) IBOutlet UILabel *holdCostLab; //成本 costPrice



@end


@implementation CMHoldDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHold:(CMHoldInquire *)hold {
    _holdNameLab.text = hold.pName;
    _holdCodeLab.text = hold.pCode;
    _holdGradesLab.text = [self roundFloatDisplay:[hold.marketValue floatValue]];
    _holdUsableGradesLab.text = [NSString stringWithFormat:@"%@份",hold.equity];
    _holdDayMarketLab.text = hold.floatingProfitLoss;
    _holdProfitLab.text = [NSString stringWithFormat:@"%@%%",hold.proportionProfitLoss];
    _holdCostLab.text = hold.costPrice;
    _holdCurrentPriceLab.text = hold.price;
    
    CGFloat profit =[hold.proportionProfitLoss floatValue];
    if (profit < 0) { //跌
        [self holdAllLabColor:[UIColor cmFallColor]];
    } else if(profit == 0){ //不涨不跌
        [self holdAllLabColor:[UIColor cmTacitlyOneColor]];
    } else { //涨
        [self holdAllLabColor:[UIColor cmUpColor]];
    }
}

- (void)holdAllLabColor:(UIColor *)color {
    _holdNameLab.textColor = color;
    _holdCodeLab.textColor = color;
    _holdGradesLab.textColor = color;
    _holdUsableGradesLab.textColor = color;
    _holdDayMarketLab.textColor = color;
    _holdProfitLab.textColor = color;
    _holdCostLab.textColor = color;
    _holdCurrentPriceLab.textColor = color;
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



+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMHoldDetailsTableViewCell" owner:nil options:nil].firstObject;
}


@end





















