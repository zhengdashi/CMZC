//
//  CMAnswerHeaderView.m
//  CMZC
//
//  Created by 财猫 on 16/3/22.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAnswerHeaderView.h"
#import "CMRoundImage.h"

@interface CMAnswerHeaderView ()
@property (weak, nonatomic) IBOutlet CMRoundImage *titleImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//名字
@property (weak, nonatomic) IBOutlet UILabel *responseLab;//最近回答时间
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;//问题介绍
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;

@end


@implementation CMAnswerHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//回复
- (void)setIndex:(NSInteger)index {
    _index = index;
}

- (IBAction)replyBtnClick:(UIButton *)sender {
    //传一个问题的id 因为没数据。所以先不传
    if ([self.delegate respondsToSelector:@selector(cm_answerHeaderViewTopicId:indexPath:)]) {
        [self.delegate cm_answerHeaderViewTopicId:_analyst.topicid indexPath:_index];
    }
    
}

- (void)setAnalyst:(CMAnalystAnswer *)analyst {
    _analyst = analyst;
    [_titleImage sd_setImageWithURL:[NSURL URLWithString:analyst.useravatar] placeholderImage:kCMDefault_imageName];
    _responseLab.text = analyst.created;
    _introduceLab.text = analyst.content;
    
    _nameLab.text = analyst.username;
}


@end
