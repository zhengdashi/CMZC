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
@property (weak, nonatomic) IBOutlet UILabel *littleTimeLab; //剩余时间
@property (weak, nonatomic) IBOutlet UIButton *liveBtn; //路演直播
@property (weak, nonatomic) IBOutlet UILabel *jyCodeLab;


@end


@implementation CMSubscribeTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
    
    _applyView.layer.masksToBounds = YES;
    _applyView.layer.cornerRadius = 5.0f;
}

- (void)setProduct:(CMPurchaseProduct *)product {
    _product = product;
    [_titPictureImage sd_setImageWithURL:[NSURL URLWithString:product.picture] placeholderImage:kCMDefault_imageName];
    _growthValueLab.attributedText = product.attributed;
    _positionLab.text = product.position;
    _descriptionLab.text = product.descri;
    _targetAmountLab.text = product.targetamount;
    _currentAmountLab.text = product.currentamount;
    _leadInvestorNameLab.text = product.leadinvestor;
    _titleLab.text = product.title;
    NSString * incomeString = [product.income substringToIndex:product.income.length-1];
    _incomeLab.text = incomeString;
    _openingDeadlineLab.text = [NSString stringWithFormat:@"%@",product.deadline];
    _applyLab.text = product.status;
   
    if (product.isNextPage) {
        //_applyLab.textColor = [UIColor whiteColor];
        if ([product.status isEqualToString:@"立即申购"]) {
            _applyView.backgroundColor = [UIColor cmThemeOrange];
        } else {
            _applyView.backgroundColor = [UIColor cmThemeCheng];
        }
        
    } else {
        _applyView.backgroundColor = [UIColor cmBackgroundGrey];
       // _applyLab.textColor = [UIColor cmBlockColor];
    }
    
    self.littleTimeLab.text = product.littleTime;
    if (product.liveVideoID > 0) {
        _liveBtn.hidden = NO;
    } else {
        _liveBtn.hidden = YES;
    }
    _jyCodeLab.text = [NSString stringWithFormat:@"(%@)",product.jyCode];
}
//直播
- (IBAction)liveLock:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_checkRoadshowLiveUrl:)]) {
        [self.delegate cm_checkRoadshowLiveUrl:_product.liveVideoUrl];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
