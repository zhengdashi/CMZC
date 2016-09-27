//
//  CMFunctionTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  交易下方的五个cell

#import <UIKit/UIKit.h>

@interface CMFunctionTableViewCell : UITableViewCell
/**
 *  传入数据
 *
 *  @param titName 名字lab
 *  @param imgName 图片的名字
 */
- (void)cm_functionTileLabNameStr:(NSString *)titName
                   titleImageName:(NSString *)imgName;
@property (weak, nonatomic) IBOutlet UIImageView *tradeImage;

@end
