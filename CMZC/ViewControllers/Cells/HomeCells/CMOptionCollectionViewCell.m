//
//  CMOptionCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/4/6.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMOptionCollectionViewCell.h"

@interface CMOptionCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


@implementation CMOptionCollectionViewCell

- (void)cm_optionCollectionCellTitleImageName:(NSString *)titleName nameLabStr:(NSString *)nameStr {
    _titleImage.image = [UIImage imageNamed:titleName];
    _nameLab.text = nameStr;
}

@end
