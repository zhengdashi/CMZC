//
//  CMBuyingCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMBuyingCollectionViewCell.h"
#import "CMAlerView.h"
#import "CMTradeToolModes.h"
#import "APNumberPad.h"


@interface CMBuyingCollectionViewCell ()<UITextFieldDelegate,CMAlerViewDelegate,APNumberPadDelegate> {
    NSInteger priceIndex;//上一日收盘价格
    NSInteger _totalAssets; //总资产
    CGFloat _upPrice; //涨停
    CGFloat _fallPrice; //跌停
    NSInteger _copiesIndex; //最大可买份数
    
}
@property (weak, nonatomic) IBOutlet UITextField *tradeTextField;//交易代码
@property (weak, nonatomic) IBOutlet UITextField *productTextField;//产品名称
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;//买入价格
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;//买入数量
@property (weak, nonatomic) IBOutlet UILabel *productLab; //产品名称
@property (weak, nonatomic) IBOutlet UILabel *buyNumber; //最大可买份数
@property (weak, nonatomic) IBOutlet UILabel *upPriceLab; //涨停价
@property (weak, nonatomic) IBOutlet UILabel *fallPriceLab; //跌停价

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titCodeTopLabLayoutConstraint;



@end

@implementation CMBuyingCollectionViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
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
- (IBAction)buyingBtnClick:(UIButton *)sender {
    [self endEditing:YES];
    _titCodeTopLabLayoutConstraint.constant = 20;
    if ([self checkDataValidity]) {
        _buyNumber.hidden = YES;
        if ([self calculateThePrice]) {
            CMTradeToolModes *tradeTool = [[CMTradeToolModes alloc] init];
            tradeTool.code = _tradeTextField.text;
            tradeTool.price = _priceTextField.text;
            tradeTool.name = _productLab.text;
            tradeTool.number = _numberTextField.text;
            
            CMAlerView *aler = [[CMAlerView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height()) titleName:@"买入委托" certain:@"确定买入" delegate:self tradeTool:tradeTool];
            [aler show];
        }
    }
    
}
//计算价格
- (BOOL)calculateThePrice {
    NSInteger price = [_priceTextField.text integerValue] * [_numberTextField.text integerValue];
    
    if (price > _totalAssets) {
        [self showHubView:self messageStr:@"买入总价格不得大于可用金额" time:3];
        return NO;
    } else {
        return YES;
    }
    
}

