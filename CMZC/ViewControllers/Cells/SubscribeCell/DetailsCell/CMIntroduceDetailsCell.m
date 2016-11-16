//
//  CMIntroduceDetailsCell.m
//  CMZC
//
//  Created by 郑浩然 on 16/10/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMIntroduceDetailsCell.h"
#import "TitleView.h"
#import "CMProductDetails.h"

@interface CMIntroduceDetailsCell () <TitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *curTitleView;
@property (strong, nonatomic) TitleView *titleView;

@end


@implementation CMIntroduceDetailsCell

- (void)awakeFromNib {
     
     [super awakeFromNib];
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 40)];
    //回答
    UIButton *sortNewButton = [UIButton cm_customBtnTitle:@"产品介绍"];
    //观点
    UIButton *sortHotButton = [UIButton cm_customBtnTitle:@"最新投资人"];
    [self.titleView addTabWithoutSeparator:sortNewButton];
    [self.titleView addTabWithoutSeparator:sortHotButton];
    self.titleView.delegate = self;
    [self.curTitleView addSubview:_titleView];
}
- (void)clickTitleViewAtIndex:(NSInteger)index andTab:(UIButton *)tab; {
    if ([self.delegate respondsToSelector:@selector(cm_toggleDisplayContentIndex:)]) {
        [self.delegate cm_toggleDisplayContentIndex:index];
    }
}

- (void)setProductDetails:(CMProductDetails *)productDetails {
    _productDetails = productDetails;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
