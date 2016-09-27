//
//  CMAnalystAnswerView.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  分析师详情   -- 回答

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CMAnalystAnswerType) {
    CMAnalystAnswerTypeOld,//上划
    CMAnalystAnswerBlockNew //下拉
};

typedef void(^CMAnalystAnswerBlock)(CMAnalystAnswerType);

typedef void(^CMAnalystTopicIdBlock)(NSInteger topicId);



@interface CMAnalystAnswerView : UIView

@property (nonatomic,assign) BOOL isAnimating;

@property (nonatomic,copy) CMAnalystAnswerBlock block; //上啦下滑

@property (nonatomic,copy) CMAnalystTopicIdBlock topicBlock; //点击回复的时候

@property (nonatomic,assign) NSInteger analystId;//分析师id

@property (strong, nonatomic) NSArray *replyArr;

@end
