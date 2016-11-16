//
//  CMMessageTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/6/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMessageTableViewCell.h"

@interface CMMessageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end


@implementation CMMessageTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleNameStr:(NSString *)titleNameStr {
    _titleLab.text = titleNameStr;
}


@end
