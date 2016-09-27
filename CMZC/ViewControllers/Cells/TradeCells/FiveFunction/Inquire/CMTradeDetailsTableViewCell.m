//
//  CMTradeDetailsTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeDetailsTableViewCell.h"


@interface CMTradeDetailsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailsLab;

@end

@implementation CMTradeDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)cm_tradeDetailsTitleName:(NSString *)name detailsName:(NSString *)details {
    _titleNameLab.text = name;
    _detailsLab.text = details;
}


@end
