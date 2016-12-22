//
//  CMTitleView.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTitleView.h"


@interface CMTitleView ()


@end

@implementation CMTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        CMTitleView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMTitleView" owner:self options:nil].firstObject;
//        [self addSubview:cmMedia];
//        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
//        [self viewLayoutAllEdgesOfSubview:cmMedia];
//        _markView.frame = CGRectMake(0, CGRectGetHeight(_oneBtn.frame)+3, CGRectGetWidth(_oneBtn.frame), 3);
//        
//        
//    }
//    return self;
//}

- (IBAction)btnClickMethod:(UIButton *)sender {
    
    self.block(sender.tag,sender);
}

@end
