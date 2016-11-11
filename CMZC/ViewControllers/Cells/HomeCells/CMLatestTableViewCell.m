//
//  CMLatestTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/3.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMLatestTableViewCell.h"

@interface CMLatestTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation CMLatestTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNotice:(CMNoticeModel *)notice {
    [_titleImage sd_setImageWithURL:[NSURL URLWithString:notice.picture] placeholderImage:[UIImage imageNamed:@"title_log"]];
    
    _titleLab.text = notice.title;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
