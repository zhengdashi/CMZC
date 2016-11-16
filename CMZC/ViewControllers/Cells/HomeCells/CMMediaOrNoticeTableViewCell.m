//
//  CMMediaOrNoticeTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMediaOrNoticeTableViewCell.h"

@implementation CMMediaOrNoticeTableViewCell

- (void)awakeFromNib {
     
     [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setNotice:(CMNoticeModel *)notice {
    _notice = notice;
    _nameLab.text = notice.title;
    _dateLab.text = notice.created;
}


@end
