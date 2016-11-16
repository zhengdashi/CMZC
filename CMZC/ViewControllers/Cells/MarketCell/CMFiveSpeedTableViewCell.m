//
//  CMFiveSpeedTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/4/19.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMFiveSpeedTableViewCell.h"

@interface CMFiveSpeedTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *oneLab; //买卖lab
@property (weak, nonatomic) IBOutlet UILabel *twoLab; //买卖
@property (weak, nonatomic) IBOutlet UILabel *threeLab; //报价
@property (strong, nonatomic) NSArray *contArr;

@end

@implementation CMFiveSpeedTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cm_fiveSpeedIndex:(NSInteger)index contentArr:(NSArray *)arr{
    _contArr = arr;
    if (index<5) {
        _oneLab.text = [NSString stringWithFormat:@"卖%ld",(long)10-(index+5)];
        _twoLab.textColor = [UIColor whiteColor];
        [self sellTitleStr:arr index:index];
    } else {
        _oneLab.text = [NSString stringWithFormat:@"买%ld",(long)1+ (index-5)];
        _twoLab.textColor = [UIColor cmUpColor];
        [self buyTitleStr:arr index:index];
    }
    
    
}
//改变颜色color
- (void)changeColor:(UIColor *)color {
    _twoLab.textColor = color;
    _threeLab.textColor = color;
}
//比较大小
- (void)compareSize:(NSString *)size {
    CGFloat dayOpen = [size floatValue];
    CGFloat riseOrFall = [_contArr[3] floatValue];
    if (riseOrFall >dayOpen) { //涨
        if ([size isEqualToString:@"0.00"]) {
            [self changeColor:[UIColor whiteColor]];
        } else {
            [self changeColor:[UIColor cmFallColor]];
        }
    } else if (riseOrFall < dayOpen) { //跌
        
        [self changeColor:[UIColor cmUpColor]];
    } else { //跌
        [self changeColor:[UIColor whiteColor]];
    }
}

//卖
- (void)sellTitleStr:(NSArray *)arr index:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSString *buyStr = arr[30];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                 _twoLab.text = buyStr;
            }
           
            _threeLab.text = arr[31];
            [self compareSize:buyStr];
        }
            break;
        case 1:
        {
            NSString *buyStr = arr[28];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[29];
            [self compareSize:buyStr];
        }
            break;
        case 2:
        {
            NSString *buyStr = arr[26];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[27];
            [self compareSize:buyStr];
        }
            break;
        case 3:
        {
            NSString *buyStr = arr[24];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[25];
            [self compareSize:buyStr];
        }
            break;
        case 4:
        {
            NSString *buyStr = arr[22];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[23];
            [self compareSize:buyStr];
        }
            break;
        default:
            break;
    }
}
//买
- (void)buyTitleStr:(NSArray *)arr index:(NSInteger)index {
    switch (index) {
        case 5:
        {
            NSString *buyStr = arr[12];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[13];
            [self compareSize:buyStr];
        }
            break;
        case 6:
        {
            NSString *buyStr = arr[14];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[15];
            [self compareSize:buyStr];
        }
            break;
        case 7:
        {
            NSString *buyStr = arr[16];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[17];
            [self compareSize:buyStr];
        }
            break;
        case 8:
        {
            NSString *buyStr = arr[18];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[19];
            [self compareSize:buyStr];
        }
            break;
        case 9:
        {
            NSString *buyStr = arr[20];
            if ([buyStr isEqualToString:@"0.00"]) {
                _twoLab.text = @"- -";
            } else {
                _twoLab.text = buyStr;
            }
            _threeLab.text = arr[21];
            [self compareSize:buyStr];
        }
            break;
        default:
            break;
    }
}


+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMFiveSpeedTableViewCell" owner:nil options:nil].firstObject;
}
@end





























