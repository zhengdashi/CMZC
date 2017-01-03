//
//  CMSubmittedWinView.m
//  CMZC
//
//  Created by 郑浩然 on 16/12/27.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubmittedWinView.h"
#import "CMFilletButton.h"

@interface CMSubmittedWinView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end


@implementation CMSubmittedWinView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 5.0f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)isOkBtnClick:(CMFilletButton *)sender {
    [self removeFromSuperview];
}

@end
