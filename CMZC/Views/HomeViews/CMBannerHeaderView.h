//
//  CMBannerHeaderView.h
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  home表头

#import <UIKit/UIKit.h>

typedef void (^BannerDidSelectedBlock)(NSString *link);

@interface CMBannerHeaderView : UIView

@property (nonatomic, copy) NSArray *banners;//数据源

@property (nonatomic, copy) BannerDidSelectedBlock didSelectedBlack;//回调

+ (CMBannerHeaderView *)bannerHeaderViewWithBanners:(NSArray *)banners ;

- (void)restartScrollBanner;//开启定时器

- (void)stopScrollBanner;//关闭定时器


@end
