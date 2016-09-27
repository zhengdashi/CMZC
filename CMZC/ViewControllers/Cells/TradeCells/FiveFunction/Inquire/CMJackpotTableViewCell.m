//
//  CMJackpotTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMJackpotTableViewCell.h"
#import "CMWinning.h"

@interface CMJackpotTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//名字
@property (weak, nonatomic) IBOutlet UILabel *numberLab; //边贸
@property (weak, nonatomic) IBOutlet UILabel *moneyLab; //金额
@property (weak, nonatomic) IBOutlet UILabel *matchNumberLab; //配号
@property (weak, nonatomic) IBOutlet UILabel *winningAmountLab; //中间金额
@property (weak, nonatomic) IBOutlet UILabel *winningNumberLab; //中间数量


@end


@implementation CMJackpotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setWin:(CMWinning *)win {
    _nameLab.text = win.pName;
    _numberLab.text = win.jyCode;
    _moneyLab.text = win.jpamount;
    _winningAmountLab.text = win.jpamountForSucess;
    _winningNumberLab.text = win.zqNum;
    
    
    
}


@end
