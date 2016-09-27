//
//  CMErrorView.m
//  CMZC
//
//  Created by 财猫 on 16/5/16.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMErrorView.h"

@implementation CMErrorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame bgImageName:(NSString *)imageName {
    self = [super initWithFrame:frame];
    if (self) {
        [self getImageView:imageName];
        self.backgroundColor = [UIColor cmBlockColor];
    }
    return self;
}
- (void)getImageView:(NSString *)imageName {
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(CMScreen_width()/2-50, 100, 100, 60)];
    image.image = [UIImage imageNamed:imageName];
    [self addSubview:image];
    
}
- (void)removeView {
    [self removeFromSuperview];
    
}
@end
