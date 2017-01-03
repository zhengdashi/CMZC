//
//  CMProductDetailsTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  产品详情cell

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CMProductOptionType){
    CMProductOptionTypeAddOption, //添加自选
    CMProductOptionTypeDeleteOption, //删除自选
    CMProductOptionTypeShow //点击了展示按钮
};


//不用了
typedef void(^CMProductBlock)();
@class CMProductDetailsTableViewCell;

@protocol CMProductDetailsDelegate <NSObject>

- (void)cm_productDetailsViewCell:(CMProductDetailsTableViewCell *)product;
/**
 *  添加自选 删除自选
 *
 *  @param type 枚举参数
 */
- (void)cm_productOptionType:(CMProductOptionType)type;

@end


@interface CMProductDetailsTableViewCell : UITableViewCell

@property (strong, nonatomic) NSArray *productArr;

@property (nonatomic,copy) NSString *productCode;

@property (nonatomic,assign) id<CMProductDetailsDelegate> delegate;

@property (nonatomic,copy) CMProductBlock block;

@property (nonatomic,assign) CMProductOptionType type;

@end
