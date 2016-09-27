//
//  CMSubscribeGuideTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubscribeGuideTableViewCell.h"

@interface CMSubscribeGuideTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;//提示lab
@property (weak, nonatomic) IBOutlet UILabel *detailsLab;//介绍lab

@end


@implementation CMSubscribeGuideTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)cm_subscribeGuideTitleName:(NSString *)titleName detailsStr:(NSString *)details {
    _titleLab.text = titleName;
    _detailsLab.text = details;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
