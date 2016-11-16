//
//  CMTradeTitleView.m
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeTitleView.h"

@interface CMTradeTitleView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//名字
@property (weak, nonatomic) IBOutlet UILabel *totalAssetsLab;//总资产
@property (weak, nonatomic) IBOutlet UILabel *marketLab;//市值
@property (weak, nonatomic) IBOutlet UILabel *usableFundLab;//可用金额
@property (weak, nonatomic) IBOutlet UILabel *profitLab;//总盈亏





@end


@implementation CMTradeTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    if (!CMIsLogin()) {
        _loginView.hidden = NO;
    }
}
//充值
- (IBAction)topUpBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_tradeViewControllerRecharge:)]) {
        [self.delegate cm_tradeViewControllerRecharge:self];
    }
    
}
//登录
- (IBAction)loginBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cm_tradeViewControllerLogin:)]) {
        [self.delegate cm_tradeViewControllerLogin:self];
    }
    
}

- (void)setTinfo:(CMAccountinfo *)tinfo {
    _tinfo = tinfo;
    if (tinfo != nil) {
        _loginView.hidden = YES;
        _nameLab.text = [CMAccountTool sharedCMAccountTool].currentAccount.userName;
        _totalAssetsLab.text = [NSString stringWithFormat:@"%.2f",tinfo.totalassets];
        _marketLab.text = [NSString stringWithFormat:@"%.2f",tinfo.totalmarketvalue];
        _usableFundLab.text = [NSString stringWithFormat:@"%.2f",tinfo.availableamount];
        _profitLab.text = [NSString stringWithFormat:@"%.2f",tinfo.totalprofit];
    } else {
        _loginView.hidden = NO;
    }
}

//提现
- (IBAction)withdrawDepositLab:(UIButton *)sender {
    //这里需要后台给字段判断是否银行卡认证过，如果认证过跳转到提现界面。如果没有认证过。天转到M站进行认证
    //这里没有数据，所以知己就当默认认证过
    if (_tinfo.bankcardisexists) {
        if ([self.delegate respondsToSelector:@selector(cm_tradeViewControllerType:)]) {
            [self.delegate cm_tradeViewControllerType:CMTradeTitleViewTypeCertification];//方便演示，先传入认证过的
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(cm_tradeViewControllerType:)]) {
            [self.delegate cm_tradeViewControllerType:CMTradeTitleViewTypeNotCertification];//方便演示，先传入认证过的
        }
    }
    
    
}

@end
