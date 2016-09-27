//
//  CMModules_Header.h
//  CMZC
//
//  Created by 财猫 on 16/4/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#ifndef CMModules_Header_h
#define CMModules_Header_h
#define kCMTableFoot_isPage NSInteger total = [responseObject[@"data"][@"total"] integerValue];\
BOOL isPage = NO;\
if (page * 10 < total) {\
    isPage = YES;\
}

#endif /* CMModules_Header_h */
