//
//  CMOptionTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMOptionTableViewCell.h"
#import "CMOptionCollectionViewCell.h"

@interface CMOptionTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;//注册
@property (weak, nonatomic) IBOutlet UIButton *optionalBtn; //自选
@property (weak, nonatomic) IBOutlet UIButton *analystBtn; //分析师
@property (weak, nonatomic) IBOutlet UIButton *noticeBtn; //公告
@property (weak, nonatomic) IBOutlet UIButton *raiseMoneyBtn; //众筹宝
@property (weak, nonatomic) IBOutlet UIButton *moreBtn; //更多

@property (weak, nonatomic) IBOutlet UICollectionView *curCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionflowLayout;

@property (strong, nonatomic) NSArray *titImageArr; //图片名字
@property (strong, nonatomic) NSArray *titLabNameArr;  //介绍名字

@end


@implementation CMOptionTableViewCell

- (void)awakeFromNib {
    // Initialization code
   //注册
    _collectionflowLayout.itemSize = CGSizeMake(CMScreen_width()/3, 100);
    _curCollectionView.delegate = self;
    _curCollectionView.dataSource = self;
    
    
    
    /*
    if (CMIsLogin()) {
        
    } else {
        
    }
    
    [_registerBtn cm_setButtonRevealStyleImageName:@"register_home" titleName:@"注册"];
    [_optionalBtn cm_setButtonRevealStyleImageName:@"optional_home" titleName:@"自选"];
    [_analystBtn cm_setButtonRevealStyleImageName:@"analys_home" titleName:@"分析师"];
    [_noticeBtn cm_setButtonRevealStyleImageName:@"notice_home" titleName:@"公告"];
    [_raiseMoneyBtn cm_setButtonRevealStyleImageName:@"many_home" titleName:@"众筹宝"];
    [_moreBtn cm_setButtonRevealStyleImageName:@"more_home" titleName:@"更多"];
    */
}
#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMOptionCollectionViewCell *optionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMOptionCollectionViewCell" forIndexPath:indexPath];
    [optionCell cm_optionCollectionCellTitleImageName:self.titImageArr[indexPath.row]
                                           nameLabStr:self.titLabNameArr[indexPath.row]];
    return optionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(cm_optionTableViewCellButTag:)]) {
        [self.delegate cm_optionTableViewCellButTag:indexPath.row];
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)leapTransferButClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_optionTableViewCellButTag:)]) {
        [self.delegate cm_optionTableViewCellButTag:sender.tag];
    }
}

#pragma mark - set get
- (NSArray *)titImageArr {
    return @[@"register_home",
             @"optional_home",
             @"analys_home",
             @"notice_home",
             @"many_home",
             @"more_home"];
}
- (NSArray *)titLabNameArr {
    return @[ CMIsLogin()?@"我的账户":@"注册/登录",
             @"自选",
             @"分析师",
             @"公告",
             @"众筹宝",
             @"更多"];
}

@end
