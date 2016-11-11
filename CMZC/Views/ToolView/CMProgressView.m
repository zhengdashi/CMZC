//
//  CMProgressView.m
//  CMZC
//
//  Created by 郑浩然 on 16/9/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kWidth_fram self.frame.size.width
#define kHeight_fram self.frame.size.height

#import "CMProgressView.h"

@implementation CMProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        [self initData];
    }
    return self;
}

- (instancetype)init
{
    if([super init])
    {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if([super initWithCoder:aDecoder])
    {
        [self initData];
    }
    return self;
}

/** 初始化数据*/
- (void)initData
{
    self.progressWidth = 3.0;
    self.progressColor = [UIColor redColor];
    self.progressBackgroundColor = [UIColor grayColor];
    self.percent = 0.0;
    
    self.labelbackgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
    self.textFont = [UIFont systemFontOfSize:15];
}

- (void)layoutSubviews
{
    [super addSubview:self.centerLabel];
    self.centerLabel.backgroundColor = self.labelbackgroundColor;
    self.centerLabel.textColor = self.textColor;
    self.centerLabel.font = self.textFont;
    [self addSubview:self.centerLabel];
}

#pragma mark -- 画进度条

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias(context, YES);
    CGContextAddArc(context, kWidth_fram/2, kHeight_fram/2, (kWidth_fram-self.progressWidth)/2, 0, M_PI*2, 0);
    [self.progressBackgroundColor setStroke];
    CGContextSetLineWidth(context, self.progressWidth);
    CGContextStrokePath(context);
    
    if(self.percent)
    {
        CGFloat angle = 2 * self.percent * M_PI - M_PI_2;
        
        CGContextAddArc(context, kWidth_fram/2, kHeight_fram/2, (kWidth_fram-self.progressWidth)/2, -M_PI_2, angle, 0);
        
        [self.progressColor setStroke];
        CGContextSetLineWidth(context, self.progressWidth);
        CGContextStrokePath(context);
    }
}

- (void)setPercent:(float)percent
{
    if(self.percent < 0) return;
    _percent = percent;
    
    [self setNeedsDisplay];
}

- (UILabel *)centerLabel
{
    if(!_centerLabel)
    {
        _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth_fram, kHeight_fram/2)];
        _centerLabel.center = CGPointMake(kWidth_fram/2, kHeight_fram/2);
        _centerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLabel;
}


@end
