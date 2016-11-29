//
//  CMAnnounceView.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAnnounceView.h"
#import "CMDiscussTableViewCell.h"
#import "CMProductComment.h"
#import "CMAnalystPoint.h"
#import "CLMNotDataView.h"


@interface CMAnnounceView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation CMAnnounceView


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CMAnnounceView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMAnnounceView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

- (void)setAnounDataArr:(NSArray *)anounDataArr {
    _anounDataArr = anounDataArr;
    if (anounDataArr.count == 0) {
        [self notDataView];
    }
    
    [_curTableView reloadData];
}


#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _anounDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMAnalystPoint *notion = _anounDataArr[indexPath.row];
    CGFloat height = [notion.content getHeightIncomingWidth:CMScreen_width()-30 incomingFont:14];
    if (height>34) {
        height = 34;
    }
    CGFloat titHeight = 64;
    if (notion.title.length > 1) {
        titHeight = 80;
    }
    return titHeight-17 + height+16;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMDiscussTableViewCell *discussCell = [tableView dequeueReusableCellWithIdentifier:@"CMDiscussTableViewCell"];
    if (!discussCell) {
        discussCell = [CMDiscussTableViewCell cell];
    }
    discussCell.notion = _anounDataArr[indexPath.row];
    discussCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return discussCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(cm_commentViewProductNotion:)]) {
        [self.delegate cm_commentViewProductNotion:_anounDataArr[indexPath.row]];
    }
}

//没有数据的view
- (UIView *)notDataView {
    CLMNotDataView *dataView = [[CLMNotDataView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), 200)];
    [dataView imageViewImageName:@"" markedWordsStr:@"该产品暂无评论" optionImageStr:@""];
    //dataView.delegate = self;
    if (![dataView superview]) {
        [self addSubview:dataView];
    }
    
    return dataView;
}
@end
