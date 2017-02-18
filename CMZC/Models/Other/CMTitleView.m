//
//  CMTitleView.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTitleView.h"


@interface CMTitleView () {
    CGFloat _titBtnX;
}

@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;
@property (strong, nonatomic) NSArray *titleNameArr;


@end

@implementation CMTitleView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titBtnX = 0;
    
    for (NSInteger i = 0; i<self.titleNameArr.count; i++) {
        CGRect rect = [self.titleNameArr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        CGFloat with = rect.size.width;
        UIButton *titBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        titBtn.frame = CGRectMake(_titBtnX, 0, with, 37);
        titBtn.tag = i;
        [titBtn setTitle:self.titleNameArr[i] forState:UIControlStateNormal];
        if (i== 7) {
            [titBtn addTarget:self action:@selector(btnXiangClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [titBtn addTarget:self action:@selector(btnClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        }
        [_curScrollView addSubview:titBtn];
        _titBtnX = CGRectGetMaxX(titBtn.frame)+8;
    }
    _curScrollView.contentSize = CGSizeMake(_titBtnX, 30);
    _markView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, 80, 3)];
    _markView.backgroundColor = [UIColor cmThemeOrange];
    [_curScrollView addSubview:_markView];
}

- (NSArray *)titleNameArr {
    if (!_titleNameArr) {
        _titleNameArr = @[@"分析师诊断",@"行情吧",@"信息披露",@"公司概况",@"产品与市场",@"财务指标",@"团队与股权",@"产品信息"];
    }
    return _titleNameArr;
}



- (void)btnClickMethod:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _markView.frame = CGRectMake(CGRectGetMinX(sender.frame), CGRectGetHeight(sender.frame), CGRectGetWidth(sender.frame), 3);
    }];
    self.block(sender.tag,sender);
}
- (void)btnXiangClickMethod:(UIButton *)sender {
    self.block(sender.tag,sender);
}


@end
