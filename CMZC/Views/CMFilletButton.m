//
//  CMFilletButton.m
//  CMZC
//
//  Created by 财猫 on 16/3/19.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMFilletButton.h"

@implementation CMFilletButton

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
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}
@end
