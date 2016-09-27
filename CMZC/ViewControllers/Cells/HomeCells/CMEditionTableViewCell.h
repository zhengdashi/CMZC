//
//  CMEditionTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  版块儿

#import <UIKit/UIKit.h>

@protocol CMEditionTableViewCellDelegate <NSObject>
/**
 *  传一个产品的id过去。
 *
 *  @param productId 产品id
 */
- (void)cm_editionTableViewProductId:(NSString *)productId nameTitle:(NSString *)name;

@end

@interface CMEditionTableViewCell : UITableViewCell
@property (assign, nonatomic)id<CMEditionTableViewCellDelegate>delegate;

@property (strong, nonatomic) NSArray *prictArr;


@end
