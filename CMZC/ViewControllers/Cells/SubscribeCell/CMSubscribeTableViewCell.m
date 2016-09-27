//
//  CMSubscribeTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubscribeTableViewCell.h"

#import "CMProductList.h"
#import "CMPurchaseProduct.h"

@interface CMSubscribeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titPictureImage; //图片
@property (weak, nonatomic) IBOutlet UILabel *growthValueLab; //成长值
@property (weak, nonatomic) IBOutlet UILabel *positionLab; //位置
@property (weak, nonatomic) IBOutlet UILabel *titleLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *descriptionLab; //产品描述
@property (weak, nonatomic) IBOutlet UILabel *targetAmountLab; //众筹金额
@property (weak, nonatomic) IBOutlet UILabel *currentAmountLab; //已申购金额
@property (weak, nonatomic) IBOutlet UILabel *leadInvestorNameLab; //领头人
@property (weak, nonatomic) IBOutlet UILabel *incomeLab; //预期收益
@property (weak, nonatomic) IBOutlet UILabel *openingDeadlineLab; //期限年份
@property (weak, nonatomic) IBOutlet UIView *applyView; //背景
@property (weak, nonatomic) IBOutlet UILabel *applyLab;


@end


@implementation CMSubscribeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _applyView.layer.masksToBounds = YES;
    _applyView.layer.cornerRadius = 5.0f;
}

- (void)setProduct:(CMPurchaseProduct *)product {
    [_titPictureImage sd_setImageWithURL:[NSURL URLWithString:product.picture] placeholderImage:[UIImage imageNamed:kCMDefault_imageName]];
    _growthValueLab.attributedText = product.attributed;
    _positionLab.text = product.position;
    _descriptionLab.text = product.descri;
    _targetAmountLab.text = product.targetamount;
    _currentAmountLab.text = product.currentamount;
    _leadInvestorNameLab.text = product.leadinvestor;
    _titleLab.text = product.title;
    NSString * incomeString = [product.income substringToIndex:product.income.length-1];
    _incomeLab.text = incomeString;
    _openingDeadlineLab.text = [NSString stringWithFormat:@"期限%@",product.deadline];
    _applyLab.text = product.status;
   
    if (product.isNextPage) {
        _applyView.backgroundColor = [UIColor cmThemeOrange];
    } else {
        _applyView.backgroundColor = [UIColor cmBackgroundGrey];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
