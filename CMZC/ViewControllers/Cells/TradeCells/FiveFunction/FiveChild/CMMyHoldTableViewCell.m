//
//  CMMyHoldTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMyHoldTableViewCell.h"

@interface CMMyHoldTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *totalLab; //总资产
@property (weak, nonatomic) IBOutlet UILabel *marketValueLab; //总市值
@property (weak, nonatomic) IBOutlet UILabel *lossLab; //盈亏
@property (weak, nonatomic) IBOutlet UILabel *canTakeLab; //可取
@property (weak, nonatomic) IBOutlet UILabel *canUseLab; //可用


@end


@implementation CMMyHoldTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
     
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTinfo:(CMAccountinfo *)tinfo {
    _totalLab.text = [NSString stringWithFormat:@"%.2f",tinfo.totalassets];
    _marketValueLab.text = [NSString stringWithFormat:@"%.2f",tinfo.totalmarketvalue];
    _lossLab.text = [NSString stringWithFormat:@"%.2f",tinfo.totalprofit];
    _canTakeLab.text = [NSString stringWithFormat:@"%.2f",tinfo.desirableamount];
    _canUseLab.text = [NSString stringWithFormat:@"%.2f",tinfo.availableamount];
}
//充值
- (IBAction)rechargeBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_holdTableView:)]) {
        [self.delegate cm_holdTableView:self];
    }
    
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMMyHoldTableViewCell" owner:nil options:nil].firstObject;
}

@end
