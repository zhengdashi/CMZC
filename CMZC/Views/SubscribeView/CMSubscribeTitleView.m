//
//  CMSubscribeTitleView.m
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubscribeTitleView.h"

@implementation CMSubscribeTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/**
*  这里可以设置btn的tag值区分。但是，编码习惯。如果多的话会进行区分
*/
//新手指引
- (IBAction)newHandShowBtnClick:(UIButton *)sender {
    self.titleBlock(1000);
}
//赚钱秘籍
- (IBAction)makeMoneyBtnClick:(UIButton *)sender {
    self.titleBlock(1001);
}
//众筹实力
- (IBAction)powerBtnClick:(UIButton *)sender {
    self.titleBlock(1002);
}


@end
