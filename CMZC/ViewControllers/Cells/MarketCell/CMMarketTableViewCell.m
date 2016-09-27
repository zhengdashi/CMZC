//
//  CMMarketTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMarketTableViewCell.h"

@interface CMMarketTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab; //名称
@property (weak, nonatomic) IBOutlet UILabel *upandDownsLab; //涨跌幅lab
@property (weak, nonatomic) IBOutlet UILabel *serialLab; //标号
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintHeight;

@property (weak, nonatomic) IBOutlet UILabel *presentLab; //现价

@end

@implementation CMMarketTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _layoutConstraintHeight.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMarket:(CMMarketList *)market {
    
    _nameLab.text = market.PName;
    _serialLab.text = market.PCode;
    _upandDownsLab.text = market.range;
    
}
- (void)setDataListArr:(NSArray *)dataListArr {
    _serialLab.text = dataListArr[0];
    _nameLab.text = dataListArr[1];
    _presentLab.text = dataListArr[2];
    CGFloat uploat = [dataListArr[3] floatValue];
    
    if (uploat>0) { //涨
        [self presentLabTextColor:[UIColor cmUpColor]
                     upandLabText:[NSString stringWithFormat:@"%.2f%%",uploat]];
    } else if (uploat == 0) { //不涨不跌
        [self presentLabTextColor:[UIColor whiteColor]
                     upandLabText:@"0.00%"];
        
    } else { //跌
        [self presentLabTextColor:[UIColor cmFallColor]
                     upandLabText:[NSString stringWithFormat:@"%.2f%%",uploat]];
    }
    
}
- (void)presentLabTextColor:(UIColor *)color upandLabText:(NSString *)upStr {
    _upandDownsLab.textColor = color;
    _presentLab.textColor = color;
    _upandDownsLab.text = upStr;
    
    
}


@end
