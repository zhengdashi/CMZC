//
//  CMServerPromptView.m
//  CMZC
//
//  Created by 郑浩然 on 16/12/27.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMServerPromptView.h"

@interface CMServerPromptView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *devImageHeightLayout; //标记图片高度
@property (weak, nonatomic) IBOutlet UIImageView *derImageView; //标示

@end



@implementation CMServerPromptView

- (void)awakeFromNib {
    [super awakeFromNib];
    if (iPhone7) {
        _devImageHeightLayout.constant = 473.0f;
    }
}

- (void)setImageNameStr:(NSString *)imageNameStr {
    _derImageView.image = [UIImage imageNamed:imageNameStr];
}

//退出
- (IBAction)exitBtnClick:(UIButton *)sender {
    [self removeView];
}
//挂牌
- (IBAction)listedBtnClick:(UIButton *)sender {
    self.typeBlock();
    [self removeView];
}
 //打电话
- (IBAction)makePhoneBtnClick:(UIButton *)sender {
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"4009993972"];
    UIWebView *telWeb = [[UIWebView alloc] init];
    [telWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:telWeb];
}

- (void)removeView{
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
