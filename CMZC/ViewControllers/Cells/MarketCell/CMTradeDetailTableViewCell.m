//
//  CMTradeDetailTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeDetailTableViewCell.h"

@interface CMTradeDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLab;//左边
@property (weak, nonatomic) IBOutlet UILabel *centreLab;//中心
@property (weak, nonatomic) IBOutlet UILabel *rightLab;//右边

@end


@implementation CMTradeDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContDataArr:(NSArray *)contDataArr {
    _leftLab.text =@"--";
    _centreLab.text = @"--";
    _rightLab.text = @"--";
    
}
- (void)setContDataArr:(NSArray *)contDataArr openPrict:(float)prict {
    if (contDataArr.count !=0) {
        NSString *timeStr = contDataArr[0];
        if (timeStr.length >4) { //这个地方只需要显示时 分。不懂后台为什么要把秒返回。提过。没用
            timeStr = [timeStr substringWithRange:NSMakeRange(0, 5)];
        }
        _leftLab.text = timeStr;
        _centreLab.text = contDataArr[1];
        _rightLab.text = contDataArr[2];
        CGFloat conterFloat = [contDataArr[1] floatValue];
        //NSLog(@"----%f----%f",conterFloat,prict);
        if (conterFloat>prict) { //大于
            _centreLab.textColor = [UIColor cmUpColor];
        } else if (conterFloat<prict) { //小于
            _centreLab.textColor = [UIColor cmFallColor];
        } else { //等于
            _centreLab.textColor = [UIColor whiteColor];
        }
        
        NSString *dealStr = contDataArr[3];
        if ([dealStr isEqualToString:@"1"]) {
            _rightLab.textColor = [UIColor cmUpColor];
        } else {
            _rightLab.textColor = [UIColor cmFallColor];
        }
    } else {
        _leftLab.text =@"--";
        _centreLab.text = @"--";
        _rightLab.text = @"--";
    }
    

}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMTradeDetailTableViewCell" owner:nil options:nil].firstObject;
}


@end
