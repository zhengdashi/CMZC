//
//  CMNewQualityTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMNewQualityTableViewCell.h"
#import "NSMutableAttributedString+AttributedString.h"
#import "CMNewQualityCollectionViewCell.h"



@interface CMNewQualityTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *curCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionFlowLayout;

@property (strong, nonatomic) NSArray *imagedataArr; //背景图片arr
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *upOrFallLab; //涨跌
@property (weak, nonatomic) IBOutlet UILabel *dataLab; //日期
@property (weak, nonatomic) IBOutlet UILabel *startLab; //起步


@end

@implementation CMNewQualityTableViewCell

#pragma mark - 数据请求

- (void)awakeFromNib {
   
    _collectionFlowLayout.itemSize = CGSizeMake(CMScreen_width()/3*2, 149);
    _curCollectionView.delegate = self;
    _curCollectionView.dataSource = self;
    
    
}
- (void)setMunyArr:(NSArray *)munyArr {
    _munyArr = munyArr;
    [_curCollectionView reloadData];
}


#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.munyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMNewQualityCollectionViewCell *qualityCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMNewQualityCollectionViewCell" forIndexPath:indexPath];
    
    //没有数据。要显示数据
    qualityCell.dataArray = @[@""];
    
    [qualityCell cm_newQualityCellClass:self.munyArr[indexPath.row] bgImageArr:self.imagedataArr[indexPath.row]];
    
    return qualityCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CMNumberous *numberous = self.munyArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(cm_newQualityProductId:)]) {
        //这里估计要穿id 因为没有借口，没有数据。猜测是这样的。等到来了数据再改
        [self.delegate cm_newQualityProductId:[numberous.berId integerValue]];
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - set get
- (NSArray *)imagedataArr {
    return @[@"many_one_home",
             @"many_three_home",
             @"many_two_home"];
}


@end





























