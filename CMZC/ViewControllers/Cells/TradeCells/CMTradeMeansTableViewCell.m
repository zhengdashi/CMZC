//
//  CMTradeMeansTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeMeansTableViewCell.h"
#import "CMTradeCollectionViewCell.h"

@interface CMTradeMeansTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    
}
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *contView;

@property (strong, nonatomic) NSArray *itemDataArr; //名字arr
@property (strong, nonatomic) NSArray *introduceDataArr;//介绍arr
@property (strong, nonatomic) NSArray *itemImageDataArr; //图片arr

@end


@implementation CMTradeMeansTableViewCell

- (void)awakeFromNib {
    // Initialization code
    // 1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置每个格子的尺寸
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2 ,60);
    // 3.设置整个collectionView的内边距
    //    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 4.设置每一行之间的间距
    layout.minimumLineSpacing = 0.5;
    // 设置cell之间的间距
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 185) collectionViewLayout:layout];
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = [UIColor cmBackgroundGrey];
    
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"CMTradeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CMTradeCollectionViewCell"];
    [self addSubview:_collectionView];

    
    
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
            }
    return self;
}
- (void)initLayoutSubviews {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setInfo:(CMAccountinfo *)info {
    _info = info;
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMTradeCollectionViewCell *serverCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMTradeCollectionViewCell" forIndexPath:indexPath];
    [serverCell cm_tradeCollectionNameStr:self.itemDataArr[indexPath.row]
                             introduceStr:self.introduceDataArr[indexPath.row]
                           titleImageName:self.itemImageDataArr[indexPath.row]];
    return serverCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!CMIsLogin()) {
        [self.delegate cm_tradeMeadsTableViewIndex:100];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(cm_tradeMeadsTableViewIndex:)]) {
        [self.delegate cm_tradeMeadsTableViewIndex:indexPath.row];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - set get 
//名字
- (NSArray *)itemDataArr {
    return @[@"买入",
             @"卖出",
             @"持有",
             @"撤单",
             @"查询",
             @"自选"];
}
//头像图片
- (NSArray *)itemImageDataArr {
    return @[@"buying_trade",
             @"sale_trade",
             @"hold_trade",
             @"remove_trade",
             @"query_trade",
             @"option_trade"];
}
//详情
- (NSArray *)introduceDataArr {
    return @[@"买入产品",
             @"卖出持有产品",
             @"查看实时盈亏",
             @"撤销委托单",
             @"查询历史交易",
             @"查看自选产品"];
}
@end
