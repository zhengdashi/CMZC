//
//  CMNewQualityCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMNewQualityCollectionViewCell.h"
#import "NSMutableAttributedString+AttributedString.h"


@interface CMNewQualityCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *qualityNameLab;//名字
@property (weak, nonatomic) IBOutlet UILabel *makeLab; //获利lab
@property (weak, nonatomic) IBOutlet UILabel *redeemLab; //赎回
@property (weak, nonatomic) IBOutlet UILabel *priceLab; //价格lab
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLab; //介绍
@property (weak, nonatomic) IBOutlet UILabel *upOrFallLab; //涨跌

@property (weak, nonatomic) IBOutlet UILabel *worthLab; //净值

@end

@implementation CMNewQualityCollectionViewCell

- (void)setDataArray:(NSArray *)dataArray {
    //_dataArray = dataArray;
    _redeemLab.attributedText = [NSMutableAttributedString cm_mutableAttributedString:@"6个月可赎回"
                                                                            valueFont:10
                                                                           valueColor:[UIColor cmThemeOrange]
                                                                             locRange:0
                                                                             lenRange:1];
    
}

- (void)cm_newQualityCellClass:(CMNumberous *)number bgImageArr:(NSString *)bgImage {
    _descriptionLab.text = number.descri;
    _qualityNameLab.text = number.title;
    _makeLab.text = [NSString stringWithFormat:@"%.0f",[number.income floatValue]];
    _priceLab.text = [NSString stringWithFormat:@"%.0f元起",[number.floatingprofitloss floatValue]];
    _redeemLab.attributedText = [NSMutableAttributedString cm_mutableAttributedString:[NSString stringWithFormat:@"%@个月可赎回",number.redemptionperiod]
                                                                            valueFont:10
                                                                           valueColor:[UIColor cmThemeOrange]
                                                                             locRange:0
                                                                             lenRange:number.redemptionperiod.length];
    _bgImageView.image = [UIImage imageNamed:bgImage];
    _worthLab.text = [NSString stringWithFormat:@"%.0f",[number.price floatValue]];
    _upOrFallLab.text = [NSString stringWithFormat:@"%.2f%%",[number.income floatValue]];
    CGFloat fallFloat = [number.income floatValue];
    if (fallFloat == 0) {
        _upOrFallLab.textColor = [UIColor cmFontWiteColor];
    } else if (fallFloat >0 ){//涨
        _upOrFallLab.textColor = [UIColor cmUpColor];
        _upOrFallLab.text = [NSString stringWithFormat:@"+%.2f%%",[number.income floatValue]];
    } else {
        _upOrFallLab.textColor = [UIColor cmFallColor];
    }
    
}

@end





























