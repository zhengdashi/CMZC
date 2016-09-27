//
//  CMProductDetailsViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  产品详情cell

#import "CMBaseViewController.h"



@interface CMProductDetailsViewController : CMBaseViewController
@property (nonatomic,copy) NSString *productId;//行情id

@property (nonatomic,copy) NSString *titleName;
@property (nonatomic,copy) NSString *codeName;


@end
