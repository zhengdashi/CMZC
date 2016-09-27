//
//  CMAnswerTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/19.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAnswerTableViewCell.h"

@interface CMAnswerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;//回复内容
@property (weak, nonatomic) IBOutlet UILabel *nameLab; //回复人

@end

@implementation CMAnswerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPoint:(CMAnalystViewpoint *)point {
    _nameLab.text = point.username;
    _contentLab.text = [NSString stringWithFormat:@":%@",point.content];
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMAnswerTableViewCell" owner:nil options:nil].firstObject;
}

@end
