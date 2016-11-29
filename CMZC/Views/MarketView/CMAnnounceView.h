//
//  CMAnnounceView.h
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  通告

#import <UIKit/UIKit.h>

@class CMProductComment;

@protocol CMCommentViewDelegate <NSObject>

- (void)cm_commentViewProductNotion:(CMProductComment *)product;

@end
@interface CMAnnounceView : UIView

@property (strong, nonatomic) NSArray   *anounDataArr;
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (nonatomic,assign)id<CMCommentViewDelegate>delegate;
@end
