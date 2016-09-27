//
//  CMMediaNewsView.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  媒体报道

#import <UIKit/UIKit.h>

@protocol CMMediaNewsViewDelegate <NSObject>
/**
 *  传给vc一个webURL
 *
 *  @param webURL weburl
 */
- (void)cm_mediaNewsViewSendWebURL:(NSString *)webURL;

@end

@interface CMMediaNewsView : UIView

@property (nonatomic,assign)id<CMMediaNewsViewDelegate>delegate;

@end
