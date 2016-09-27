//
//  CMMyHoldTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMAccountinfo.h"

@class CMMyHoldTableViewCell;
@protocol CMMyHoldTableViewDelegate <NSObject>

- (void)cm_holdTableView:(CMMyHoldTableViewCell *)holdCell;

@end


@interface CMMyHoldTableViewCell : UITableViewCell

@property (nonatomic,assign) id<CMMyHoldTableViewDelegate>delegate;

@property (strong, nonatomic) CMAccountinfo *tinfo;

+ (instancetype)cell;

@end
