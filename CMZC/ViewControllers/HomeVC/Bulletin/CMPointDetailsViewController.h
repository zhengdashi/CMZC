//
//  CMPointDetailsViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/23.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  观点

#import "CMBaseViewController.h"
#import "CMAnalystPoint.h"
#import "CMAnalystMode.h"

@interface CMPointDetailsViewController : CMBaseViewController

@property (strong, nonatomic) CMAnalystPoint *point;

@property (strong, nonatomic) CMAnalystMode *analyst;

@end