//验证数据的有效性
- (BOOL)checkDataValidity {
    if (_tradeTextField.text.isBlankString) {
        [self showHubView:self messageStr:@"请输入交易代码" time:2];
        return NO;
    } else if (_priceTextField.text.isBlankString) {
        [self showHubView:self messageStr:@"请输入买入价格" time:2];
        return NO;
    } else if (_numberTextField.text.isBlankString) {
        [self showHubView:self messageStr:@"请输入买入数量" time:2];
        return NO;
    } else {
        return YES;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
    _titCodeTopLabLayoutConstraint.constant = 20;
}
#pragma mark -  UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (iPhone5) {
        if (textField == _numberTextField) {
            _titCodeTopLabLayoutConstraint.constant = 0;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _tradeTextField) {
        if (textField.text.length >0) {
            //加一个数据请求。算出价格。
            [self addRequestDataMeans];
        }
    } else if (textField == _priceTextField) {
        if (textField.text.length >0) {
            if ([textField.text floatValue]<_fallPrice) {
                _priceTextField.text = @"";
                [self showHubView:self messageStr:@"买入价格不得小于跌停价" time:2];
            } else if ([textField.text floatValue]>_upPrice){
                _priceTextField.text = @"";
                [self showHubView:self messageStr:@"买入价格不得大于涨停价" time:2];
            } else {
                [self calculateMaxBuyNumber];
            }
        } else {
             [self showHubView:self messageStr:@"请输入买入价格" time:2];
        }
        
    } else if (textField == _numberTextField) {
        [self calculateMaxBuyNumber];
        BOOL isPure = [_numberTextField.text isPureInt:_numberTextField.text];
        if (!isPure) {
            _numberTextField.text = @"";
            [self showHubView:self messageStr:@"请输入正确的买入数量" time:2];
            return;
        } else {
            if ([_numberTextField.text integerValue] == 0) {
                _numberTextField.text = @"";
                [self showHubView:self messageStr:@"买入数量必须大于0" time:2];
                return;
            } else if ([_numberTextField.text integerValue] >_copiesIndex ) {
                _numberTextField.text = @"";
                [self showHubView:self messageStr:@"买入数量不可大于最大可买数" time:2];
                return;
            }
        }
    }
}
//详情获取
- (void)addRequestDataMeans {
    [CMRequestAPI cm_tradeInquireFetchPrductPcode:_tradeTextField.text direction:@"1" success:^(NSArray *prductArr) {
        //_tradeTextField.text = @"";
        _productLab.text = prductArr[0];
        priceIndex = [prductArr[1] integerValue];
        //_priceTextField.placeholder = [NSString stringWithFormat:@"买入价格不得小于%ld",priceIndex];
        _upPriceLab.hidden = NO;
        _fallPriceLab.hidden = NO;
        //涨停
        _upPriceLab.text = [NSString stringWithFormat:@"涨停%@",prductArr[2]];
        _upPrice = [prductArr[2] floatValue];
        //跌停
        _fallPriceLab.text = [NSString stringWithFormat:@"跌停%@",prductArr[3]];
        _fallPrice = [prductArr[3] floatValue];
        _priceTextField.text = prductArr[1];
        _totalAssets = [prductArr[4] integerValue];
        //计算出最大可买份数
        [self calculateMaxBuyNumber];
    } fail:^(NSError *error) {
        [self showHubView:self messageStr:@"请输入正确的产品编码" time:2];
    }];
}
//计算出最大可买份数
- (void)calculateMaxBuyNumber {
    _buyNumber.hidden = NO;
    CGFloat price = [_priceTextField.text floatValue];
    NSInteger copies = _totalAssets / price;
    _copiesIndex = copies;
    if (copies <= 0) {
        _buyNumber.text = [NSString stringWithFormat:@"最大可买份数:0"];
    } else {
        _buyNumber.text = [NSString stringWithFormat:@"最大可买份数:%ld",(long)copies];
    }
    
}

#pragma mark - CMAlerViewDelegate
- (void)cm_cmalerView:(CMAlerView *)alerView willDismissWithButtonIndex:(NSInteger)btnIndex {
    if (btnIndex == 1) {
        [CMRequestAPI cm_tradeInquireFetchBuyingPCode:_tradeTextField.text
                                           orderPrice:_priceTextField.text
                                          orderVolume:_numberTextField.text
                                            orderName:_productLab.text
                                              success:^(BOOL isWin) {
                                                  
                                                  if (isWin) {
                                                      [self showHubView:self messageStr:@"委托买入成功" time:2];
                                                      if ([self.delegate respondsToSelector:@selector(cm_buyingCollectionView:)]) {
                                                          [self.delegate cm_buyingCollectionView:self];
                                                      }
                                                  } else {
                                                      [self showHubView:self messageStr:@"委托买入失败" time:2];
                                                  }
                                                  
                                              }
                                                 fail:^(NSError *error) {
                                                     [self showHubView:self messageStr:error.message time:2];
                                                 }];
    }
    _tradeTextField.text = @"";
    _priceTextField.text = @"";
    _productTextField.text = @"";
    _numberTextField.text = @"";
    _productLab.text = @"";
    _upPriceLab.hidden = YES;
    _fallPriceLab.hidden = YES;
    //[alerView removeFromSuperview];
    
}
#pragma mark - APNumberPadDelegate 
- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    if ([textInput isEqual:self.priceTextField]) {
        _priceTextField.text = [_priceTextField.text stringByAppendingString:@"."];
    }
}


@end


























