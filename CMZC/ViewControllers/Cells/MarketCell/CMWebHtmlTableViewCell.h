//
//  CMWebHtmlTableViewCell.h
//  CMZC
//
//  Created by 郑浩然 on 17/1/7.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CMWEbHtmlBlock)();

@interface CMWebHtmlTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *htmlString;

@property (nonatomic,copy) CMWEbHtmlBlock block;

@end
