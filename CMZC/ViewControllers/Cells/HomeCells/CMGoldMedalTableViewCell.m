//
//  CMGoldMedalTableViewCell.m
//  CMZC
//
//  Created by 郑浩然 on 16/12/24.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMGoldMedalTableViewCell.h"
#import "CMAdministrator.h"


@interface CMGoldMedalTableViewCell () {
    NSInteger _analystsIndex;//分析师id
}
//金牌分析师
@property (weak, nonatomic) IBOutlet UIImageView *analystsTitleImage; //头像
@property (weak, nonatomic) IBOutlet UILabel *analystsTitleName; //名字
@property (weak, nonatomic) IBOutlet UILabel *analystsType; //观点
@property (weak, nonatomic) IBOutlet UILabel *analystsAnswer; //回答数
@property (weak, nonatomic) IBOutlet UILabel *analystsViewPoint; //观点


@property (weak, nonatomic) IBOutlet UIImageView *goldTitleImage;
@property (weak, nonatomic) IBOutlet UILabel *goldTitleName;
@property (weak, nonatomic) IBOutlet UILabel *goldType;
@property (weak, nonatomic) IBOutlet UILabel *goldMonery;
@property (weak, nonatomic) IBOutlet UILabel *goldProject;

@end

@implementation CMGoldMedalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGlodServiceArr:(NSArray *)glodServiceArr {
    CMAdministrator *adminis = glodServiceArr.firstObject;
    _analystsIndex = [adminis.adminId integerValue];
    [_analystsTitleImage sd_setImageWithURL:[NSURL URLWithString:adminis.imageUrl] placeholderImage:[UIImage imageNamed:@"title_log"]];
    _analystsTitleName.text = adminis.name;
    _analystsType.text = adminis.type;
    _analystsAnswer.text = adminis.data1;
    _analystsViewPoint.text = adminis.data2;
    
    CMAdministrator *goldDdminis = glodServiceArr.lastObject;
    [_goldTitleImage sd_setImageWithURL:[NSURL URLWithString:goldDdminis.imageUrl] placeholderImage:[UIImage imageNamed:@"title_log"]];
    _goldTitleName.text = goldDdminis.name;
    _goldType.text = goldDdminis.type;
    _goldMonery.text = [self roundFloatDisplay:[goldDdminis.data1 floatValue]];
    _goldProject.text = goldDdminis.data2;
    
}
//分析师
- (IBAction)analystsBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_goldMedalAnalystsId:)]) {
        [self.delegate cm_goldMedalAnalystsId:_analystsIndex];
    }
}
/**
 *  格式化float，显示单位，保留2位小数
 *
 *  @return 格式化后的字符串
 */
- (NSString *)roundFloatDisplay:(CGFloat)value{
    
    NSString *unit = @"";
    if (value >=1000000 ) {
        value /= 1000000.0;
        unit = @"百万";
    } else if (value >= 10000) {
        value /= 10000.0;
        unit = @"万";
    }
    
    if ([unit isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%.2f",value];
    }
    return [NSString stringWithFormat:@"%.2f%@",value,unit];
}


@end































