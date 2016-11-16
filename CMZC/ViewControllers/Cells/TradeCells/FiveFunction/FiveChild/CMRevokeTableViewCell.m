//
//  CMRevokeTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMRevokeTableViewCell.h"
#import "CMMayRemove.h"


@interface CMRevokeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *numberLab; //编号
@property (weak, nonatomic) IBOutlet UILabel *categoryLab; //买卖类别
@property (weak, nonatomic) IBOutlet UILabel *stateLab; //委托状态
@property (weak, nonatomic) IBOutlet UILabel *priceLab;  //价格lab
@property (weak, nonatomic) IBOutlet UILabel *fractionLab;  //份数
@property (weak, nonatomic) IBOutlet UILabel *dateLab; //时间


@end

@implementation CMRevokeTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAuthorize:(CMTradeDayAuthorize *)authorize {
    
    _authorize = authorize;
    _titleNameLab.text = authorize.pName;
    _numberLab.text = authorize.pCode;
    _stateLab.text = authorize.condition;
    _priceLab.text = authorize.orderPrice;
    _categoryLab.text = authorize.selldirection;
    if (authorize.direction == 1) {
        _categoryLab.textColor = [UIColor cmUpColor];
    } else {
        _categoryLab.textColor = [UIColor cmFallColor];
    }
    
    _fractionLab.text = authorize.orderVolume;
    NSString *orderDate = [authorize.orderDate substringFromIndex:5];
    NSString *orderTime = [authorize.orderTime substringToIndex:5];
    _dateLab.text = [NSString stringWithFormat:@"%@ %@",orderDate,orderTime]; //字段内容改了也没人说。还是提供bug才知道。
     
    /*
    NSLog(@"%@",[authorize.orderTime substringWithRange:NSMakeRange(3, 2)]);
    _dateLab.text = [NSString stringWithFormat:@"%@:%@:%@",[authorize.orderTime substringWithRange:NSMakeRange(0, 2)],[authorize.orderTime substringWithRange:NSMakeRange(3, 2)],[authorize.orderTime substringWithRange:NSMakeRange(4, 2)]];
    MyLog(@"-PName :%@,-PCode: %@, condition :%@, - OrderPrice :%@",authorize.pName,authorize.pCode,authorize.condition,authorize.orderPrice);
     */
}


+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMRevokeTableViewCell" owner:nil options:nil].firstObject;
}

@end
