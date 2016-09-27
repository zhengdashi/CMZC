//
//  CLMNotDataView.m
//  UIErrorView
//
//  Created by Zheng on 16/1/7.
//  Copyright © 2016年 zhr. All rights reserved.
//

float const width_settingImage     = 200.0;
float const height_settingImage    = 100.0;

float const width_promptLab        = 200.0;
float const height_promptLab       = 35.0;
float const spacing_image_lab      = 20;//间距

float const width_skipBut          = 160;
float const height_skipBut         = 60;
float const spacing_lab_but         = 100;//间距


#import "CLMNotDataView.h"

@interface CLMNotDataView ()
//图片
@property (strong, nonatomic) UIImageView *settingImage;
//提示lab
@property (strong, nonatomic) UILabel *promptLab;

@end

@implementation CLMNotDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       // self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self getter];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rectSettImg = CGRectZero;
    rectSettImg.size = CGSizeMake(width_settingImage, height_settingImage);
    rectSettImg.origin.x = (self.frame.size.width - width_settingImage)/2;
    rectSettImg.origin.y = 0;
    self.settingImage.frame = rectSettImg;
    
    
    CGRect rectProLab = CGRectZero;
    rectProLab.size = CGSizeMake(width_promptLab, height_promptLab);
    rectProLab.origin.x = (self.frame.size.width - width_promptLab)/2;
    rectProLab.origin.y = rectSettImg.origin.y + rectSettImg.size.height + spacing_image_lab;
    self.promptLab.frame = rectProLab;
    
    /*
    CGRect rectSkipBut = CGRectZero;
    rectSkipBut.size = CGSizeMake(width_skipBut, height_skipBut);
    rectSkipBut.origin.x = (self.frame.size.width - width_skipBut)/2;
    rectSkipBut.origin.y = rectProLab.origin.y + rectProLab.size.height + spacing_lab_but;
    self.skipBut.frame = rectSkipBut;
    self.skipBut.layer.cornerRadius = 20;
    */
}
- (void)getter{
    //背景图片
    [self settingImage];
    //提示语句
    [self promptLab];
    //点击按钮
   // [self skipBut];
    
}

- (UIImageView *)settingImage{
    if (!_settingImage) {
        _settingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageNameStr]];
        _settingImage.contentMode = UIViewContentModeScaleAspectFit;
        //_settingImage.backgroundColor = [UIColor redColor];
        _settingImage.layer.masksToBounds = YES;
        if (![_settingImage superview]) {
            [self addSubview:_settingImage];
        }
    }
    return _settingImage;
}

- (UILabel *)promptLab {
    if (!_promptLab) {
        _promptLab = [[UILabel alloc] init];
        _promptLab.textAlignment = NSTextAlignmentCenter;
        _promptLab.textColor = [UIColor cmTacitlyFontColor];
        if (![_promptLab superview]) {
            [self addSubview:_promptLab];
        }
    }
    return _promptLab;
}
- (UIButton *)skipBut {
    if (!_skipBut) {
        _skipBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipBut addTarget:self action:@selector(skipViewControllerClick) forControlEvents:UIControlEventTouchUpInside];
        _skipBut.layer.masksToBounds = YES;
        if (![_skipBut superview]) {
            [self addSubview:_skipBut];
        }
        _skipBut.backgroundColor = [UIColor yellowColor];
    }
    return _skipBut;
}
//按钮的方法
- (void)skipViewControllerClick {
    if ([self.delegate respondsToSelector:@selector(notDataViewDidClicked)]) {
        [self.delegate notDataViewDidClicked];
    }
    
}
- (void)imageViewImageName:(NSString *)imageName markedWordsStr:(NSString *)wordsStr optionImageStr:(NSString *)optionstr{
    _settingImage.image = [UIImage imageNamed:imageName];
    _promptLab.text = wordsStr;
    [_skipBut setImage:[UIImage imageNamed:_optionStr] forState:UIControlStateNormal];
}

- (void)dismiss {
    [self removeFromSuperview];
}
@end




















