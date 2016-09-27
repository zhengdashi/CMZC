//
//  CMBuyingTitleView.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMBuyingTitleView.h"

@interface CMBuyingTitleView ()
@property (weak, nonatomic) IBOutlet UIButton *buyingBtn;

@end


@implementation CMBuyingTitleView

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
        CMBuyingTitleView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMBuyingTitleView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        
    }
    return self;
}



- (IBAction)functionBtnClick:(UIButton *)sender {
    [sender setTitleColor:[UIColor cmThemeOrange] forState:UIControlStateSelected];
}

@end
