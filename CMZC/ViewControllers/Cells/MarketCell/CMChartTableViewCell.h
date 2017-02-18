//
//  CMChartTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/15.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  折线图cell

#import <UIKit/UIKit.h>

@protocol  CMChartTableViewCellDelegate<NSObject>



@end


@interface CMChartTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *code;

@property (strong, nonatomic) NSArray *productArr;

@end
