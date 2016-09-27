//
//  CMMarketTitleView.m
//  CMZC
//
//  Created by 财猫 on 16/4/19.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMarketTitleView.h"
#import "CMProductType.h"

@interface CMMarketTitleView ()
@property (weak, nonatomic) IBOutlet UIButton *allBtn; //全部
@property (weak, nonatomic) IBOutlet UIButton *threeBtn; //新三板
@property (weak, nonatomic) IBOutlet UIButton *artBtn; //典藏艺术
@property (weak, nonatomic) IBOutlet UIButton *internetBtn; //互联网
@property (weak, nonatomic) IBOutlet UIView *marketView; //移动条view


@end


@implementation CMMarketTitleView

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
        CMMarketTitleView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMMarketTitleView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _marketView.frame = CGRectMake(0, CGRectGetHeight(_allBtn.frame)+3, CGRectGetWidth(_allBtn.frame), 2);
    }
    return self;
}
- (void)setTitleArr:(NSArray *)titleArr {
    
   _titleArr = titleArr;
    for (NSInteger i = 0; i <3; i++) {
        CMProductType *type = titleArr[i];
        if (i==0) {
            [_threeBtn setTitle:type.name forState:UIControlStateNormal];
        } else if (i == 1) {
            [_artBtn setTitle:type.name forState:UIControlStateNormal];
        } else {
            [_internetBtn setTitle:type.name forState:UIControlStateNormal];
        }
    }

}


- (IBAction)marketTitleBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _marketView.frame = CGRectMake(sender.frame.origin.x, sender.frame.size.height, sender.frame.size.width, 3);
    }];
    NSInteger senderTag = sender.tag;
    CMProductType *product;
    switch (senderTag) {
        case 801:
        {
            product = _titleArr[0];
        }
            break;
        case 802:
        {
            product = _titleArr[1];
        }
            break;
        case 803:
        {
            product = _titleArr[2];
        }
            break;
        case 800:
        {
            product = nil;
        }
        default:
            break;
    }
    NSInteger codeId;
    if (product == nil) {
        codeId = 1020;
    } else {
        codeId = [product.code integerValue];
    }
    
    self.marketBlock(codeId);
    
}

@end
