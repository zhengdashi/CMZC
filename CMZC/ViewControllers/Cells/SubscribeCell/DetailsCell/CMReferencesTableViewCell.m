//
//  CMReferencesTableViewCell.m
//  CMZC
//
//  Created by 郑浩然 on 16/10/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//


#import "CMReferencesTableViewCell.h"
#import "TitleView.h"
#import "CMInvestorsView.h"


@interface CMReferencesTableViewCell () <TitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *curTitleView;

@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;
@property (strong, nonatomic) TitleView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *pictImage; //产品图片

@property (weak, nonatomic) IBOutlet CMInvestorsView *investorsView;//投资人

@end


@implementation CMReferencesTableViewCell

- (void)awakeFromNib {
     
     [super awakeFromNib];
    
    
    
}

- (void)setScrollViewContentIndex:(NSInteger)scrollViewContentIndex {
    if (scrollViewContentIndex == 0) {
        _investorsView.hidden = YES;
        _pictImage.hidden = NO;
    } else {
        _investorsView.hidden = NO;
        _pictImage.hidden = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
