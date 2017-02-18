//
//  CMEditionTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMEditionTableViewCell.h"


@interface CMEditionTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *oneView;//一版view
@property (weak, nonatomic) IBOutlet UILabel *oneNameLab;//名字
@property (weak, nonatomic) IBOutlet UILabel *onePriceLab;//价格
@property (weak, nonatomic) IBOutlet UILabel *oneUpLab;//上涨价格
@property (weak, nonatomic) IBOutlet UILabel *oneUpPercentLab;//上涨%
@property (weak, nonatomic) IBOutlet UIView *twoView;//二版view
@property (weak, nonatomic) IBOutlet UILabel *twoNameLab;
@property (weak, nonatomic) IBOutlet UILabel *twoPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *twoUpLab;
@property (weak, nonatomic) IBOutlet UILabel *twoUpPercentLab;
@property (weak, nonatomic) IBOutlet UILabel *threeNameLab;//三版
@property (weak, nonatomic) IBOutlet UILabel *threePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *threeUpLab;
@property (weak, nonatomic) IBOutlet UILabel *threeUpPriceLab;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *whatLayoutConstraintLayout;




@end

@implementation CMEditionTableViewCell

- (void)awakeFromNib {
     
     [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)enterProductDetailsButClick:(UIButton *)sender {
    NSInteger senderTag = sender.tag;
    NSArray *itemArr;
    switch (senderTag) {
        case 1000:
        {
            itemArr = _prictArr.firstObject;
        }
            break;
        case 1001:
        {
            itemArr = _prictArr[1];
        }
            break;
        case 1002:
        {
            itemArr = _prictArr.lastObject;
        }
            break;
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(cm_editionTableViewProductId:nameTitle:)]) {
        [self.delegate cm_editionTableViewProductId:itemArr[0] nameTitle:itemArr[1]];
    }
}
- (void)setPrictArr:(NSArray *)prictArr {
    _prictArr = prictArr;
    //NSLog(@"--%@--",prictArr);
    if (prictArr.count == 0) {
        return;
    }
    if (prictArr.count == 1) {//一个产品
        self.whatLayoutConstraintLayout.constant =[UIScreen mainScreen].bounds.size.width-125;
        [self initFirstViewArr:prictArr.firstObject];
    } else if (prictArr.count == 2) { //两个产品
        self.whatLayoutConstraintLayout.constant = kCMScreen_width/2-125;
        [self initFirstViewArr:prictArr.firstObject];
        [self initTwoViewArr:prictArr[1]];
    } else { //三个产品
        [self initFirstViewArr:prictArr.firstObject];
        [self initTwoViewArr:prictArr[1]];
        [self initLastArr:prictArr.lastObject];
    }
    
    
    
    
   
}
//一个产品
- (void)initFirstViewArr:(NSArray *)firstArr {
    //第一个产品
    _oneNameLab.text = firstArr[1];
    _onePriceLab.text = firstArr[2];
    CGFloat upOrFall = [firstArr[3] floatValue];
    if (upOrFall == 0) { //不涨 不跌
        [self firstPricotColor:[UIColor cmBtnBGColor]];
    } else if (upOrFall >0) { //涨
        [self firstPricotColor:[UIColor cmUpColor]];
    } else { //跌
        [self firstPricotColor:[UIColor cmFallColor]];
    }
    _oneUpLab.text = firstArr[4] ;
    _oneUpPercentLab.text = [NSString stringWithFormat:@"%.2f%%",upOrFall];
}
- (void)initTwoViewArr:(NSArray *)twoArr {
    //第二个产品
    _twoNameLab.text = twoArr[1];
    _twoPriceLab.text = twoArr[2];
    CGFloat twoUpOrFall = [twoArr[3] floatValue];
    if (twoUpOrFall == 0) { //不涨 不跌
        [self twoFirstPricotColor:[UIColor cmBtnBGColor]];
    } else if (twoUpOrFall >0) { //涨
        [self twoFirstPricotColor:[UIColor cmUpColor]];
    } else { //跌
        [self twoFirstPricotColor:[UIColor cmFallColor]];
    }
    _twoUpLab.text = twoArr[4];
    _twoUpPercentLab.text = [NSString stringWithFormat:@"%.2f%%",twoUpOrFall];
}
- (void)initLastArr:(NSArray *)lastArr {
    //第三个产品
    _threeNameLab.text = lastArr[1];
    _threePriceLab.text = lastArr[2];
    CGFloat threeUpOrFall = [lastArr[3] floatValue];
    if (threeUpOrFall == 0) { //不涨 不跌
        [self threeFirstPricotColor:[UIColor cmBtnBGColor]];
    } else if (threeUpOrFall >0) { //涨
        [self threeFirstPricotColor:[UIColor cmUpColor]];
    } else { //跌
        [self threeFirstPricotColor:[UIColor cmFallColor]];
    }
    _threeUpLab.text = lastArr[4];
    _threeUpPriceLab.text = [NSString stringWithFormat:@"%.2f%%",threeUpOrFall] ;
//    if (prictArr.count <3) {
//        _threeView.hidden = YES;
//    } else {
//        _threeView.hidden = NO;
//    }
}

//第一个产品
- (void)firstPricotColor:(UIColor *)color {
    _onePriceLab.textColor = color;
    _oneNameLab.textColor = color;
    _oneUpLab.textColor = color;
    _oneUpPercentLab.textColor = color;
}
//第二个产品
- (void)twoFirstPricotColor:(UIColor *)color {
    _twoPriceLab.textColor = color;
    _twoNameLab.textColor = color;
    _twoUpLab.textColor = color;
    _twoUpPercentLab.textColor = color;
}
//第三个产品
- (void)threeFirstPricotColor:(UIColor *)color {
    _threeNameLab.textColor = color;
    _threePriceLab.textColor = color;
    _threeUpLab.textColor = color;
    _threeUpPriceLab.textColor = color;
}


@end



























