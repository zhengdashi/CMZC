//
//  CMMarketTitleView.h
//  CMZC
//
//  Created by 财猫 on 16/4/19.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CMMarketTitleViewBlock)(NSInteger sender);

@interface CMMarketTitleView : UIView

@property (nonatomic,copy) CMMarketTitleViewBlock marketBlock;

@property (strong, nonatomic) NSArray *titleArr;

@end
