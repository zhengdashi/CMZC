//
//  CMReplyTableViewCell.m
//  CMZC
//
//  Created by 郑浩然 on 17/1/7.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMReplyTableViewCell.h"
#import "CMAnalystPoint.h"


@interface CMReplyTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView; //头像图片
@property (weak, nonatomic) IBOutlet UILabel *nameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *contentLab; //内容
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *lockMoreBtn; //更多btn
//只有一个回复
@property (weak, nonatomic) IBOutlet UIView *replyView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage; //图片头像
@property (weak, nonatomic) IBOutlet UILabel *replyOnlNameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *replyOnlContLab; //内容
@property (weak, nonatomic) IBOutlet UILabel *replyOnlTimeLab; //回复时间
//有两个回复
@property (weak, nonatomic) IBOutlet UIView *replyTwoView;
@property (weak, nonatomic) IBOutlet UIImageView *replyTwoTitleImage; //图片
@property (weak, nonatomic) IBOutlet UILabel *twoNameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *twoTimeLab; // 时间
@property (weak, nonatomic) IBOutlet UILabel *twoContentLab; //内容

@end


@implementation CMReplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopicList:(CMTopicList *)topicList {
    _topicList = topicList;
    if (topicList.repliesArr.count == 0) {
        _replyView.hidden = YES;
        _replyTwoView.hidden = YES;
        _lockMoreBtn.hidden = YES;
    } else if (topicList.repliesArr.count == 1) {
        _replyTwoView.hidden = YES;
        _replyView.hidden = NO;
        _lockMoreBtn.hidden = YES;
        [self replyIntContent];
        
    } else {
        _replyTwoView.hidden = NO;
        _replyView.hidden = NO;
        //_lockMoreBtn.hidden = NO;
        [self replyIntContent];
        CMTopicReplies *Replies = _topicList.repliesArr.lastObject ;
        [_replyTwoTitleImage sd_setImageWithURL:[NSURL URLWithString:Replies.userphoto] placeholderImage:kCMDefault_imageName];
        if (Replies.username.length > 0) {
            _twoNameLab.text = Replies.username;
        } else {
          _twoNameLab.text = @"会员";
        }
        _replyOnlContLab.text = Replies.content;
        _twoTimeLab.text = Replies.formatdate;
    }
    
    [_titleImageView sd_setImageWithURL:[NSURL URLWithString:topicList.userphoto] placeholderImage:kCMDefault_imageName];
    if (topicList.username.length > 0) {
        _nameLab.text = topicList.username;
    } else {
        _nameLab.text = @"会员";
    }
    
    _contentLab.text = topicList.content;
    _timeLab.text = topicList.formatdate;
}

- (void)setTopicReplies:(CMTopicReplies *)topicReplies {
    _replyView.hidden = YES;
    _replyTwoView.hidden = YES;
    _lockMoreBtn.hidden = YES;
    [_titleImageView sd_setImageWithURL:[NSURL URLWithString:topicReplies.userphoto] placeholderImage:kCMDefault_imageName];
    _nameLab.text = topicReplies.username;
    _twoContentLab.text = topicReplies.content;
    _timeLab.text = topicReplies.formatdate;
}


- (void)replyIntContent {
    CMTopicReplies *topicReplies = _topicList.repliesArr.firstObject ;
    [_titleImage sd_setImageWithURL:[NSURL URLWithString:topicReplies.userphoto] placeholderImage:kCMDefault_imageName];
    if (topicReplies.username.length > 0) {
        _replyOnlNameLab.text = topicReplies.username;
    } else {
        _replyOnlNameLab.text = @"会员";
    }
    
    _replyOnlContLab.text = topicReplies.content;
    _replyOnlTimeLab.text = topicReplies.formatdate;
    
}
//查看更多
- (IBAction)lockMoreBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_replyTableLockMore:)]) {
        [self.delegate cm_replyTableLockMore:_topicList];
    }
    
}


//回复
- (IBAction)replyBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_replyTableTopicList:)]) {
        [self.delegate cm_replyTableTopicList:_topicList];
    }
}

@end

















