//
//  CMNewCommentTableViewCell.m
//  CMZC
//
//  Created by 郑浩然 on 16/11/30.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMNewCommentTableViewCell.h"
#import "CMAnalystPoint.h"
#import "CMProductNotion.h"

@interface CMNewCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab; //标题
@property (weak, nonatomic) IBOutlet UILabel *contentLab;//内容
@property (weak, nonatomic) IBOutlet UILabel *timeDataLab;//时间
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTopLayoutConstranint;

@end


@implementation CMNewCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//评论
- (void)setAnalystPoint:(CMAnalystPoint *)analystPoint {
    _contentLab.text = @"";
    _timeDataLab.text = @"";
    _titleNameLab.text = @"";
    _titleNameLab.hidden = NO;
    _contentLab.hidden = NO;
    _timeDataLab.hidden = NO;
    _contentLab.text = analystPoint.content;
    _timeDataLab.text = analystPoint.created;
    _titleNameLab.text = analystPoint.title;
}

//公告
- (void)setProductNotion:(CMProductNotion *)productNotion {
    _contentLab.text = @"";
    _timeDataLab.text = @"";
    _titleNameLab.hidden = YES;
    _contentLab.hidden = NO;
    _timeDataLab.hidden = NO;
    _contentTopLayoutConstranint.constant = -13;
    _contentLab.text = productNotion.title;
    _timeDataLab.text = productNotion.created;
}

//企业详情
- (void)setIntroduceStr:(NSString *)introduceStr {
    _titleNameLab.hidden = YES;
    _timeDataLab.hidden = YES;
    _contentTopLayoutConstranint.constant = -13;
    _contentLab.text = introduceStr;
}


@end










































