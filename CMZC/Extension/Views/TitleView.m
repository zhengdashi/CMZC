//
//  TitleView.m
//  Lecturer
//
//  Created by Qida on 14-3-27.
//  Copyright (c) 2014年 Qida. All rights reserved.
//

#import "TitleView.h"

#define kDefaultHairLineHeight 3

@interface TitleView ()

@property (nonatomic,strong) UIView *hairline;

@property (nonatomic,strong) UIButton *currentBtn;

@property (nonatomic,assign) float titleWidth;
@property (nonatomic,assign) float titleHeight;

@end

@implementation TitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleWidth = frame.size.width;
        self.titleHeight = frame.size.height;
        self.hairline = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight-kDefaultHairLineHeight, 0, kDefaultHairLineHeight)];
        //self.hairline.backgroundColor = [UIColor cmDividerColor];
        [self addSubview:self.hairline];
    }
    
    
    return self;
}

-(void)awakeFromNib
{
    self.titleWidth = [UIScreen mainScreen].bounds.size.width;
    self.titleHeight = self.frame.size.height;
    self.hairline = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight-kDefaultHairLineHeight, 0, kDefaultHairLineHeight)];
    self.hairline.backgroundColor = [UIColor cmThemeOrange];
    [self addSubview:self.hairline];
}

- (void)addTab:(UIButton *)tab
{
    //添加分割线
    if (self.subviews.count > 1) {
        UIImageView *separator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"title_separator.png"]];
        separator.frame = CGRectMake(0, 0, 2, self.titleHeight);
        [tab addSubview:separator];
    }else{
        self.currentBtn = tab;
        tab.selected = YES;
    }
    [tab addTarget:self action:@selector(clickTab:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tab];
    [self bringSubviewToFront:self.hairline];
    [self ajust];
}

- (void)addTabWithoutSeparator:(UIButton *)tab{
    if (self.subviews.count <= 1) {
        self.currentBtn = tab;
        tab.selected = YES;
    }
    [tab addTarget:self action:@selector(clickTab:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tab];
    [self bringSubviewToFront:self.hairline];
    [self ajust];
}

- (void)ajust
{
    NSInteger count = self.subviews.count - 1;
    float width = self.titleWidth/count;
    int x = 0;
    for (int i = 0; i < count; i++) {
        UIButton *view = self.subviews[i];
        if (view.isSelected) {
            x =i;
        }
        view.titleLabel.font = [UIFont systemFontOfSize:16];
        view.frame = CGRectMake(width*i, 0, width, self.titleHeight);
    }
    
    
    CGRect tempFrame = self.hairline.frame;
    tempFrame.size.width = width;
    tempFrame.origin.x = width*x;
    self.hairline.frame = tempFrame;
}

-(void)setFrame:(CGRect)frame
{
    if (self.frame.size.width != frame.size.width) {
        self.titleWidth = frame.size.width;
        self.titleHeight = frame.size.height;
        [self ajust];
    }
    [super setFrame:frame];
}


- (void)setHairlineColor:(UIColor *)color
{
    self.hairline.backgroundColor = color;
}

-(void)setSelectBtnIndex:(NSInteger)selectBtnIndex
{
    self.currentBtn.selected = NO;
    UIButton *btn = self.subviews[selectBtnIndex];
    btn.selected = YES;
    self.currentBtn = btn;
    btn.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.hairline.frame;
        frame.origin.x = frame.size.width *selectBtnIndex;
        self.hairline.frame = frame;
    }];
}

-(void)clickTab:(UIButton *)btn
{
    NSInteger index = [self.subviews indexOfObject:btn];
    [self setSelectBtnIndex:index];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTitleViewAtIndex:andTab:)]) {
        [self.delegate clickTitleViewAtIndex:index andTab:btn];
    }
}

- (void)setSelectTitleByIndex:(NSInteger)index andTitle:(NSString *)title
{
    UIButton *btn = self.subviews[index];
    [btn setTitle:title forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
