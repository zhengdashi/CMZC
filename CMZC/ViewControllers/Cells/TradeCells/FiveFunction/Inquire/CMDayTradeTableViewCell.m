//
//  CMDayTradeTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  13803849395

#import "CMDayTradeTableViewCell.h"

@interface CMDayTradeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleName; //名字
@property (weak, nonatomic) IBOutlet UILabel *numberLab; //编号
@property (weak, nonatomic) IBOutlet UILabel *categoryLab; //买卖类别
@property (weak, nonatomic) IBOutlet UILabel *timeLab; //成交时间
@property (weak, nonatomic) IBOutlet UILabel *priceLab; //成交价格
@property (weak, nonatomic) IBOutlet UILabel *fractionLab; //成交份数

@end

@implementation CMDayTradeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTurnover:(CMTurnoverList *)turnover {
    _turnover = turnover;
    _titleName.text = turnover.pName;
    _numberLab.text = turnover.pCode;
    
    if (turnover.direction == 1) {
        _categoryLab.textColor = [UIColor greenColor];
        _categoryLab.text = @"卖出";
    } else {
        _categoryLab.textColor = [UIColor cmThemeOrange];
        _categoryLab.text = @"买入";
    }
    NSString *contractDate = [turnover.contractDate substringFromIndex:5];
    NSString *contractTime = [turnover.contractTime substringToIndex:5];
    
    _timeLab.text =  [NSString stringWithFormat:@"%@ %@",contractDate,contractTime];
    _priceLab.text = turnover.price;
    _fractionLab.text = turnover.volume;
    
}
- (void)cm_dayTradeTurnoverList:(CMTurnoverList *)turnover tradeTableType:(DayTradeTableType)type {
    _turnover = turnover;
    _titleName.text = turnover.pName;
    _numberLab.text = turnover.pCode;
    
    if (turnover.direction == 1) {
        _categoryLab.textColor = [UIColor cmThemeOrange];
        
        _categoryLab.text = @"买入";
    } else {
        _categoryLab.textColor = [UIColor cmFallColor];
        _categoryLab.text = @"卖出";
    }
    
    
    NSString *contractDate = [turnover.contractDate substringFromIndex:5];
    NSString *contractTime = [turnover.contractTime substringToIndex:5];
    
    _timeLab.text =  [NSString stringWithFormat:@"%@ %@",contractDate,contractTime];
    

    
    _priceLab.text = turnover.price;
    _fractionLab.text = turnover.volume;
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMDayTradeTableViewCell" owner:nil options:nil].firstObject;
}

@end
