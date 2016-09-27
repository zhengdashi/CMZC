//
//  CMTradeSonInterfaceController.h
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  交易子界面。

#import "CMBaseViewController.h"

#import "CMAccountinfo.h"

@interface CMTradeSonInterfaceController : CMBaseViewController

@property (nonatomic,assign) NSInteger  itemIndex;

@property (nonatomic,copy) NSString  *codeStr;

@property (strong, nonatomic) CMAccountinfo *tinfo;

@end
