//
//  CMCommentTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMCommentTableViewCell.h"
#import "CMTitleView.h"
#import "CMAnnounceView.h"
#import "CMCommentView.h"
#import "CMBusinessNewsView.h"
#import "CMProductNotion.h"
#import "CMProductComment.h"


@interface CMCommentTableViewCell ()<TitleViewDelegate,CMCommentViewDelegate,CMCommentDelegate>
@property (weak, nonatomic) IBOutlet CMTitleView *titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;
@property (weak, nonatomic) IBOutlet CMAnnounceView *announceView;//公告
@property (weak, nonatomic) IBOutlet CMCommentView *commentView; //评论
@property (weak, nonatomic) IBOutlet CMBusinessNewsView *businessView;//企业信息


@end

@implementation CMCommentTableViewCell

- (void)awakeFromNib {
     
     [super awakeFromNib];
    _announceView.delegate = self;
    _commentView.delegate = self;
    __weak typeof(self) weakSelef = self;
    _titleView.block = ^void(NSInteger index) {
        if (index == 3) {
            //点击详情
            if ([weakSelef.delegate respondsToSelector:@selector(cm_commentCellSkipBoundary)]) {
                [weakSelef.delegate cm_commentCellSkipBoundary];
            }
        } else {
            //点击评论 公告 企业信息 
            CGRect rect = CGRectMake(index *CGRectGetWidth(_curScrollView.frame), 0, CGRectGetWidth(_curScrollView.frame), CGRectGetHeight(_curScrollView.frame));
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                [_curScrollView scrollRectToVisible:rect animated:NO];
            } completion:^(BOOL finished) {
            }];
            switch (index) {
                case 0:
                {//评论
                    [self requestComments];
                }
                    break;
                case 1:
                {//公告
                    [self requestAnnouncement];
                }
                    break;
                case 2:
                {//企业信息
                    [self requestEnterprise];
                }
                    
                default:
                    break;
            }
        }
    };
}
- (void)setCode:(NSString *)code {
    _code = code;
    [self requestComments];
}

//评论
- (void)requestComments {
    [CMRequestAPI cm_homeFetchAnswerPointAnalystId:0 pcode:[_code integerValue] pageIndex:1 success:^(NSArray *pointArr, BOOL isPage) {
        self.announceView.anounDataArr = pointArr;
    } fail:^(NSError *error) {
        MyLog(@"行情评论信息请求是吧");
    }];
}

//公告
- (void)requestAnnouncement {
    [CMRequestAPI cm_marketFetchProductNoticePCode:_code pageIndex:1 success:^(NSArray *noticeArr) {
        self.commentView.commDataArr = noticeArr;
    } fail:^(NSError *error) {
        MyLog(@"行情公告信息请求失败");
    }];
    
    
}
#pragma mark - CMCommentViewDelegate
- (void)cm_commentViewProductNotion:(CMProductComment *)product {
    if ([self.delegate respondsToSelector:@selector(cm_commentViewControllProductNotion:)]) {
        [self.delegate cm_commentViewControllProductNotion:product];
    }
}
#pragma mark - CMCommentDelegate
- (void)cm_commentViewNotintId:(NSInteger)notint {
    if ([self.delegate respondsToSelector:@selector(cm_commentNoticeViewNoticeId:)]) {
        [self.delegate cm_commentNoticeViewNoticeId:notint];
    }
    
}
//企业信息
- (void)requestEnterprise {
    //_businessView.webStr = @"http://zcapi.58cm.com/api/product/context/800082";
    [CMRequestAPI cm_tradeFetchProductContextPcode:[_code integerValue] success:^(NSString *dataStr) {
        _businessView.webStr = dataStr;
    } fail:^(NSError *error) {
        
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
