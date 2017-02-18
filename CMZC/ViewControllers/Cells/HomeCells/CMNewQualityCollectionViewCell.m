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
@property (weak, nonatomic) IBOutlet UILabel *startingLab; //起价
@property (weak, nonatomic) IBOutlet UILabel *earningsLab; //收益
@property (weak, nonatomic) IBOutlet UILabel *decimalPointLab; //收益浮动
@property (weak, nonatomic) IBOutlet UILabel *netWorthLab; //净值lab
@property (weak, nonatomic) IBOutlet UILabel *attendPersionLab; //参与人数

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
    _attendPersionLab.text = CMStringWithPickFormat(number.attendPersionCount, @"人");
    
    //NSArray *priceArr = [number.price componentsSeparatedByString:@"."];
    _priceLab.text = number.price;
    if ([number.price isEqualToString:@"100"]) {
        _netWorthLab.hidden = YES;
    } else {
        _netWorthLab.hidden = NO;
    }
   // NSLog(@"---%@",priceArr.firstObject);
//    if (priceArr.count > 1) {
//        _netWorthLab.text = [NSString stringWithFormat:@".%.0f%%",[priceArr.lastObject floatValue]];
//    }
    NSArray *lisArr = [number.floatingprofitloss componentsSeparatedByString:@"."];
    _makeLab.text = lisArr.firstObject;
    if (lisArr.count > 1) {
        NSString *lastStr = lisArr.lastObject;
        if (lastStr.length > 2) {
            lastStr = [lastStr substringToIndex:2];
            _decimalPointLab.text = [NSString stringWithFormat:@".%@",lastStr];
        } else {
            _decimalPointLab.text = [NSString stringWithFormat:@".%.0f%%",[lisArr.lastObject floatValue]];
            
        }
    }
    
    
    _redeemLab.attributedText = [NSMutableAttributedString cm_mutableAttributedString:[NSString stringWithFormat:@"%@个月可赎回",number.redemptionperiod]
                                                                            valueFont:10
                                                                           valueColor:[UIColor cmThemeOrange]
                                                                             locRange:0
                                                                             lenRange:number.redemptionperiod.length];
    _earningsLab.text = number.incometype; //收益类型
    _startingLab.text = number.price;
    _bgImageView.image = [UIImage imageNamed:bgImage];
    _worthLab.text = [NSString stringWithFormat:@"%.0f",[number.price floatValue]];
    _upOrFallLab.text = [NSString stringWithFormat:@"%.2f%%",[number.floatingprofitloss floatValue]];
   
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





























