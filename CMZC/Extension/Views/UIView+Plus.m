//
//  UIView+Plus.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "UIView+Plus.h"

@implementation UIView (Plus)

//根据ib获得view
+ (instancetype)initByNibForClassName {
    NSString *nibName = NSStringFromClass([self class]);
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
}

//显示view
- (void)showMeToView:(UIView*)view{
    if (view) {
        [view addSubview:self];
    }
}

//删除view
- (void)removeMeFromView:(UIView*)view{
    if (view && self) {
        [self removeFromSuperview];
    }
}
//得到x轴
- (CGFloat)x{
    return self.frame.origin.x;
}
//得到y轴
- (CGFloat)y{
    return self.frame.origin.y;
}
//自定义x轴
- (void)setX:(CGFloat)x{
    [self setFrame:CGRectMake(x, self.y, self.width, self.height)];
}
//自定义y轴
- (void)setY:(CGFloat)y{
    [self setFrame:CGRectMake(self.x, y, self.width, self.height)];
}
//得到view的宽
- (CGFloat)width{
    return self.frame.size.width;
}
//得到viw的高
- (CGFloat)height{
    return self.frame.size.height;
}
//自定义宽
- (void)setWidth:(CGFloat)width{
    [self setFrame:CGRectMake(self.x, self.y, width, self.height)];
}
//自定义高
- (void)setHeight:(CGFloat)height{
    [self setFrame:CGRectMake(self.x, self.y, self.width, height)];
}

- (CGFloat)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}
//调整布局
- (void)viewLayoutAllEdgesOfSubview:(UIView *)subView {
    [self cmViewPinSubview:subView toEdge:NSLayoutAttributeBottom];
    [self cmViewPinSubview:subView toEdge:NSLayoutAttributeTop];
    [self cmViewPinSubview:subView toEdge:NSLayoutAttributeLeading];
    [self cmViewPinSubview:subView toEdge:NSLayoutAttributeTrailing];
}
- (void)cmViewPinSubview:(UIView *)subView toEdge:(NSLayoutAttribute)attribute {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:attribute
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:subView
                                                     attribute:attribute
                                                    multiplier:1.0f
                                                      constant:0.0]];
}
//获得屏幕的宽度
CGFloat CMScreen_width() {
    return [UIScreen mainScreen].bounds.size.width;
}
//获得屏幕的宽度
CGFloat CMScreen_height() {
    return [UIScreen mainScreen].bounds.size.height;
}


@end
