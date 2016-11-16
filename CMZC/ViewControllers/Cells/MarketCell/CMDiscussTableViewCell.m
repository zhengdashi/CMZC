//
//  CMDiscussTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMDiscussTableViewCell.h"
#import "CMProductComment.h"

@interface CMDiscussTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeDateLab;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;

@end

@implementation CMDiscussTableViewCell



- (void)awakeFromNib {
     
     [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setNotion:(CMProductComment *)notion {
    _notion = notion;
    _titleLab.text = notion.content;
    _timeDateLab.text = notion.created;
    _titleNameLab.text = notion.title;
}


+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMDiscussTableViewCell" owner:nil options:nil].firstObject;
}

@end
