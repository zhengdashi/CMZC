//
//  CMRemoveTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/6/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMRemoveTableViewCell.h"
#import "CMMayRemove.h"


@interface CMRemoveTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *codeLab; //编号
@property (weak, nonatomic) IBOutlet UILabel *buyingLab; //买卖类别
@property (weak, nonatomic) IBOutlet UILabel *stateLab; //委托状态
@property (weak, nonatomic) IBOutlet UILabel *priceLab; //委托价格
@property (weak, nonatomic) IBOutlet UILabel *copiesLab; //份数


@end


@implementation CMRemoveTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
     
}

- (void)setRemove:(CMMayRemove *)remove {
    _titleNameLab.text = remove.pName;
    _codeLab.text = remove.pCode;
    _stateLab.text = remove.condition;
    _buyingLab.text = remove.selldire;
    if (remove.direction==1) {
        _buyingLab.textColor = [UIColor cmUpColor];
    } else {
        _buyingLab.textColor = [UIColor cmFallColor];
    }
    
    _priceLab.text = remove.orderPrice;
    _copiesLab.text = remove.orderVolume;
    
}
+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMRemoveTableViewCell" owner:nil options:nil].firstObject;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
