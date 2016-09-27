//
//  CMCommentView.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMCommentView.h"
#import "CMDiscussTableViewCell.h"
#import "CMPingLTableViewCell.h"
#import "CMProductComment.h"
#import "CMProductNotion.h"
#import "CLMNotDataView.h"


@interface CMCommentView ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@end


@implementation CMCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CMCommentView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMCommentView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}
- (void)setCommDataArr:(NSArray *)commDataArr {
    _commDataArr = commDataArr;
    if (commDataArr.count == 0) {
        [self notDataView];
    }
    
    [_curTableView reloadData];
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CMProductNotion *productCom = _commDataArr[indexPath.row];
    CGFloat height = [productCom.title getHeightIncomingWidth:CMScreen_width()-30  incomingFont:14];
    return 63-14 + height;//这个地方需要计算出来高度。因为没数据，就先固定死
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMPingLTableViewCell *pinglunCell = [tableView dequeueReusableCellWithIdentifier:@"CMPingLTableViewCell"];
    if (!pinglunCell) {
        pinglunCell = [CMPingLTableViewCell cell];
    }
    CMProductNotion *productCom = _commDataArr[indexPath.row];
    pinglunCell.productComment = productCom;
    return pinglunCell;
}
//tab didsel
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMProductNotion *productCom = _commDataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(cm_commentViewNotintId:)]) {
        [self.delegate cm_commentViewNotintId:productCom.notionId];
    }
    
}


//没有数据的view
- (UIView *)notDataView {
    CLMNotDataView *dataView = [[CLMNotDataView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), 200)];
    [dataView imageViewImageName:@"" markedWordsStr:@"该产品暂无公告" optionImageStr:@""];
    //dataView.delegate = self;
    if (![dataView superview]) {
        [self addSubview:dataView];
    }
    
    return dataView;
}
@end





















