//
//  CMAnalystTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAnalystTableViewCell.h"
#import "CMRoundImage.h"

@interface CMAnalystTableViewCell ()
@property (weak, nonatomic) IBOutlet CMRoundImage *titImage;//头像image
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//名字lab
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;//介绍lab
@property (weak, nonatomic) IBOutlet UILabel *pointNumberLab;//观点
@property (weak, nonatomic) IBOutlet UILabel *answerNumberLab;//回答
@property (weak, nonatomic) IBOutlet UILabel *hourNumberLab;//最近回答时间
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayoutConstraint;

@end

@implementation CMAnalystTableViewCell


- (void)awakeFromNib {
     [super awakeFromNib];
    [self.contentView layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setAnalyst:(CMAnalystMode *)analyst {
    _analyst = analyst;
    self.titImage.layer.masksToBounds = YES;
    self.titImage.layer.cornerRadius = self.titImage.width /2;
    //这个默认图片是因为没切图，所以先找一个代替。
    [_titImage sd_setImageWithURL:[NSURL URLWithString:analyst.avatar] placeholderImage:[UIImage imageNamed:@"title_log"]];
    _nameLab.text = analyst.name;
    _introduceLab.text = analyst.shortdescription;
    _pointNumberLab.text = CMStringWithFormat(analyst.topiccount);
    _answerNumberLab.text = CMStringWithFormat(analyst.replycount);
    
    _heightLayoutConstraint.constant = 0.5;
    _hourNumberLab.text = analyst.lastpublished;
}


@end
