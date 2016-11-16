//
//  CMMediaTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/4/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMediaTableViewCell.h"

@interface CMMediaTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@end

@implementation CMMediaTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
}
- (void)setMediaNews:(CMMediaNews *)mediaNews {
    _mediaNews = mediaNews;
    _nameLab.text = mediaNews.title;
    _dateLab.text = mediaNews.created;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
