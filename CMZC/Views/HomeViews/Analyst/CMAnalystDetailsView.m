//
//  CMAnalystDetailsView.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kAnimatoinDurtion 0.3

#import "CMAnalystDetailsView.h"

#import "CMRoundImage.h"

@interface CMAnalystDetailsView (){
    BOOL    _isOpt;//折返按钮
}
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;//介绍lab
@property (weak, nonatomic) IBOutlet UILabel *answerTimeLab; //最近一次回答时间
@property (weak, nonatomic) IBOutlet UILabel *nameLab; //名字lab
@property (weak, nonatomic) IBOutlet CMRoundImage *titImageView; //头像


@end


@implementation CMAnalystDetailsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CMAnalystDetailsView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMAnalystDetailsView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        self.backgroundColor = [UIColor clearColor];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _isOpt = NO;
    }
    return self;
}

- (void)setAnalyst:(CMAnalystMode *)analyst {
    _analyst = analyst;
    _nameLab.text = analyst.name;
    [_titImageView sd_setImageWithURL:[NSURL URLWithString:analyst.avatar] placeholderImage:[UIImage imageNamed:kCMDefaultHeadPortrait]];
    _answerTimeLab.text = [NSString stringWithFormat:@"最近回答时间:%@",analyst.lastpublished];
    _introduceLab.text = analyst.fulldescription;
}


- (IBAction)stretchBtnClick:(UIButton *)sender {
    CGFloat intrHeight = [_analyst.fulldescription getHeightIncomingWidth:CMScreen_width()-20 incomingFont:14]-34;
    if (!_isOpt) {
        [UIView animateWithDuration:kAnimatoinDurtion animations:^{
            _introduceLab.numberOfLines = 0;
            //_titleViewHeightLayoutConstraint.constant = intrHeight;
        }];
    } else {
        [UIView animateWithDuration:kAnimatoinDurtion animations:^{
            _introduceLab.numberOfLines = 2;
            //_titleViewHeightLayoutConstraint.constant = _titleViewHeightLayoutConstraint.constant - intrHeight;
        }];
    }
    
    _isOpt =! _isOpt;
    self.analystBlock(_isOpt,intrHeight);
    
}
@end
