//
//  CMTimer.m
//  CMZC
//
//  Created by 财猫 on 16/5/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTimer.h"

@interface CMTimer ()
/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (strong, nonatomic) dispatch_source_t timer;

@end

@implementation CMTimer

- (instancetype)initTimerInterval:(NSInteger)inter {
    self = [super init];
    if (self) {
        [self openCMTimer:inter];
    }
    return self;
}
- (void)openCMTimer:(NSInteger)inter {
    // 1、获得队列
    //    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2、创建一个定时器 (dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 3、设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    
    // 触发时间（何时开始执行第一个任务）
    // 比当前时间晚1秒
    dispatch_time_t start =
    dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    // 马上就执行
    //  dispatch_time_t start1 = DISPATCH_TIME_NOW;
    
    // 时间间隔。GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
    uint64_t interval = (uint64_t)(inter * NSEC_PER_SEC);
    
    // 设置定时器的各种属性：比当前时间晚1秒开始，每隔1s 执行一次
    // 参数：（1）定时器名字 （2）触发时间 （3）时间间隔 （4）0
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    // 4、设置定时器的内部回调
    dispatch_source_set_event_handler(self.timer, ^{
        
        self.timerMinblock();
     
    });
    
    // 5、启动定时器
    dispatch_resume(self.timer);
}
//取消定时器
- (void)close {
    // 取消定时器
    dispatch_cancel(self.timer);
    self.timer = nil;
}

@end






















