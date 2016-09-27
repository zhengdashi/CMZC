//
//  CMSaleCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSaleCollectionViewCell.h"
#import "CMTradeToolModes.h"
#import "CMAlerView.h"
#import "APNumberPad.h"


@interface CMSaleCollectionViewCell ()<UITextFieldDelegate,CMAlerViewDelegate,APNumberPadDelegate> {
    NSInteger priceIndex;//上一日收盘价格
    NSInteger _totalAssets; //总资产
    CGFloat _upPrice; //涨停
    CGFloat _fallPrice; //跌停
    NSInteger _buyNumberIndex; //卖出份数
}
@property (weak, nonatomic) IBOutlet UITextField *tradeTextField;//交易代码
@property (weak, nonatomic) IBOutlet UITextField *productTextField;//产品名称
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;//买入价格
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;//买入数量
@property (weak, nonatomic) IBOutlet UILabel *upPriceLab; //涨
@property (weak, nonatomic) IBOutlet UILabel *fallPriceLab; //跌





@end

@implementation CMSaleCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    _numberTextField.delegate = self;
    _tradeTextField.delegate = self;
    _priceTextField.delegate = self;
    _buyNumber.hidden = YES; //隐藏最大可买份数
    
    _priceTextField.inputView = ({
        APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self];
        
        [numberPad.leftFunctionButton setTitle:@"." forState:UIControlStateNormal];
        numberPad.leftFunctionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        numberPad;
        
    });
    
}
- (void)setCodeName:(NSString *)codeName {
    if (codeName != 0) {
        _tradeTextField.text = codeName;
        [self addRequestDataMeans];
    }
}

//买入
- (IBAction)saleBtnClick:(UIButton *)sender {
    [self endEditing:YES];
    if ([self checkDataValidity]) {
        CMTradeToolModes *tradeTool = [[CMTradeToolModes alloc] init];
        tradeTool.code = _tradeTextField.text;
        tradeTool.price = _priceTextField.text;
        tradeTool.name = _priceLab.text;
        tradeTool.number = _numberTextField.text;
        CMAlerView *aler = [[CMAlerView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height()) titleName:@"卖出委托" certain:@"确定卖出" delegate:self tradeTool:tradeTool];
        [aler show];
    }
    
}
//验证数据的有效性
- (BOOL)checkDataValidity {
    
    if (_tradeTextField.text.isBlankString) {
        [self showHubView:self messageStr:@"请输入交易代码" time:2];
        return NO;
    } else if (_priceTextField.text.isBlankString) {
        [self showHubView:self messageStr:@"请输入卖出价格" time:2];
        return NO;
    } else if (_numberTextField.text.isBlankString) {
        [self showHubView:self messageStr:@"请输入卖出数量" time:2];
        return NO;
    } else {
        return YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _numberTextField) {
        if (textField.text.length>1) {
            BOOL isPure = [_numberTextField.text isPureInt:_numberTextField.text];
            if (!isPure) {
                _numberTextField.text = @"";
                [self showHubView:self messageStr:@"请输入正确的买入数量" time:2];
                return;
            } else {
                if ([textField.text integerValue] == 0) {
                    _numberTextField.text = @"";
                    [self showHubView:self messageStr:@"卖出数量必须大于0" time:2];
                    return;
                } else {
                    if ([textField.text integerValue] > _buyNumberIndex) {
                        _numberTextField.text = @"";
                        [self showHubView:self messageStr:@"卖出份数不得大于持有份数" time:2];
                        return;
                    }
                }
            }
        }
    } else if (textField == _tradeTextField) {
        //加一个数据请求。算出价格。
        [self addRequestDataMeans];
        
    } else if (textField == _priceTextField) {
        if (textField.text.length >0) {
            if ([textField.text floatValue]<_fallPrice) {
                _priceTextField.text = @"";
                [self showHubView:self messageStr:@"卖出价格不得小于跌停价" time:2];
            } else if ([textField.text floatValue]>_upPrice){
                _priceTextField.text = @"";
                [self showHubView:self messageStr:@"卖出价格不得大于涨停价" time:2];
            }
        } else {
            [self showHubView:self messageStr:@"请输入买入价格" time:2];
        }
    } else if (textField == _numberTextField ) {
        
        
    }
}
//详情获取
- (void)addRequestDataMeans {
    [CMRequestAPI cm_tradeInquireFetchPrductPcode:_tradeTextField.text direction:@"2" success:^(NSArray *prductArr) {
        //_tradeTextField.text = @"";
        _priceLab.text = prductArr[0];
        priceIndex = [prductArr[1] integerValue];
        //_priceTextField.placeholder = [NSString stringWithFormat:@"卖出价格不得大于%ld",(long)priceIndex];
        _upPriceLab.hidden = NO;
        _fallPriceLab.hidden = NO;
        //涨
        _upPriceLab.text = [NSString stringWithFormat:@"涨停%@",prductArr[2]];
        _upPrice = [prductArr[2] floatValue];
        //跌
        _fallPriceLab.text = [NSString stringWithFormat:@"跌停%@",prductArr[3]];
        _fallPrice = [prductArr[3] floatValue];
        _priceTextField.text = prductArr[1];
        _buyNumber.hidden = NO;
        _buyNumber.text = [NSString stringWithFormat:@"最大可卖份数:%@",prductArr[4]];
        _buyNumberIndex = [prductArr[4] integerValue];
    } fail:^(NSError *error) {
        [self showHubView:self messageStr:error.message time:2];
    }];
}
- (void)cm_cmalerView:(CMAlerView *)alerView willDismissWithButtonIndex:(NSInteger)btnIndex {
    if (btnIndex == 1) {
        [CMRequestAPI cm_tradeInquireFetchSellPCode:_tradeTextField.text orderName:_priceLab.text  orderPrice:_priceTextField.text orderVolume:_numberTextField.text success:^(BOOL isWin) {
            if (isWin) {
                [self showHubView:self messageStr:@"委托卖出成功" time:2];
                if ([self.delegate respondsToSelector:@selector(cm_saleCollectionVC:)]) {
                    [self.delegate cm_saleCollectionVC:self];
                }
            } else {
                [self showHubView:self messageStr:@"委托卖出失败" time:2];
            }
        } fail:^(NSError *error) {
            [self showHubView:self messageStr:error.message time:2];
        }];
        
        _tradeTextField.text = @"";
        _priceTextField.text = @"";
        _productTextField.text = @"";
        _numberTextField.text = @"";
        _priceLab.text = @"";
        _upPriceLab.hidden = YES;
        _fallPriceLab.hidden = YES;
        _buyNumber.hidden = YES;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
- (void)calculateMaxBuyNumber {
    _buyNumber.hidden = NO;
    CGFloat price = [_priceTextField.text floatValue];
    NSInteger copies = _totalAssets / price;
    if (copies <= 0) {
        _buyNumber.text = [NSString stringWithFormat:@"最大可卖份数:0"];
    } else {
        _buyNumber.text = [NSString stringWithFormat:@"最大可卖份数:%ld",(long)copies];
    }
}

#pragma mark - APNumberPadDelegate
- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    if ([textInput isEqual:self.priceTextField]) {
        _priceTextField.text = [_priceTextField.text stringByAppendingString:@"."];
    }
}

@end


































