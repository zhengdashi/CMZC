//
//  CMServeReusableView.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMServeReusableView.h"

@implementation CMServeReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        _titleLab.textColor = [UIColor cmTacitlyFontColor];
        [self addSubview:_titleLab];
        
    }
    return self;
}
@end
