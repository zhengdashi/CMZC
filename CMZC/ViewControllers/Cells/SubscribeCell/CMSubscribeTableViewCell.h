//
//  CMSubscribeTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  申购cell

#import <UIKit/UIKit.h>

@class CMProductList;
@class CMPurchaseProduct;


@interface CMSubscribeTableViewCell : UITableViewCell

//@property (strong, nonatomic) CMProductList *product;

@property (strong, nonatomic) CMPurchaseProduct *product;

@end
