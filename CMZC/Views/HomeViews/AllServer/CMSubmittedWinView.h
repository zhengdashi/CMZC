//
//  CMSubmittedWinView.h
//  CMZC
//
//  Created by 郑浩然 on 16/12/27.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CMSubmittedBlock)();

@interface CMSubmittedWinView : UIView

@property (nonatomic,copy) CMSubmittedBlock block;

@end
