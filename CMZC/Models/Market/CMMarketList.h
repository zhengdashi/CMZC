//
//  CMMarketList.h
//  CMZC
//
//  Created by 财猫 on 16/4/15.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMarketList : NSObject

@property (nonatomic,copy) NSString *PCode; //产品代码
@property (nonatomic,copy) NSString *PName; //产品名称
@property (nonatomic,copy) NSString *ClosePrice; //现价
@property (nonatomic,copy) NSString *range; //涨跌幅
@property (nonatomic,copy) NSString *upFall; //判断涨跌幅


@end
