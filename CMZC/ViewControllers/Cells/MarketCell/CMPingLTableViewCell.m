//
//  CMPingLTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMPingLTableViewCell.h"
#import "CMProductNotion.h"


@interface CMPingLTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeDateLab;

@end


@implementation CMPingLTableViewCell

- (void)awakeFromNib {
     
     [super awakeFromNib];
}

- (void)setCommDataArr:(NSArray *)commDataArr {
    _commDataArr = commDataArr;
    
    
}

- (void)setProductComment:(CMProductNotion *)productComment {
    _productComment = productComment;
    _contentLab.text = _productComment.title; //
    _timeDateLab.text = _productComment.created;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"CMPingLTableViewCell" owner:nil options:nil].firstObject;
}

@end
