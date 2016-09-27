//
//  UIButton+CMButton.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "UIButton+CMButton.h"

@implementation UIButton (CMButton)

+ (UIButton *)cm_customBtnTitle:(NSString *)title {
    UIImage *image = [UIImage imageNamed:@"title_background"];
    UIImage *backgroundImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    UIButton *sortNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortNewButton setTitle:title forState:UIControlStateNormal];
    sortNewButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sortNewButton setTitleColor:[UIColor cmTacitlyFontColor] forState:UIControlStateNormal];
    [sortNewButton setTitleColor:[UIColor cmThemeOrange] forState:UIControlStateSelected];
    [sortNewButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    return sortNewButton;
}
//默认btn的bg
- (void)cm_setButtonAttr:(UIButton *)btn {
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//选中
- (void)cm_setButtonAttrWithClick:(UIButton *)btn {
    btn.backgroundColor = [UIColor cmTacitlyBtnColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)cm_setButtonRevealStyleImageName:(NSString *)image titleName:(NSString *)title {
    UIButton *button = (UIButton *)self;
    NSLog(@"---%@",NSStringFromCGRect(button.frame));
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 40, 20);
    //button.imageEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(68, -button.titleLabel.bounds.size.width-80, 0, 0);
}

@end
