//
//  CMFunctionTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMFunctionTableViewCell.h"

@interface CMFunctionTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@end


@implementation CMFunctionTableViewCell

- (void)awakeFromNib {
     
     [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cm_functionTileLabNameStr:(NSString *)titName titleImageName:(NSString *)imgName {
    _nameLab.text = titName;
    _titleImage.image = [UIImage imageNamed:imgName];
}



@end
