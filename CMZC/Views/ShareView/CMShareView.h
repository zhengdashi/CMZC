//
//  CMShareView.h
//  CMZC
//
//  Created by 郑浩然 on 17/1/10.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMShareView : UIView

@property (nonatomic,copy) NSString *contentUrl; //分享链接
@property (nonatomic,copy) NSString *titleConten; //标题
@property (nonatomic,copy) NSString *contentStr; //n内容

- (void)remove;
@end
