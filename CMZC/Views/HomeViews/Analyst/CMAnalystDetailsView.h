//
//  CMAnalystDetailsView.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  分析师详情view

#import <UIKit/UIKit.h>
#import "CMAnalystMode.h"



typedef void(^CMAnalystDetailsBlock)(BOOL isOpt,CGFloat height);
typedef void(^CMAnalystDetailsConsultingBlock)();


@interface CMAnalystDetailsView : UIView

@property (nonatomic,copy) CMAnalystDetailsBlock analystBlock;

@property (nonatomic,copy) CMAnalystDetailsConsultingBlock consultingBlock;

@property (strong, nonatomic) CMAnalystMode *analyst;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightLayoutConstraint;

@end
