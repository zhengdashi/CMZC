//
//  CMSubscribeDetailsView.m
//  CMZC
//
//  Created by 郑浩然 on 16/9/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubscribeDetailsView.h"
#import "CMProductDetails.h"
#import "CMProgressView.h"


@interface CMSubscribeDetailsView ()<UITextFieldDelegate> {
    NSInteger _copiesIndex; //份数
    NSInteger _variableNumber; //可变份数
}
@property (weak, nonatomic) IBOutlet UIImageView *titleImage; //标题图片
@property (weak, nonatomic) IBOutlet UILabel *titleName; //标题
@property (weak, nonatomic) IBOutlet UILabel *functionLab; //功能介绍
@property (weak, nonatomic) IBOutlet UILabel *earningsLab; //预计收益
@property (weak, nonatomic) IBOutlet UILabel *revenueLab; //收益类型
@property (weak, nonatomic) IBOutlet UILabel *limitLab; //期限
@property (weak, nonatomic) IBOutlet CMProgressView *progressView; //进度条
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab; //结束时间
@property (weak, nonatomic) IBOutlet UILabel *participateLab; //参与人数
@property (weak, nonatomic) IBOutlet UILabel *startLab; //起步价格
@property (weak, nonatomic) IBOutlet UILabel *copiesLab; //份数
@property (weak, nonatomic) IBOutlet UILabel *totalLab; //价钱
@property (weak, nonatomic) IBOutlet UITextField *copiesText; //份数输入
@property (weak, nonatomic) IBOutlet UIButton *purchaseStateBtn; //申购状态
@property (weak, nonatomic) IBOutlet UIView *bgView; //背景view

@end



@implementation CMSubscribeDetailsView


- (instancetype)init {
    self = [super init];
    if (self) {
        CMSubscribeDetailsView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMSubscribeDetailsView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _copiesText.delegate = self;
    }
    return self;
}

- (void)setProduct:(CMProductDetails *)product {
    _product = product;
    _copiesIndex = product.startquantity;
    _variableNumber = product.startquantity;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:product.picture] placeholderImage:[UIImage imageNamed:kCMDefault_imageName]];
    self.titleName.text = product.title;
    self.functionLab.text = product.descri;
    NSString *outNumber = [NSString stringWithFormat:@"%@",@(product.income.floatValue)];
    self.earningsLab.text = outNumber;
    self.revenueLab.text = product.incometype;
    self.limitLab.text = product.deadline;
    self.progressView.percent = 0.5;
    self.progressView.centerLabel.text = product.progress;
    self.progressView.backgroundColor = [UIColor whiteColor];
    self.endTimeLab.text = product.status;
    self.participateLab.text = [NSString stringWithFormat:@"参与人数%ld",product.soldcount];
    self.startLab.text = [NSString stringWithFormat:@"%ld元起",product.price];
    self.copiesLab.text = [NSString stringWithFormat:@"%ld",product.startquantity];
    self.totalLab.text = [NSString stringWithFormat:@"%ld",product.startquantity * 100];
    self.copiesText.text = [NSString stringWithFormat:@"%ld",product.startquantity];
    [self.purchaseStateBtn setTitle:product.status forState:UIControlStateNormal];
    if ([product.status isEqualToString:@"立即申购"]) {
        self.purchaseStateBtn.backgroundColor = [UIColor cmThemeOrange];
    } else {
        self.purchaseStateBtn.backgroundColor = [UIColor cmBackgroundGrey];
    }
}
//减少
- (IBAction)reduceBtnClick:(UIButton *)sender {
    _variableNumber --;
    if (_variableNumber < _copiesIndex) {
        return;
    } else {
        self.copiesLab.text = [NSString stringWithFormat:@"%ld",_variableNumber];
        self.totalLab.text = [NSString stringWithFormat:@"%ld",_variableNumber * 100];
        self.copiesText.text = [NSString stringWithFormat:@"%ld",_variableNumber];
    }
}
//增加
- (IBAction)increaseBtnClick:(UIButton *)sender {
    _variableNumber ++;
    self.copiesLab.text = [NSString stringWithFormat:@"%ld",_variableNumber];
    self.totalLab.text = [NSString stringWithFormat:@"%ld",_variableNumber * 100];
    self.copiesText.text = [NSString stringWithFormat:@"%ld",_variableNumber];
}
//立即申购
- (IBAction)purchaseDiatelyBtnClick:(UIButton *)sender {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}


@end























