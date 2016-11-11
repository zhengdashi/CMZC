//
//  CMInvestorsView.m
//  CMZC
//
//  Created by 郑浩然 on 16/10/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMInvestorsView.h"

@interface CMInvestorsView ()
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@end


@implementation CMInvestorsView
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CMInvestorsView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMInvestorsView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

@end
