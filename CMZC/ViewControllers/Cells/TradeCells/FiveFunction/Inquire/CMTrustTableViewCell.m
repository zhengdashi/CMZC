//
//  CMTrustTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/4/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTrustTableViewCell.h"

@interface CMTrustTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *contentLab; //内容

@end

@implementation CMTrustTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)cm_tradeDetailsTitleName:(NSString *)name detailsName:(NSString *)details index:(NSInteger)index {
    if (index == 3) {
        _contentLab.textColor = [UIColor cmThemeOrange];
    } else {
        _contentLab.textColor = [UIColor cmTacitlyFontColor];
    }
    _titleNameLab.text = name;
    _contentLab.text = details;
}


@end
