//
//  CMPointTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/19.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMPointTableViewCell.h"

@interface CMPointTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end


@implementation CMPointTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPoint:(CMAnalystPoint *)point {
    _titleLab.text = point.title;
    _contLab.text = point.content;
    _dateLab.text = point.created;
}


@end
